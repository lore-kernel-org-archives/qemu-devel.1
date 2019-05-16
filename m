Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4890EC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D7220833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZqLQwK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGmb-0005aF-Sn
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:50:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hRGlL-0004kG-Ri
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hRGlI-0005mi-PS
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:49:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hRGlI-0005hT-G5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:49:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id w8so3494420wrl.6
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=zpggYz/xQbAav5Y/TYwTd/IgW7nS5/7iEz2eWxjiP+0=;
	b=lZqLQwK8E7BoJiBt5Dc6DkkZiYX5n7KDjViiQgqD3/ooQbT3ieA3+UQdml3flFsDZ7
	6vUl3GF05Nhtje5MmNe75zMg7yHJAYUka1AZ5VdTDzw7FMM44K8UxFiYAco6n6FRfNE7
	5c1vJYbPWipphC3ICAwC3U7hfszrgl4xaA0DQFx4dy+rQsfsvMDi4wG0NUCxJVc81V7N
	cCzivxs4CkzbE9cagXWnZgoRnGjONWQe42/1a9iqAkAnLNtvrxcjKXwXkL+CyYu2ZCKa
	02echJHJrTg8ESQC2fgElJ9fePBSbBHsS+xfQ9k412JJvkQoWJ/pkJXhEPh4s3y7k++5
	MoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=zpggYz/xQbAav5Y/TYwTd/IgW7nS5/7iEz2eWxjiP+0=;
	b=VwGnQPkl5Boal71GzGkMuDTkIdab2XiUuQnof4NL6izo5juQLDLcwWep2OS96oaIb6
	CmejZXHMwvv5Z2xVo/IRw6cFJJsxNs2g4KGKm6dvqnneAtuHQ3YoAvfLnFK6H/5DUUBM
	1pk8F7SW6cA5uPhhBG/3AAkx4BykpkdhLm4hOGU3vZ8b5i6mtffDXO5XJ/2+d/BdNikq
	Y6EJsNMzyeQEjaiTilzN24ZlGnF9QKgQ5w0NI7pmuh3uiWslvDpvz/VAUztUOQ+WqEvJ
	jIS3gJ8Unk92ULTnRzlPaURw2uOi4Wv/QrneZoQn5FCnSmAdPbWccQPN0o2aK8WRkbwT
	GI4g==
X-Gm-Message-State: APjAAAU4pkLIqrXBTiLUiwpZlOEtjXcG9rq3j8gbvETKrpuVavGXpTKo
	Fgp8ar480fEuCQMSglpIWRs=
X-Google-Smtp-Source: APXvYqxJQ510V3QVusIpOcd9F8dbW8LhMtL62bmPIzQjHe+JeChbN2uHweU4KLREtpXYkFPnhPqsJg==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr15614516wrm.151.1558014569159;
	Thu, 16 May 2019 06:49:29 -0700 (PDT)
Received: from erokenlabserver ([41.203.78.145])
	by smtp.gmail.com with ESMTPSA id f6sm5982652wro.12.2019.05.16.06.49.26
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 06:49:28 -0700 (PDT)
Date: Thu, 16 May 2019 14:49:45 +0100
From: Ernest Esene <eroken1@gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190516134945.GA2293@erokenlabserver>
References: <20190510180410.GA10349@erokenlabserver>
	<20190515141712.GG29507@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20190515141712.GG29507@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3] chardev/char-i2c: Implement Linux I2C
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 03:17:12PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 10, 2019 at 07:04:10PM +0100, Ernest Esene wrote:
> > Add support for Linux I2C character device for I2C device passthrough
> > For example:
> > -chardev i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
> >=20
> > QEMU supports emulation of I2C devices in software but currently can't
> > passthrough to real I2C devices. This feature is needed by developers
> > using QEMU for writing and testing software for I2C devices.
> >=20
> > Signed-off-by: Ernest Esene <eroken1@gmail.com>
>=20
> How is -chardev i2c meant to be used?  Do you have code to connect this
> new chardev type to an emulated I2C bus?
It is meant to be connected to emulated I2C bus as you've stated, but I
don't have the code yet.
>=20
> Stefan



--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlzdanMACgkQJZ4JoaCv
xKqehA/+K4lqOvR1C3f5/6B3gYr+qA1MGrBPxaTtTWt//hYHjpD6pJyobCaXPBCB
6vKD2DWvMhA17LNI7Q6CJzr1LA0x41NS1MB8b2+x+CDcu2mTajqyJH9pfUPriokw
3sjuqjtNNTONq5XY6tqloGQg6UkMXtgUqi1ppdv1Pwbz75pdE1/CoZpXmr7kRD1r
jY/2MIarszZIY2aaxAXl/jpdCclIHb4leKDWRtjxXo3JmP/y7+VbFLnbZFYrY1bg
lfBXS5+sfqvl6IcmWD8gbv/7wGlzBeXgnv+jUWh5+Z+Mmr/RADbrj2pwPSwDpCiu
FDJJyH61kDawV5T3e28oDHC/TLFdu19PppVELryZ5F9K+nw86mLJH2qi/U9S3jiu
itJi8Siug3MznWH2eZyvvBQBYEkJ9eLnoWAz0t9HBL4XSIo+SKb241opRjg+8wjx
8rSRAZp15R9JAap34LtuVidmtYwolbIUOcULydzjgO8Q49SiGGOjasYPKz+RSKhx
3vKvktr+bUBm3C1Fj2/IJ7W4HIsLtV4o1N2ArXMk8IphbNq9hGTKL72pVxa8n1lF
7hsPjeyjy04FdLUmYBodP3LtXfD53ydv2GXo9zSB3U2ijkEYkM7Ghish2ovQEsDR
Jh098yf9QpnySf29r0icPp6DMLbonWg6Wp7IbnBq/JAuTa9dpHM=
=D+ac
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

