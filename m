Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A54C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275FE2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275FE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPrx-00028Z-AP
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHPqB-00014f-BH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHPq9-00069v-Gu
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHPq7-00068Q-Br
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:02:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA6FF64040
 for <qemu-devel@nongnu.org>; Mon,  7 Oct 2019 10:01:58 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k2so7276402wrn.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 03:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vn3Z8/PHN+wHRrA5EwDE1JrUgVbGfslZkn0GNYob4BU=;
 b=KrSKX3Mp1Nj9dEaHLXXRg7lP2JV6jtyMalCG9+oGDGE6Ca3jZ0HD1Dy+RpqKF87hLF
 SyYCVNFP8HG+JM9KIae0YT88VGaqvQQLJQL0rZasE1kwCy5zw/VdtR2mTLWreEhCxGyO
 U0XY15IWtXt9qUYFuB3ZPhrA+iYL0ISD6iQp1iHERR/VQMnkPTEAO4FSBJY4aqOj7wiM
 v0uhsUix9WMdqL1rQCXLtK6xcn5WSAxuFIiP2jOthc7na7YWTWzMuZv+mbq0sSWHS75h
 SbVFFJRN5A1+AxOJRcXgzG9sJaSUFOwfxeLp6gKzFkx30b1k1wSPJDlBo+mCiOoO6dam
 rUZQ==
X-Gm-Message-State: APjAAAXC03XqqDnqwxwIG/Dt6C6O0aofiB7G7QMNXuzbsTfKaVb9PGUX
 Uj6BbKWsH/N5w8oLt+XuTieXvTHcNsLb2MIMHF8/AJHrH7ly75KLb+7DcSQDRvHW3ZV88Gpj7xb
 GFAUn8F9UyA3Oedo=
X-Received: by 2002:a1c:4886:: with SMTP id
 v128mr19888209wma.176.1570442517543; 
 Mon, 07 Oct 2019 03:01:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyvmMKsTfyRyGqTf7buoZ0JfHYf4CUSzym7F2Frn6hcMWbXZ9SBP4QnBLuNm3cPPbOIqym4bA==
X-Received: by 2002:a1c:4886:: with SMTP id
 v128mr19888181wma.176.1570442517239; 
 Mon, 07 Oct 2019 03:01:57 -0700 (PDT)
Received: from [192.168.1.115] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id c9sm14324577wrt.7.2019.10.07.03.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2019 03:01:56 -0700 (PDT)
Subject: Re: [PATCH 00/11] hw: Convert various reset() handler to DeviceReset
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20190926151733.25349-1-philmd@redhat.com>
 <20191005174531-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a20b4a9-b255-95e9-1e27-94e294e21042@redhat.com>
Date: Mon, 7 Oct 2019 12:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191005174531-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 10/5/19 11:46 PM, Michael S. Tsirkin wrote:
> On Thu, Sep 26, 2019 at 05:17:22PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Hi.
>>
>> Following the thread discussion between Peter/Markus/Damien about
>> reset handlers:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
>> I started to remove qemu_register_reset() calls from few qdevified
>> devices (the trivial ones).
>>
>> Regards,
>>
>> Phil.
>=20
> How do you want these patches merged? Trivial tree?

I was hoping Eduardo would take them but he is busy and I even forgot to=20
Cc him. They might go via Trivial or else via Paolo's Misc...

>> Philippe Mathieu-Daud=C3=A9 (11):
>>    hw/acpi/piix4: Convert reset handler to DeviceReset
>>    hw/ide/piix: Convert reset handler to DeviceReset
>>    hw/isa/piix4: Convert reset handler to DeviceReset
>>    hw/pci-host/piix: Convert reset handler to DeviceReset
>>    hw/ide/sii3112: Convert reset handler to DeviceReset
>>    hw/ide/via82c: Convert reset handler to DeviceReset
>>    hw/isa/vt82c686: Convert reset handler to DeviceReset
>>    hw/input/lm832x: Convert reset handler to DeviceReset
>>    hw/pci-host/bonito: Convert reset handler to DeviceReset
>>    hw/timer/etraxfs: Convert reset handler to DeviceReset
>>    hw/misc/vmcoreinfo: Convert reset handler to DeviceReset

