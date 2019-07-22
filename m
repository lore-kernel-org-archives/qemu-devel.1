Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A7C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2CF218C9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 20:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2CF218C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpeZm-0006oM-R0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 16:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpeZd-0006Pz-CI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpeZc-0004cK-ES
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:06:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpeZc-0004bp-8h
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 16:06:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so40738733wrm.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 13:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4VaeWKpELE5k+/Ao6ZK1zYpwMgJAa8dJZJ1qdktwf0=;
 b=UMw3a2UighPsv038HMyGM+gcazvnnM8mDYeWBzcQKiobwP0qGrnUw7Q828HlMbQ61D
 XzaFiAncuu3S7dw99xwHkFIVwLQW4BzmkIPAPptQSWZBCJw1FOFWe4iuaR4AQCL2QNyw
 KRjh99oLTtrp3TDrco+r5Qpj+MPawm9dfQDW6GZHWe2Xa/290XAQ7haH7S2q4nRxaY8K
 xUVnCsiWEmTHlFjQKlVsGgn5JAIwhWWPaqm1dtyIi8dVpgmxmm2fllfAcWolsRlz7GUF
 i/TET9f6hpcLLKaN3Q2DREjKG1rpouvcwLjxMkRM75YALJTga+zucE43TXTUJf/WbGjd
 UlyQ==
X-Gm-Message-State: APjAAAX3T0eRTsTcIf/bH3EUuaZKItA9vlYFBWIsKUFXhfOIg7+W34VH
 dQeuWk+7jfrBx3yrCUyIfrn7ta2+P6U=
X-Google-Smtp-Source: APXvYqzcTJ6zYH68//y5l+yVLlw2t+L3oXi2KPxJZTYyNKgK3e9CAoBuaF8JIc2vE/HKTN4fIn5EWQ==
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr34350278wrq.173.1563825975166; 
 Mon, 22 Jul 2019 13:06:15 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id g19sm73801109wrb.52.2019.07.22.13.06.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 13:06:14 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20190717134335.15351-1-alex.bennee@linaro.org>
 <20190717134335.15351-17-alex.bennee@linaro.org>
 <808ea700-759e-b914-f4d8-1ad5df3fcac7@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <96b8e1f4-c799-a508-cc33-74f56118b5d0@redhat.com>
Date: Mon, 22 Jul 2019 22:06:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <808ea700-759e-b914-f4d8-1ad5df3fcac7@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v2 16/23] NSIS: Add missing firmware blobs
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 8:23 PM, Stefan Weil wrote:
> Am 17.07.2019 um 15:43 schrieb Alex Bennée:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Various firmwares has been added in the pc-bios/ directory:
>>
>> - CCW     (since commit 0c1fecdd523)
>> - Skiboot (since commit bcad45de6a0)
>> - EDK2    (since commit f7fa38b74c3)
>>
>> Since we install qemu-system able to run the architectures
>> targetted by these firmware, include them in the NSIS exe.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Message-Id: <20190715174817.18981-10-philmd@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  qemu.nsi | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/qemu.nsi b/qemu.nsi
>> index 75f1608b9e0..89c7c04f957 100644
>> --- a/qemu.nsi
>> +++ b/qemu.nsi
>> @@ -122,6 +122,9 @@ Section "${PRODUCT} (required)"
>>      File "${BINDIR}\*.bmp"
>>      File "${BINDIR}\*.bin"
>>      File "${BINDIR}\*.dtb"
>> +    File "${BINDIR}\*.fd"
>> +    File "${BINDIR}\*.img"
>> +    File "${BINDIR}\*.lid"
>>      File "${BINDIR}\*.rom"
>>      File "${BINDIR}\openbios-*"
>>  
> 
> 
> Hi,
> 
> what about qemu_vga.ndrv? And all new file pattern should also be added
> to the uninstall section.

Good point.

Alex, so you mind amending:

+    File "${BINDIR}\*.ndrv"

Stefan is that OK if we fix the uninstall section for the next rc or
release?

Else, Alex please drop this patch.

