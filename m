Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA8EC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB892054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB892054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNeS6-0007ni-JT
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:18:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNeR8-0007OM-4I
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNeR7-000191-5P
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:17:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNeR6-00017f-NK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:17:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so15367874wmk.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 07:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BbAYpGnYmGCIxc3wLgRtBvcRejoqR/aDepbw1efWNgc=;
	b=DFNOA3duWzY2ykyzxf1NQg3oa4QeyEcIE+dOsGjYFlAKjZwHlHvdwm3in3u0pqjVsZ
	6YKdhfyFIsR8ffx1N+/ZmUa/EyribDmhKjWZ+r3xjKHC3v4e6pDjSKQqPaAD6CZkVlx8
	08Po9a9buLQpsmAKWnkzNfBsMS9swIm7YB+SaR/VR4MtTpTUqnAIVrGFPJr+XAek53WK
	om/NXkRhG/X4XNitTBI8J7Yl35kYFPYaTsy3FNHQX/zC54UtvLd7Wkf/02Wx/7l3ueEx
	lVZUct6L5cOeZ4B6vqmIv89RiCS8U7m2QC/cUaTzo8uB9+jz29FeL3THt+iLanyEl8IG
	7onQ==
X-Gm-Message-State: APjAAAVygjtAqqb0uyBkYKmiatMjapStvHr+9PCbh5MHRkYwqtdTVlYd
	73bT0XUkHQwMwU4L0NxNzWyq0w==
X-Google-Smtp-Source: APXvYqy92u/RA7iwJKtwrjg9IKXErlriamS0Tu5WhAowuY2+Myg68TkmR1eYd1QWRBFe1snOu/6Lng==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr16250849wmc.1.1557152263732; 
	Mon, 06 May 2019 07:17:43 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v184sm15370123wma.6.2019.05.06.07.17.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 07:17:42 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
References: <20190504133540.19758-1-philmd@redhat.com>
	<20190504133540.19758-2-philmd@redhat.com>
	<d6f9cf07-daf5-273d-ca41-1b450b29b38d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c8927f28-4203-ebb4-b4b6-550fbe511f2e@redhat.com>
Date: Mon, 6 May 2019 16:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d6f9cf07-daf5-273d-ca41-1b450b29b38d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 1/2] roms: Correct the
 EDK2_BASETOOLS_OPTFLAGS variable description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 4:04 PM, Laszlo Ersek wrote:
> On 05/04/19 15:35, Philippe Mathieu-Daudé wrote:
>> In commit 1cab464136b4 we incorrectly described the
>> EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
>> options to the EDK2 build tools, but it only expands
>> the CFLAGS (not to the CPPFLAGS).
>> Update the description to be more accurate.
>>
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  roms/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/roms/Makefile b/roms/Makefile
>> index 0ce84a45ad5..f020102c866 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -121,8 +121,8 @@ build-efi-roms: build-pxe-roms
>>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
>>  
>> -# Build scripts can pass compiler/linker flags to the EDK2 build tools
>> -# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
>> +# Build scripts can pass compiler/linker flags to the EDK2
>> +# build  tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
> 
> please 'tr -s " "' in the above.

Sharp eagle eye!

> 
> With that:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks :)

> 
> Thanks
> Laszlo
> 
>>  # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
>>  #
>>  # Example:
>>
> 

