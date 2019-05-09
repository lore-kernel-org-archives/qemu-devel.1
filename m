Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E05C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB5E21744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZa8xEv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB5E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54246 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOigR-0007BD-RK
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:01:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOifW-0006sC-UB
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hOifV-0004Kb-Ud
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:01:02 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hOifV-0004Gt-Nb
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:01:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id d12so2932280wrm.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Xsv7nhlVWRjNIucZKrV0nDBdcCmbyf3/aSy5Se95SYI=;
	b=GZa8xEv/ejPCI276I2Zoqb0xZdw9BlTClPDZjoD7gC51+oqyANQbA2jfbvfPS3TPoi
	j4+GHb5PrdqbznOc+RdkQTKFGhpkKiRuy2sW1O3Z5qQyy1W0EP6YMDpLXy2DsUpgxxvW
	NOtGiflGE1LJlvIUa1ySE1FUNGycBfTwag9gEMACRVZDlMYHnxU0hbRQz9ES6DsVOyGh
	ahlqMGZvB3bvsX7oXqV2UR9ZvcsUX8+okZqUOQabSqXoc/AgZstdZhzXws2d0KXpMHoJ
	kiiJJ/iwOzhJ9PwK9yPBGkY1+cP4VYp8yV6wzNnmPDUgA0k8ICyATkut0BfWvzCz+xCn
	/q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Xsv7nhlVWRjNIucZKrV0nDBdcCmbyf3/aSy5Se95SYI=;
	b=I0KERe0y8OPGbTBIk6SKT1759PTGGNhCGUph5sJXNAPF0jXql3eO1vojEjEoGQeQKj
	0UoeCYYieo+nCOk70aYR5MzA318hlGPOA3/+4DycrMlQzLWRSt7NocTbtVe5wXddekUm
	ufAutI9uZCPK86Y5eeWUKf5xer8E1PzodKVbLHifHr7IdyUbNy2zQd1xl1Lk5MLEg2cQ
	TRUv/GPP/JcGlUIPrY5S6Lcpodzm/6Fw/w3WTnAYDMMBghwH2RYNt2uyh388uGmQxspN
	uvEFzIsfiOJPCPhnJDPrp/q3xc9O5iazOdOZHJHXSSJ+5JOXdYfUyR0Jsutd1R2N/Kft
	ULbw==
X-Gm-Message-State: APjAAAU7w6XKvdWVCorDQuuow49EbLxVawjvkiHT4CGSxTV6MgRYxuVI
	Uj35ZkeuUvdE3piAmVCsSu8=
X-Google-Smtp-Source: APXvYqwapS13d8W0aKEVgzxF7odsEkolIzteHAwWvMx2ypjMLEzHEFbMw24JDKt5mfdDrMoCN1goDQ==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr2993003wrl.216.1557406858755; 
	Thu, 09 May 2019 06:00:58 -0700 (PDT)
Received: from localhost ([51.15.41.238])
	by smtp.gmail.com with ESMTPSA id k2sm3248401wrg.22.2019.05.09.06.00.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 06:00:57 -0700 (PDT)
Date: Thu, 9 May 2019 14:00:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190509130056.GA17133@stefanha-x1.localdomain>
References: <20190504181119.GA3317@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20190504181119.GA3317@erokenlabserver>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 04, 2019 at 07:11:19PM +0100, Ernest Esene wrote:
> Add support for Linux I2C character device for I2C device passthrough
> For example:
> -chardev linux-i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev

There is a mixture of "linux-i2c" and "char-i2c" names in this patch,
which I find confusing.  Maybe you changed your mind while writing this
code.  There are two options:

1. Call it "linux-i2c".  Other host operating systems will need their
   own equivalent objects.

2. Call it "char-i2c" and make all the parameters optional since they
   are likely to work differently on other host operating systems.

I tend towards the second approach because I think I2C is simple enough
that a single user-visible object can work on all host operating
systems.

Please make the naming consistent in the next revision of this patch.

>=20
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
>=20
> ---
> v2:
>   * Fix errors
>   * update "MAINTAINERS" file.
> ---
>  MAINTAINERS                |   6 ++
>  chardev/Makefile.objs      |   1 +
>  chardev/char-i2c.c         | 140 +++++++++++++++++++++++++++++++++++++++=
++++++
>  chardev/char.c             |   3 +
>  include/chardev/char-i2c.h |  35 ++++++++++++
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |  18 ++++++
>  7 files changed, 204 insertions(+)
>  create mode 100644 chardev/char-i2c.c
>  create mode 100644 include/chardev/char-i2c.h

Please update the qemu-options.texi user documentation.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzUJGsACgkQnKSrs4Gr
c8j7tQgAorfguVIcz7L0RXU9y9nf88CxTmEiJhbXmSorszkYWWIlUDnJDRlLa4CO
jmE01VTbC1pbCan+C7CzLJZGbDeRQHccCsfvDBUvUuWuZn3Myx9EbzpbYUsdCsoY
NopH+AcKA6eBHPdVVbpW9wsGnKps6TI55VPbytMMI0Y+kpOPwiJ36k349RBhnP5y
Q8mNfTOnVP1QeHhjrvISLF5ppFdV12AMqAgbopwLyEhCPp367P4jvnnaOEceLwQu
lvlyIc86SrGFYiWsNrBjLglsy0y7gW40R3zkGEMg7nKQxhA/8m7tJtI+g1KFRS8x
UpkJf/ti2E82P0WPYcO2fE5JBY8vzw==
=UCqN
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

