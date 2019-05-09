Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9278C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAE2216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxenCbFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAE2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOiuy-0006Zh-HF
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:17:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOiu5-0005ht-2g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOiu4-0005Xh-7T
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:16:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hOiu3-0005Wv-UA; Thu, 09 May 2019 09:16:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id s15so2977615wra.12;
	Thu, 09 May 2019 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=0x5bq+VKkPYLNhK8F/x+Kge9mBY6kLa72NrAP2UzmEc=;
	b=lxenCbFOI4HqF0Ze+ZfMj3ZkxARBDNzo9HKyhBpWOy4Jyy3ckxwKd57VwljmMMXRtN
	CRSidbw4xIiEXfvomNQiDc/5r2/Rb1Q3V0s1m4o2ORgjBuBme1UBk/hHq5m3jCn1Y0X2
	vatouCfscoTwqzHk130jWtoXbw/2SuJNfuQ4s7ibfixF++8vAFEfYaEcKDVILCU9hCnh
	cvkSMygUtDEc8QzQ2HT5b9wgMiLcciywnOtt6KARCUuU9efFzmqet4GpiJzMEsG/tPrP
	mX1uRW9zo8NdOHj7z8VRq4WtqLVNGcJ97KY6mK1GhnJ1a0pJOG84RnTsKViQ2xjnOzPi
	ukxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=0x5bq+VKkPYLNhK8F/x+Kge9mBY6kLa72NrAP2UzmEc=;
	b=KjRd0QBVYp5UWubXNiu7v0xaUv/xs7GdZPpQ8hSdZrYB7oTEFUFMktDAiriB8kDNtp
	dJ3jFF3YtX9VF/TJ0bz/dCckk+54cfBQFWT9gvffp3m9UkNcLkdUlzFY+AS9HokRsrDV
	TAqvceD6jtl3u0D0Y3alsn7C46dbDMQopRWJI/+iJmRHFX7yULLZrT8bKeYyAnDg6hH9
	QXg5an7JAQ3jWizrPBi+1aolwcwJ0talUrqs9ZAMxPlzmyRhrM+HCrDSr2RDk5vKSo0i
	DLitrsOm4vunPEknHiC5Kp3/1vTgG6x4iq2C/5XQMAH33jNUXNekPDS7F4OBV5Bt57zp
	qV2Q==
X-Gm-Message-State: APjAAAU/t9+9lBwD5S/tCt82GS0007JKrzWMVT8BA+JqGChwVLFrKygz
	QLQh24X68qOZgsVaIW7hMEk=
X-Google-Smtp-Source: APXvYqzxx9heh+OaB/ei4er4+m/pkDXJ6oIJiln7q5vUWweSAYEn6FkSfvoa6nUbdaoHKgx4aHsIfA==
X-Received: by 2002:adf:ef43:: with SMTP id c3mr3267615wrp.141.1557407761445; 
	Thu, 09 May 2019 06:16:01 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id z74sm8280034wmc.2.2019.05.09.06.16.00
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 06:16:00 -0700 (PDT)
Date: Thu, 9 May 2019 14:15:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190509131559.GB17133@stefanha-x1.localdomain>
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20190504120528.6389-5-pbonzini@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 4/9] coroutine: add host specific coroutine
 backend for 64-bit ARM
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 04, 2019 at 06:05:22AM -0600, Paolo Bonzini wrote:
> diff --git a/configure b/configure
> index c01f57a3ae..26e62a4ab1 100755
> --- a/configure
> +++ b/configure
> @@ -5200,7 +5200,7 @@ fi
>  if test "$coroutine" = ""; then
>    if test "$mingw32" = "yes"; then
>      coroutine=win32
> -  elif test "$cpu" = "x86_64"; then
> +  elif test "$cpu" = "x86_64" || test "$cpu" = "aarch64"; then
>       coroutine=asm
>    elif test "$ucontext_works" = "yes"; then
>      coroutine=ucontext
> diff --git a/scripts/qemugdb/coroutine_asm.py b/scripts/qemugdb/coroutine_asm.py
> index b4ac1291db..181b77287b 100644
> --- a/scripts/qemugdb/coroutine_asm.py
> +++ b/scripts/qemugdb/coroutine_asm.py
> @@ -17,4 +17,8 @@ U64_PTR = gdb.lookup_type('uint64_t').pointer()
>  def get_coroutine_regs(addr):
>      addr = addr.cast(gdb.lookup_type('CoroutineAsm').pointer())
>      rsp = addr['sp'].cast(U64_PTR)
> -    return {'sp': rsp, 'pc': rsp.dereference()}
> +    arch = gdb.selected_frame().architecture.name().split(':'):
> +    if arch[0] == 'i386' and arch[1] == 'x86-64':
> +        return {'rsp': rsp, 'pc': rsp.dereference()}

Before: sp
After: rsp

Is this a typo?  I thought we were using sp everywhere now.

> +    else:
> +        return {'sp': rsp, 'pc': addr['scratch'].cast(U64_PTR) }
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 41a10539cf..2167ffc862 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -39,7 +39,9 @@ util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
>  util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
>  util-obj-y += qemu-coroutine-sleep.o
>  util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
> +ifeq ($(ARCH),x86_64)
>  coroutine-asm.o-cflags := -mno-red-zone
> +endif

-mno-red-zone was mentioned in the previous patch.  Should this hunk be
moved there?

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzUJ/sACgkQnKSrs4Gr
c8iI3Af/UR58Kr8tv1JVRAVzuoWSWvnlyhQoqAUkT+AGm/4kROMXuTVSR1PUXMNj
cTb1axtrVpm6MY4Snn0j3n2/CmP/6gfslc8KjLsXm+nb0TFyla+VPpzPyQLXTsHj
wDh19OTJ0r93AB5EAg2dZCOtung9RTAyWAbcMR+/y80dXdhtA/seMVwO7PkkiGt/
YGcO8xJm3qCd++YyfarqaPMsKoSfpy/Qaf8EPSkBl0cLO8mfsw9ydxmveH2+MbnQ
G2bQHQ7dbL/aZuPMtEMoa25+jCcTwx7qf6Ukz/tkVb7JvbMK0Cb81par3cbTlEWz
SxIgM4rHapQiE11tqeKyDFzaikII5g==
=LUrO
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

