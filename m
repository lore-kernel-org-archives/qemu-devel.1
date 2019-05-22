Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E1C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB2E2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sg++3SJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB2E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTR1J-0006oZ-3c
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:11:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTR08-0006Bk-LL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hTR07-0006eW-Qf
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:09:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hTR07-0006da-JB; Wed, 22 May 2019 09:09:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so2207259wrr.13;
	Wed, 22 May 2019 06:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=UHYU/pad3VuPwJCcca34Yeh15U+DqSEHgBtrj2SDYoI=;
	b=sg++3SJ3GkM6GO8dM6GdoUKiifjw9ikIZp5Zq5XZBTo/hgExiIDYAk59fTy6ItCQ+e
	8DA4MM+oB/Qk4fGGbX7o1xCidSuvdRJaSGUBEOg0T6vsnra3oAEu8tsJv1inVWJTzWvl
	QexemMJVSq9mJj8mCvCiTNvLnEKQJl85I9LbloDhrf3/xXXiQcf2k+AvdqIk84ylyYvq
	A8yMbgVYpDGhulEwzNokfzwAl0PfFzsRjcW5Jc7CXvMXTxZkbMnYJ9J0KY0bTsNd3h9e
	aK3yB82k8F1vEvta2I9ZcFmNGWHR6w/hPEuFb8vRyNsgdLjqmIm4u1VA/rKQf+oDdxKI
	VYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=UHYU/pad3VuPwJCcca34Yeh15U+DqSEHgBtrj2SDYoI=;
	b=MlGbZZWthaDR5n/Mb5jIRbdrT0TFzeHQJvp6bLrFrZEzq6g/TGz1bBGnRd0FyFV1mv
	cZ/5Gd7Gb1hxY9DAEPbF7KEnpIXX4cGH8tbQ8kTsmosuaNV2kyJJRNUYD1sarsB7EP43
	2n64gdb7STR2FIQLjgu16JD/sAxUFFdD9GfZ6q56GGeYf53tsgWzcuQ1ZQQ+8vq6u5Pl
	Y6U1osCSUJH/g9kwU/cI1NdxxzxoFjwwIKJYnZqgEGS8eZeUbwfAbpYs0tBocI2IuIG8
	UMqrT0J2nwB9acVS3G4ahK4duLjRV4QuVqUkc/9Q2uSBJE9SFipHaTgVDf5NYLaiUfKF
	i7xg==
X-Gm-Message-State: APjAAAUzXaVm/pLiCOkwsTDMPgyHkP3YxngLbNHqvhxLGZuJSWKsui78
	E+Fzk7569QHiyxgT2MqUVCY=
X-Google-Smtp-Source: APXvYqz3w9qrrMcS7+41WB5tnvuaOfKwOaF3zpGXCIoVA+Ib5SDLSMS2JYnr9Mgg+O+t7f8HhdIyBA==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr12459584wru.12.1558530586516; 
	Wed, 22 May 2019 06:09:46 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	s13sm18410034wrw.17.2019.05.22.06.09.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 May 2019 06:09:45 -0700 (PDT)
Date: Wed, 22 May 2019 14:09:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190522130944.GJ27900@stefanha-x1.localdomain>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
	<20190521235215.31341-4-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline
In-Reply-To: <20190521235215.31341-4-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH 3/9] include/block: declare interfaces
 for io_uring
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
Cc: saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2019 at 05:22:09AM +0530, Aarushi Mehta wrote:
>  #ifdef CONFIG_LINUX_AIO
> -    /* State for native Linux AIO.  Uses aio_context_acquire/release for
> +    /*
> +     * State for native Linux AIO.  Uses aio_context_acquire/release for
>       * locking.
>       */
>      struct LinuxAioState *linux_aio;
>  #endif
> +#ifdef CONFIG_LINUX_IO_URING
> +    /*
> +     * State for native Linux AIO.  Uses aio_context_acquire/release for

s/native Linux AIO/Linux io_uring/

> +     * locking.
> +     */
> +    struct LuringState *linux_io_uring;
> +#endif

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzlShcACgkQnKSrs4Gr
c8jBeQf+LSS+6ZV9cwr/2LHiAKZQ97QilX5qZsHbNYf+VUHfPeMnMD0ailDbU5Fm
mq4pbt5u5keVJc9fASnOB/ePB0UzCj6z+6nev0O02wxelIXGk7m+635zPRyMMoUA
81WQkyASF2CIwu5RSH0H+qNgSqeWS3E3LswdYgjmOR9CvwM8BRDdrcsXSfY1HEvY
SdHaYYDxMOLjYqTvlOTgkpyqFxJySHwRIWks/LvS/oTl54dwPm9qznp1zPrBaHjV
8GDlr+oNLwe8MToAAfpdEfFxnjIOZr1WtHYmsfaop3DGAMdD0YAco5U6jhG9e/Yh
Pfps56Oljg7FyIBuNOH3CQo34woJ4Q==
=q8Dz
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--

