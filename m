Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF5C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65E321848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy04PsJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65E321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNKb-0007OP-OF
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSNJg-0006sL-Gs
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSNJf-0007y4-Cc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:33:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSNJe-0007wP-MO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:33:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id f3so3842597wmc.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xFKqe58pqn1o78mBw+R/nagoOOW7kos2vwKBHNKSaBU=;
 b=Yy04PsJxygXf50FoB/Y1dAeUZUwP2UWpVt2Mb2K3CdaWtUv/rKse1DuQBLA5an3HB6
 I8DWgLpSe/vx0hdaTAS37cingfwcRCe+k4a6irvPKcwF6HR13AQrda/IR3IpiNeS0pfb
 kXIG4Rc6ESerOcaRyNI+i3chb4lVbwa2z3+brkHlTCsk+UhEToNixjWBovNhy14iLF8W
 iJVLyxaJGoBYnbOUFUZ34veUsLDBoBgiMwg/X5Gye8gYrOwku3tAApd9cu9BAcgUE/cd
 TP7su+UKtCALThRC7qX3bV4wWuqXxALKwkrITHc3lqDsAyMKuX6wZTdivtypYK6rzB3a
 usZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xFKqe58pqn1o78mBw+R/nagoOOW7kos2vwKBHNKSaBU=;
 b=ctZFi6d5rCGxxP9ub/AWTmJn/gup1dQz2J9y/i67JbZ0kwPBu+5s0EjRm/nhWKodd2
 3x+fFtDO2VhNt/A7wpP+71lbsYdUhYHPYXaTCnqzVjl7y05Jrao8R3prNpQQqsCbm2xT
 4IjyALV5TaxLxwWOQ4lEOLeLtHn7nYCoqn6SEqawoYY8pg1mBDIFZ+yZnWccruq2KmeZ
 OBENseppStM6HrY6HOCSgWfbPKYZiF3deZbO2y+iqdYG4fU+bFKFYiyhoVRj/cd5zsyR
 OrSmF+4LRIZgHKV13gIG6+82fsDQ2JDIM6ITQgs+RfUebac7eHod0YF5uDRcQFshlM9y
 Z5Zw==
X-Gm-Message-State: APjAAAU3N2OGbXyJnlVwdnGLb5di1J9uZY+mm7pW7bFkWDNXTRSF9q3g
 PP/d+gqZVS6B9pQhpD4riKY=
X-Google-Smtp-Source: APXvYqzTZHudJM/Abtv6WS+GeV69hWN5T+Wo9PU/xLj8uibDAmAJK7btL3sQNal+4rpDXuKK749EFg==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr3232441wmi.114.1573054428353; 
 Wed, 06 Nov 2019 07:33:48 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id h124sm3516154wmf.30.2019.11.06.07.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:33:47 -0800 (PST)
Date: Wed, 6 Nov 2019 16:33:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Avoid sending zero-size packets
Message-ID: <20191106153346.GA351622@stefanha-x1.localdomain>
References: <20190722132344.30798-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20190722132344.30798-1-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 01:24:44PM +0000, Oleinik, Alexander wrote:
> While fuzzing the virtio-net tx vq, I ran into an assertion failure due
> to iov_copy offsets larger than the total iov size. Though there is
> a check to cover this, it does not execute when !n->has_vnet_hdr. This
> patch tries to fix this.=20
> The call stack for the assertion failure:
>=20
> #8 in __assert_fail (libc.so.6+0x300f1)
> #9 in iov_copy iov.c:266:5
> #10 in virtio_net_flush_tx virtio-net.c:2073:23
> #11 in virtio_net_tx_bh virtio-net.c:2197:11
> #12 in aio_bh_poll async.c:118:13
> #13 in aio_dispatch aio-posix.c:460:5
> #14 in aio_ctx_dispatch async.c:261:5
> #15 in g_main_context_dispatch (libglib-2.0.so.0+0x4df2d)
> #16 in glib_pollfds_poll main-loop.c:213:9
> #17 in os_host_main_loop_wait main-loop.c:236
> #18 in main_loop_wait main-loop.c:512
> #19 in virtio_net_tx_fuzz virtio-net-fuzz.c:160:3
>=20
> v2: add details to  comment for the change to qemu_sendv_packet_async
>=20
> Alexander Oleinik (2):
>   net: assert that tx packets have nonzero size
>   virtio-net: check that tx packet has positive size
>=20
>  hw/net/virtio-net.c | 15 +++++++++------
>  net/net.c           |  9 +++++++++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.20.1

Ping

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C59oACgkQnKSrs4Gr
c8gItggAvcWeIgAO/8tbnOdnLhGhBJdi0yxIE6CUcSBjhtYsqkZlO2j3BdMrSXr2
N+xkdGqynJMYBokh01pw2u3kH58X9KbImLirmdqyaqWwxHG1WuBL2k6p5F7aoE2F
hwpX0t4dClyY74encR4k/EMSx93jh4bX8VurJ6yAhP2y86ro9v8uh0WkdFgKDS9f
NhZS4yA5DamRMqbXcnGMXB6Gvnj74RviDLJjSz63qRUEmcOi+wsJq5hgLEy3BG+C
Ei34Lp7EqlUbmI+jxb0NUDEJsODtj7z+6ZpuY322DYY9xhDbGd3gGoMoNYsQRjRi
5I+dPmVJR57gF/LHFhjxa88vExITew==
=eNn/
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

