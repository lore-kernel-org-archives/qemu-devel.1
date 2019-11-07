Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC45C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707C72178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707C72178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iShFa-0005lV-MY
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iShEz-0005H5-2y
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iShEy-0001uj-0Q
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:50:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iShEx-0001uR-Of
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:50:19 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC9DB87648
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 12:50:18 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id p6so929580wrs.5
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 04:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kVgfPlYydicQ5SKetqQYPSzgekgXDmG/sapQRF3FzNg=;
 b=LD3UfnP7EkjyPWQztOcjshH3a+SY1rY0SSlv6yg6hxwcDwYJ65i86YkZTW8fU9sm8h
 7xsN9V/gnB91ovo8LQh1wRz/RCWQSHEUjGdBlLsgNZ+LmFIywuECy5t/mCvL99vPUoNP
 uoybXFzhviLmDiW8BHFEtk1nvzn0QVY0MAdt95tI0CiORglOAq9WSaEFUk89CSsc8PJe
 NzIkYtON39jik/4zWFKOluROndMWwMgvmbsLGMimZu7e2aD8PG523plweTtaPUr/tQzv
 iMm2ycjm0npQkq81Xj0YVZqTXdy+7SdY1Apn6/A2KZJOIjJ8uHImDOMvuqc0pQt6MMTj
 /Xlw==
X-Gm-Message-State: APjAAAX0z9ea5LIdQnYIb652D1eZQuqYYNUzrgmFTSwFCPeF3pe3CqI2
 uMN8uCUDfFM3aJYnaVMwM84lvI5md9ReAhv/c+eiypnewuVs001/ZQMBXmu6kEF9L8kFsvUo3hl
 9po5IU2citCtQGBA=
X-Received: by 2002:a1c:7304:: with SMTP id d4mr2728946wmb.66.1573131017411;
 Thu, 07 Nov 2019 04:50:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhyWwB78qp5lsWDmQDiLnW0yIY6Px1QzD806E1/7D3kYUHxlbzABegfw+R/q7QxQ6MQtW9og==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr2728914wmb.66.1573131017117;
 Thu, 07 Nov 2019 04:50:17 -0800 (PST)
Received: from [10.201.49.199] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id w4sm1890935wmk.29.2019.11.07.04.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 04:50:16 -0800 (PST)
Subject: Re: privileged entropy sources in QEMU/KVM guests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <03e769cf-a5ad-99ce-cd28-690e0a72a310@redhat.com>
 <CAKv+Gu8gqfu_mOm2zK64dmj5CkVaPvix3gEMEFQScyk1CnOv6w@mail.gmail.com>
 <ef126cd5-7b64-1b8a-ca74-11bd06b5f4b1@redhat.com>
 <20191107115511.GE120292@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <19fc6a42-e773-f8b8-db4a-c8ed853da30c@redhat.com>
Date: Thu, 7 Nov 2019 13:50:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191107115511.GE120292@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Jian J Wang <jian.j.wang@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Bret Barkelew <Bret.Barkelew@microsoft.com>,
 qemu devel list <qemu-devel@nongnu.org>, Erik Bjorge <erik.c.bjorge@intel.com>,
 Sean Brogan <sean.brogan@microsoft.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/19 12:55, Daniel P. Berrang=C3=A9 wrote:
>> Yes, I would make SMM use a cryptographic pseudo-random number generat=
or=20
>> and seed it from virtio-rng from DXE, way before the OS starts and can=
=20
>> "attack" it.
>>
>> Once you've gotten a seed, you can create a CSPRNG with a stream ciphe=
r=20
>> such as ChaCha20, which is literally 30 lines of code.
> If all we need is a one-time seed then virtio-rng is possibly overkill =
as
> that provides a continuous stream. Instead could QEMU read a few bytes
> from the host's /dev/urandom and pass it to EDK via fw_cfg, which can
> use it for the CSPRNG seed. EDK would have to erase the fw_cfg field
> to prevent the seed value leaking to the guest OS, but other than that
> its quite straightforward.

That would need anyway a change to the emulated hardware.  If the guest
is able to use virtio-rng after the firmware exits (which is the case is
all the firmware needs is a one-time seed), then using virtio-rng is the
simplest alternative as it needs no change at all outside the firmware.

Paolo

