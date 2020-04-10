Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D46C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102782078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czrCv31t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102782078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrVF-0001L1-9u
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMrNL-0004nY-Sp
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMrNJ-0005Wu-R9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:59:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMrNJ-0005WV-Nt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586516345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTX1xg8zW831QXtNEgYAU6hlku4+H6JzFLKELBpBh4U=;
 b=czrCv31tbgybkklQrBGw1MQeRACiQQXjaldTuWQD6Vxdlg4X77Ovl2psfH/FhMXHupw2RP
 2GROAdEZAg3KR8bY1o7oqMbPEpdr0kXDaMwGbqefel3tivieX/J8zE/sKaOceXOXclkbyx
 ++Pk5OEdEha48bx3Ek/xZHs3LxfSRIw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-9EeONrjlPCOFKjy4c7Xy-w-1; Fri, 10 Apr 2020 06:59:04 -0400
X-MC-Unique: 9EeONrjlPCOFKjy4c7Xy-w-1
Received: by mail-ed1-f71.google.com with SMTP id f11so1832067edc.4
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=trhecORPaNp8R+G71A0fF221RyXqjQB25KPHwE9c/tQ=;
 b=UGdOq8xmTutuJzaSQx/YWBhUQRdcD0VB8Jc2koZppWr/kQNsL+9E6ZA5emkLdPGn6N
 PIWsW5MkOiuyuMXCQjToT4jgFoa6RbOe8mIaInSGl5eIFlxVycAwdZAqQpgU4+VHV7uc
 jSoAROZMsHuGaUiBg6VfYjqQ9orB1jCDb50Bx4PVe/iBZemRGQHGa3ajeKhGAA9VEqea
 vS1TvSuhkFZPb6sowFLlqJHeS96xyKE1fx/cGwyX69ELilEbxB6+1nX1rwa1/HEZ0G5f
 fKHL8n2EEwLuZkfJ/k3qmedetlKthtwMeIGWMnULv/C51ToMSUx4HnUKJWWoUg9CX6Jk
 c+qw==
X-Gm-Message-State: AGi0PuYJRJrmvFLBTDfDSrsO1qi6/1RfrH1H0dmaqAEsMn/7NrU98CCR
 g7h+vsPG0PWeGJBS5eVxb0dP8Q5KJf8FlfSTkH3lnCv6xPUn30Bo/zHBezKJhTnmMYlOhe2lLQt
 U+kWavCFjJVHmKZQ=
X-Received: by 2002:a05:6402:1695:: with SMTP id
 a21mr4129069edv.111.1586516342485; 
 Fri, 10 Apr 2020 03:59:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypK/l/svkxCMO01pogRFpUBaVIqPqXD/QtsAJ5m+vp322AXdHyjl7EGHz0Rdmt7j0HB1Z1p5vQ==
X-Received: by 2002:a05:6402:1695:: with SMTP id
 a21mr4129056edv.111.1586516342287; 
 Fri, 10 Apr 2020 03:59:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id x1sm99315eju.70.2020.04.10.03.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 03:59:01 -0700 (PDT)
Subject: Re: [PATCH v1 02/11] exec/cpu-all: Use bool for have_guest_base
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cf96a98-c59f-7bbe-22b0-b2f59169b8ee@redhat.com>
Date: Fri, 10 Apr 2020 12:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-3-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 +-
>   bsd-user/main.c        | 4 ++--
>   linux-user/main.c      | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 49384bb66a5..b4fb5832c4a 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -159,7 +159,7 @@ static inline void tswap64s(uint64_t *s)
>    * This allows the guest address space to be offset to a convenient loc=
ation.
>    */
>   extern unsigned long guest_base;
> -extern int have_guest_base;
> +extern bool have_guest_base;
>   extern unsigned long reserved_va;
>  =20
>   #if HOST_LONG_BITS <=3D TARGET_VIRT_ADDR_SPACE_BITS
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 770c2b267ad..aef5531628a 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -42,7 +42,7 @@
>   int singlestep;
>   unsigned long mmap_min_addr;
>   unsigned long guest_base;
> -int have_guest_base;
> +bool have_guest_base;
>   unsigned long reserved_va;
>  =20
>   static const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;
> @@ -828,7 +828,7 @@ int main(int argc, char **argv)
>               }
>           } else if (!strcmp(r, "B")) {
>              guest_base =3D strtol(argv[optind++], NULL, 0);
> -           have_guest_base =3D 1;
> +           have_guest_base =3D true;
>           } else if (!strcmp(r, "drop-ld-preload")) {
>               (void) envlist_unsetenv(envlist, "LD_PRELOAD");
>           } else if (!strcmp(r, "bsd")) {
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 1d20a83d4e8..90ad365b439 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -59,7 +59,7 @@ static const char *cpu_type;
>   static const char *seed_optarg;
>   unsigned long mmap_min_addr;
>   unsigned long guest_base;
> -int have_guest_base;
> +bool have_guest_base;
>  =20
>   /*
>    * Used to implement backwards-compatibility for the `-strace`, and
> @@ -334,7 +334,7 @@ static void handle_arg_cpu(const char *arg)
>   static void handle_arg_guest_base(const char *arg)
>   {
>       guest_base =3D strtol(arg, NULL, 0);
> -    have_guest_base =3D 1;
> +    have_guest_base =3D true;
>   }
>  =20
>   static void handle_arg_reserved_va(const char *arg)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


