Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84297C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5C9206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkZnREJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5C9206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCr8-0005Yh-GO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icBvN-0003tI-Iz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icBvH-0006U0-0Q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:25:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icBvF-0006Em-Pe
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575393911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1J1Kl+q/CRG787LvigYLnWHm0AYWLh5oUtZd7AgZcVs=;
 b=fkZnREJ0h+3eE4XAIvKPpaPVoY2OEI63fD6oUPh+FHQHhB0eRXRWGyysBnNDXWhJy1u+oR
 0mxmvBBJnfFJViHqJlBuu6k6ZVulGP3zRtq+P+B8lxgvrkgQn8QfBgIAE5uqNr+NF4bpbZ
 2Bfd0oP/foJSOqJHE69upT2G0PacPUQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-1vASg1HcONOFBEnvYCG-Tw-1; Tue, 03 Dec 2019 12:25:10 -0500
Received: by mail-wm1-f71.google.com with SMTP id l11so1717799wmi.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 09:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7CuF5Q1zTSf24JIN3PceUYrH8QE2l/fjhwv0ukJiPNY=;
 b=KJc3VpF8QRpD+VSRJ+57LMuIVLkCU2mAHpfhDRPPergTY7Qc2MDN8uqS1sKSIbNaEB
 E3c/2lkip9sRwzSJjEIY6G8/qYOd4aH1oftegrcbaHKQePhtotC6s7DDDX0crWNTe8jW
 MjcumqRDAuvMeIDsl71VkTFAX/zsMi4FYWbRcTZgXxY9RkquXxjJ+AMTykmqCOXQppuO
 X0CYpQQkU8L2uljj/UZdnqRLCV+1c9dOj+7zOULqqD0k6oEnFAGtBE2nPKq5LKYKczTq
 d4DcKDGSkBoUMc/a0UYF6Wbno3RqMZctZO+adEY5Aqlz+eX2qBqnxbaw0A/tMqY1Eur6
 ZdIg==
X-Gm-Message-State: APjAAAWHWgzyxFy5/5OWJ5VcBUKLOW/i1b01R6yr5h4J6Vkd8vFAd9E+
 4bO34/0P13AbQRSImqBPG8C4wKp4sA/OQyP5GR4VZwGV2hxq+fBmkVdQWsgTQLUJN3ATTo6MNPJ
 mmeiGFkpkizPxfOQ=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr34769621wmk.77.1575393909082; 
 Tue, 03 Dec 2019 09:25:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxznplZaa6NFxdnIdAB82mSu9AowNwi7bLDHFqQIN4ILcjw7sOaNathmT7uw+bqc7Y6VGLa/Q==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr34769595wmk.77.1575393908856; 
 Tue, 03 Dec 2019 09:25:08 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id a186sm3638768wmd.41.2019.12.03.09.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 09:25:08 -0800 (PST)
Subject: Re: [PATCH 0/4] python/qemu: New accel module and improvements
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20191115180829.10275-1-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3dabd1f-8e28-2a89-8c81-3fde07af5779@redhat.com>
Date: Tue, 3 Dec 2019 18:25:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191115180829.10275-1-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: 1vASg1HcONOFBEnvYCG-Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, alex.bennee@linaro.org, jsnow@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 7:08 PM, Wainer dos Santos Moschetta wrote:
> On commit abf0bf998dcb John Snow moved some code out of __init__.py
> to machine.py. kvm_available() remained in though. So on patch 01
> I continue his work by creating a home for that method (the new
> 'accel' module). Honestly I was unsure about whether move the code
> to any existing module or make a new, but since I am adding more
> methods related with accelerators then I thought they would
> deserve a module.
>=20
> The patches 02-04 introduce new helpers and make improvements. Later
> I intend to use those methods on the acceptance tests such as
> to automatically set the accelerator in QEMUMachine VM via Avocado
> tags, and skip the test if the accelerator is not available.
>=20
> Git:
>   - Tree: https://github.com/wainersm/qemu
>   - Branch: python_accel
>=20
> CI:
>   - Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/612382935
>     Non-related fail due build timeout
>=20
> Wainer dos Santos Moschetta (4):
>    python/qemu: Move kvm_available() to its own module
>    python/qemu: accel: Add list_accel() method
>    python/qemu: accel: Strengthen kvm_available() checks
>    python/qemu: accel: Add tcg_available() method

No more comment that what Alex said, I'd move the logging import in=20
patch #2 where you use LOG.
With Alex comment fixed:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


