Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED06C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE722084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GreAe/mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE722084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrBK-0006zZ-Ha
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:30:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQr8U-00055h-Ab
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQr8T-0007Wo-GW
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:27:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hQr8T-0007WA-9g; Wed, 15 May 2019 06:27:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id f204so2092444wme.0;
	Wed, 15 May 2019 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=hIrqSTt1Hx+dJyTXINmE+v6ezJPmaJkLgI8CJvvMU0U=;
	b=GreAe/mPvFmJaTGrMB0MERX3GAsaZt+b3BxAnoLA+7el1gKvns3ioLTB1PFYcc+ZeE
	7gEb6y095ifgmv/THg5kG0R5afG0kZjU66kfKgmDngO/I5/B726ofaEQUQPhw1jkwxgU
	nmRqIWOrrj1RAg31jJYcLNJcb+xJyKCEUnAuAIBGPIFp3qld05025GjxGx9Ix5XFZHBO
	mRzwxnrzgYo/Sjmb1kgvKXh/fgOPfpxqNE3ZGlaiZJtIkTfe6MV6HgNtUSo0z28V1/vo
	rHHjhb32j78dlNj5BuKl8Ej0x44D9HQNPQueeQ/L4sWkphtwzERYktb4q15EoJI03yF/
	nOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=hIrqSTt1Hx+dJyTXINmE+v6ezJPmaJkLgI8CJvvMU0U=;
	b=OqaBBV1GdeECDs1BcjGs3PP840R55cRy0yBiQbL3hxKzYskV/qEo57d7xkWc3MZXyf
	P9CZdwbd2N2KGK4B7F310qRgirEjASadbdRdP0eED5rfNL6bwnlIzd2j5A04ihYw1oRe
	+nvKylnQ3VAv4dzjdpvQKagaoMrMizjYbWg5vRF/l1DfG+Fs1HEdpgkpGuQgkBjwlcfq
	uFfECW5vXAokwk0JK3AEh83/bZ4uFUOx/ZRHweZvo6W6eoUbT/35KCwOEvACLD90b5xa
	8bhimOyFv+Xji5nn/o5KP+J8UPHJbstGDiA1NqlbtLG30MfLWNrDB7GkTBizvWlaGz2Z
	2NXg==
X-Gm-Message-State: APjAAAX1+wQ3oRSBuEBYWI3K3BU0ihso31LN6npck45rP7Hk0G0UwKAD
	hzjp53aUNd4Ytituy5YJ5YueGobcLtw=
X-Google-Smtp-Source: APXvYqyy3XUa3tWEaluUoT7tESU878RKV3eU0OU8Gloqzo9L63CZi5/FuqJdHO1MRfqpcmp2gmwYuw==
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr13959180wmb.50.1557916064127; 
	Wed, 15 May 2019 03:27:44 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	i17sm1890268wrr.46.2019.05.15.03.27.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 03:27:43 -0700 (PDT)
Date: Wed, 15 May 2019 11:27:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190515102742.GD29507@stefanha-x1.localdomain>
References: <20190510052239.21947-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <20190510052239.21947-1-thuth@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: Re: [Qemu-devel] [PATCH] tests/libqtest: Remove unused
 global_qtest-related wrapper functions
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 07:22:39AM +0200, Thomas Huth wrote:
> A bunch of the wrapper functions that use global_qtest are not used
> anymore. Remove them to avoid that they are used in new code again.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/libqtest.c |  11 +----
>  tests/libqtest.h | 108 -----------------------------------------------
>  2 files changed, 1 insertion(+), 118 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzb6Z4ACgkQnKSrs4Gr
c8iVvwf/VqAjYooJcBvZm/qNr3h5JUlKiyE5pGfaUSs36sRfM9CykM44zk6f3K+z
TWoNIQqfTegYRPxP/gJFHFXefy+o+zSsrZsM3nPmKd3sq9N6dbAD5D9VHexzCo5A
i48FpROu+vT50zxer5V5ifydmiF8ztsy3QhxvKoyVeCrenEQJePYOuNLJ2hklMkn
HDISQ5Z14UdZF3DVIny3ou6R+eIHX7RbUz3ObzHsm+FoHSvNdchSNjjaCEsxWLo2
v6sCqBmo68u0/8ntfDcNfBdLxBwS1C+IE4Xn1dMXxMQMWv90Y6aQwq3Nz0N2Hylg
Wi9RZufGI9pYLmhBt2DJXtBf/VYcFA==
=NqMN
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

