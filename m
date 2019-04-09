Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E8C20818
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E8C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDo9A-0003UN-KS
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:38:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo6w-0001pE-Jl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDo6v-0000uh-JN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDo6v-0000uG-9c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:36:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so20195699wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 03:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=hpXbdlw7PdaJYcTg8shkgWQ2Iuma1R4+F70kszDPHKo=;
	b=mQt6n23mDMEZ8KW6QBksDlk+are2YTFwxqFDVvm5UsFqDbleRWC9jSYiax75CSu+jG
	iErl4YXzPFMTPFIRjnZd7Uq3Ch2JwY4gEcRn+egFjF+FZ65yxE1iNw4CWNO6cReW27NX
	PwaMEZRJ73sONzwbEi2T+EgZl2e95p6vgTlAUKX4xbvcwpQO4J98KoPIycYn2Vr6Dcno
	maznrjuia1naJ423zRirS0oHdNJ0fHiX0xwbSDBOMRR2O9rQ2RuQdnrmwHZDKXb2xqhi
	yfCwbLmstGHaG+IYPzYRPgKHiQPsG2YUhQ/09ANvFw2t6GUbPXZ3o27ck2+81uq4ucdq
	8Cag==
X-Gm-Message-State: APjAAAVx5RIRuAVg0GZ4wuy8fTXIuX8yKT4ZWF35L9WUcXyFjfkJ6Np2
	85IT2RvephPL+HZ0sTHzO4iavA==
X-Google-Smtp-Source: APXvYqxklrCWIpD2Olf5JdGnPGnMli0oiEY/8D0lPN8Y0r45jVT932I2voQrfjjcJPjk2C0cgIObew==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr23215431wrn.53.1554806172283; 
	Tue, 09 Apr 2019 03:36:12 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	s18sm13917651wmc.41.2019.04.09.03.36.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 03:36:11 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>
References: <20190409053320.14612-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dcf3ed0d-f850-69bf-fc52-827b1e2a1a9e@redhat.com>
Date: Tue, 9 Apr 2019 12:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409053320.14612-1-sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] Update configure
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409103610.bVnCBRCA8GjMO-hYTTSe3Dg3CJwW8eRHkTlplz9O028@z>

On 4/9/19 7:33 AM, Stefan Weil wrote:
> The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..9c5d9a8c96 100755
> --- a/configure
> +++ b/configure
> @@ -7886,7 +7886,6 @@ LINKS="$LINKS python"
>  for bios_file in \
>      $source_path/pc-bios/*.bin \
>      $source_path/pc-bios/*.lid \
> -    $source_path/pc-bios/*.aml \
>      $source_path/pc-bios/*.rom \
>      $source_path/pc-bios/*.dtb \
>      $source_path/pc-bios/*.img \
> 

