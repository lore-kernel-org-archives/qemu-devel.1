Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1408AC35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F1E21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfoLiaNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F1E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06o7-0001oL-VN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j06mp-0008Q5-CU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j06mo-0002AS-8X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:47:23 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j06mi-0001vg-G3; Fri, 07 Feb 2020 11:47:16 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so3484770wmi.5;
 Fri, 07 Feb 2020 08:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Cx3f9JCeXPAKbkuJ4R8jCySQ4ZTGk0NbZv6DlrxkU1g=;
 b=SfoLiaNei0WEglOplk//tRQLKQsKa2Af5NYXA4mSpKKPm28sn5mqKHLp7msH0bUrpm
 cZyZ44GIJj40gp+rp9GLezLZ9ZrfloupR5wPZfCM8KPZDsjCz+KeYotY8keDc+QMo4Ti
 Eyg1euBAOcOAZLd3cwQneVAfWAFWA4z8tSquWUGz/WGcPH+e9kNT5bbIjk6uDA4JE5sd
 mqUm1NL5eUtFu/Fwhbn+aAn4CyecgbPu+YDNUvE6DjuWmarf1Tn1fNU13T3rxm3Ex0dU
 VotkrbO/5jdPuP87W1fGw+KlEIZs0IUA+0dD0hRggjBjPxb76abyL/ymXk6iZYohmGSx
 U4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Cx3f9JCeXPAKbkuJ4R8jCySQ4ZTGk0NbZv6DlrxkU1g=;
 b=HnFAsBTngWlcYYHbBdcG39AEeqUU8zYH88PjQPGW17q+QLgf88tdB1KCLnjN4hiXrI
 1RIRgSyJApHh0iSRw0UClTKsUmgaNL35yW5r1mlEzFLV0BxFkIo8fcyUNSQx84jVlfoY
 hYZl/FNwIOrA8PeyowzKAZSdxVTffoYdZoC5VjpgoFe4zKG9L3NdF8zJuyrUX5kv57ic
 bqlJGUxzjbubGvKAwaJQwhpDTMmMRUkZ2JcOKGDusBvluV3rSKHDSfgwsQ1BrJDb3r6I
 NkFEEhOOqx1sWnsA91V4iYnhxNk7lcX5b6x6ntaTaVsiJhVw5mDFbD1dMdTl7JlWw3g2
 rNuw==
X-Gm-Message-State: APjAAAWRJVJ0KFGb9zv3gx1jueZkbtkvSkZY/F12JTr3Ze64ny9GImZ+
 Hm9WoTLW4xTKxZZJOARMASU=
X-Google-Smtp-Source: APXvYqwAzal00qp2KCXRkVtPshuOwfhRE/KOdbDY3RDX/1/NZVQrDDQVhkPcHUHJALy43Z351y/l8Q==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr5423260wmj.160.1581094035354; 
 Fri, 07 Feb 2020 08:47:15 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u14sm4082062wrm.51.2020.02.07.08.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:47:14 -0800 (PST)
Date: Fri, 7 Feb 2020 16:47:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH] block: fix crash on zero-length unaligned write and read
Message-ID: <20200207164713.GJ168381@stefanha-x1.localdomain>
References: <20200206164245.17781-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hk6Zb6cduJ+I0Tmj"
Content-Disposition: inline
In-Reply-To: <20200206164245.17781-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hk6Zb6cduJ+I0Tmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 07:42:45PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Commit 7a3f542fbd "block/io: refactor padding" occasionally dropped
> aligning for zero-length request: bdrv_init_padding() blindly return
> false if bytes =3D=3D 0, like there is nothing to align.
>=20
> This leads the following command to crash:
>=20
> ./qemu-io --image-opts -c 'write 1 0' \
>   driver=3Dblkdebug,align=3D512,image.driver=3Dnull-co,image.size=3D512
>=20
> >> qemu-io: block/io.c:1955: bdrv_aligned_pwritev: Assertion
>     `(offset & (align - 1)) =3D=3D 0' failed.
> >> Aborted (core dumped)
>=20
> Prior to 7a3f542fbd we does aligning of such zero requests. Instead of
> recovering this behavior let's just do nothing on such requests as it
> is useless.
>=20
> Note that driver may have special meaning of zero-length reqeusts, like
> qcow2_co_pwritev_compressed_part, so we can't skip any zero-length
> operation. But for unaligned ones, we can't pass it to driver anyway.
>=20
> This commit also fixes crash in iotest 80 running with -nocache:
>=20
> ./check -nocache -qcow2 80
>=20
> which crashes on same assertion due to trying to read empty extra data
> in qcow2_do_read_snapshots().
>=20
> Cc: qemu-stable@nongnu.org # v4.2
> Fixes: 7a3f542fbd
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--hk6Zb6cduJ+I0Tmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl49lJEACgkQnKSrs4Gr
c8jsowgAo9tv2JSMxHFMLHxnLhj4Nz5Xcr9phi114ZdYTw78GRB4pUd6oI1L4PD/
ORkAc25K+dPGJ/pOtVGcDSaDnPwo8N4ClmksRMSqzvdV78Nr56p8dtFkyrPz5XXn
yL7i57csuISEt7p9BOz51uBwolRM4hydPpG3cWoqfwCjcfcbFBH0qnHnuRE57LIg
+5aNivNNt8j6/oyl7sdOtSHsYpntneSbLfAXtk7F88lngB5agwLYHsRyQs3120z4
UquTNakwUEfaS8JAidZNOpZw3ZsUg6lWLiyTVcwlP5++Jt1d+52Xhr4l5HqeQBQg
zS9rOg2p8e1tz63STGZSf0xct+A6RA==
=uNSI
-----END PGP SIGNATURE-----

--hk6Zb6cduJ+I0Tmj--

