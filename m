Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D30C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDAF20578
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vq9YDecR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDAF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHmeF-00017C-Rb
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHmdN-0000IG-Q7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHmdM-0003X7-1W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:54:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44451)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHmdL-0003WT-UU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585306479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjLlCZ/dRBgCr4kioDi8DJe6Oq1eTl8Xo/FEhpx7MY0=;
 b=Vq9YDecR2vM5YeFtbKCmhrS7JPwU2vCMsWVl6/VP1kBFtdLT1e67xlHAkSQTOBOkbxPBnq
 wVnCIroS5FPitZG5cdzTaVxulN3n1+1ByWnRaqMvkEUXYNiwwIQHVhur8TF2UKHh1lq/l8
 gvtKtnA0lZzS8xTH8IRFGHlgmJslw4U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-Y4dYUSOoMDqsym_44PcRyA-1; Fri, 27 Mar 2020 06:54:37 -0400
X-MC-Unique: Y4dYUSOoMDqsym_44PcRyA-1
Received: by mail-ed1-f72.google.com with SMTP id w6so7957217edq.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 03:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XZL+Ei3BFQoxW+jb4ZVyKm8nV+VfHfWSMicEFpbdnT8=;
 b=MBZ6YbfJhTE0g26+dqqWghgbwyvHvr11KR7EE6ewFOc2LMTF2XZ8IopLwNfb/Ii2LB
 UNVbXzu83uFxO03J5c1KWL6CZ+04audHwD3z+7QnsjonHNWg5TEnCJdQVpmgNeLx0Yel
 hCLg6Hg0+BcYaWWonISHMQZB9vj29U+d4sm7/cRrvE1C3SsTTW9zXaKCH9nTWHPiZuxT
 HbLEJsSj/2rkEyPO4XzwuQHUe7abA85SQnEf8RuS6p2dxusolr9awEP5XVuHkpEAdOHZ
 +2P1lPenne7M+P/WR1nxsc0CdkDrjMK63SD++ttHdVWvHH6jZRVTzLSbHt+WSn1YyQgZ
 JIQQ==
X-Gm-Message-State: ANhLgQ38yhuEfHQ7WhiNoRpVUTgePqTcEAGvbHYREeVrrutRL/d+xnwq
 ELqPKeREx2S2EcF4tYyuqJs9VhlOIrAiiFEQDqL+PKXAavaDadnq6VlpDhovoCxQo9Dh6kpABLV
 0BUcNUp7vzDTh8wU=
X-Received: by 2002:a05:6402:17aa:: with SMTP id
 j10mr12157619edy.146.1585306476234; 
 Fri, 27 Mar 2020 03:54:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt2y5bTbfroixs0GHcykBhWRk2louaM9xSDjyKDczPZxpb2zcvWdv65+WCyEM/TV4U5bk3zLw==
X-Received: by 2002:a05:6402:17aa:: with SMTP id
 j10mr12157603edy.146.1585306475955; 
 Fri, 27 Mar 2020 03:54:35 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f17sm789209edj.86.2020.03.27.03.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 03:54:35 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] tests/tcg: remove extraneous pasting macros
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e8a9e9e3-7e7f-b143-ade0-a4440e146e9e@redhat.com>
Date: Fri, 27 Mar 2020 11:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327094945.23768-4-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 10:49 AM, Alex Benn=C3=A9e wrote:
> We are not using them and they just get in the way.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/tcg/x86_64/system/boot.S | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boo=
t.S
> index 205cfbd3982..73b19a2bda6 100644
> --- a/tests/tcg/x86_64/system/boot.S
> +++ b/tests/tcg/x86_64/system/boot.S
> @@ -41,10 +41,7 @@
>   #define XEN_ELFNOTE_PHYS32_ENTRY  18
>  =20
>   #define __ASM_FORM(x)=09x
> -#define __ASM_FORM_RAW(x)     x
> -#define __ASM_FORM_COMMA(x) x,
> -#define __ASM_SEL(a,b)           __ASM_FORM(b)
> -#define __ASM_SEL_RAW(a,b)      __ASM_FORM_RAW(b)
> +#define __ASM_SEL(a,b)  __ASM_FORM(b)
>   #define _ASM_PTR=09__ASM_SEL(.long, .quad)
>  =20
>   =09ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


