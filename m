Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD86C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C7220767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZASpJX0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C7220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHiE-0000qx-Pm
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHgm-00089Z-6F
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHgl-0007HU-Em
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:53:27 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHgj-0007AM-QH; Wed, 22 Apr 2020 11:53:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so2970216wmc.5;
 Wed, 22 Apr 2020 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=G/qiYYAA7cGuZBD16g6HwW/FSx1MLrSAor6/NWBzOi4=;
 b=ZASpJX0hV5BJYXY7WudUnuZwliDrdQkIS8vaH/FEnT7Uec7xsjlxZImoVtGxjBHnPZ
 ABd19MP0UvcBwkHbhPxrPM2kbk5WVl1hPF8n4ehYSxmnxeP383YEfs6JvUxCbxcB1qWM
 VxcyQNpCIzrXf1bjWSrcVYpB4rB/ThN3cRcJ0GiyM7ccmKSCbGKr6WgJB4frPhQkwMlk
 fAQBKfE4EvDET+rNIa92s6MitbaOauqhxZ27s4JGW2QsDlKPwtBCetqqdBVGP3Ujpi+R
 mt4RIs1Ljq4WHKA/oYUyntUXtQ4SVlvHHDpAnaUqJxlRB8liAS2U022Q4xFekDq4/hce
 oqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G/qiYYAA7cGuZBD16g6HwW/FSx1MLrSAor6/NWBzOi4=;
 b=k0bUHrVb6P99TbdeDdD2TEQXzcre2TdIYSPLQEpEeRnhb2HqECdlCDuXbYD8qbqC0p
 F47lNSYWXrd5e91QMoKuI/6cImpfPgCrfPNXtoyb0P2gcN8CHK3uMRAtggnYjWR/lVU4
 1KG604mPmcr8pwU7KmzikFikvc24a0c/eZ/X6Dd9WFoMqSMb0CVl85bD3lBWnj58hy7a
 Af2W9MIBfZo3BBVlbLo25zY0lxiCDzFgkAjwAObY4nTB115jYg3TDA0xZYPY35F+82Zo
 z95nrDubdmwXcn3ENyrwVOs3LojSZpOx8R06iPU27/Hqvq7i6QXftpPm+rWue+lfKtHv
 BY7Q==
X-Gm-Message-State: AGi0PuZT7l01lgQeMcXPOVzhZnisacfcK5+prbrNujtjGAAbaiCkQuvy
 4KRfHO4gSEGserIiLSqGw8A=
X-Google-Smtp-Source: APiQypIf3OZTZybnSfX5AOmCe8e6jYqsgKw5bh1l+ty3vK/gEMNVaJ9rzGkuow2niC7VCfVqb3ij2Q==
X-Received: by 2002:a1c:40c4:: with SMTP id n187mr10893889wma.28.1587570803934; 
 Wed, 22 Apr 2020 08:53:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a9sm7876704wmm.38.2020.04.22.08.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:53:22 -0700 (PDT)
Date: Wed, 22 Apr 2020 16:53:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC 0/3] 64bit block-layer part I
Message-ID: <20200422155321.GF47385@stefanha-x1.localdomain>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: fam@euphon.net, kwolf@redhat.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:18:15PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> There is an idea to make NBD protocol extension to support 64bit
> write-zero/discard/block-status commands (commands, which doesn't
> transfer user data). It's needed to increase performance of zeroing
> large ranges (up to the whole image). Zeroing of the whole image is used
> as first step of mirror job, qemu-img convert, it should be also used at
> start of backup actually..
>=20
> We need to support it in block-layer, so we want 64bit write_zeros.
> Currently driver handler now have int bytes parameter.
>=20
> write_zeros path goes through normal pwritev, so we need 64bit write,
> and then we need 64bit read for symmetry, and better, let's make all io
> path work with 64bit bytes parameter.
>=20
> Actually most of block-layer already have 64bit parameters: offset is
> sometimes int64_t and sometimes uint64_t. bytes parameter is one of
> int64_t, uint64_t, int, unsigned int...
>=20
> I think we need one type for all of this, and this one type is int64_t.
> Signed int64_t is a bit better than uint64_t: you can use same variable
> to get some result (including error < 0) and than reuse it as an
> argument without any type conversion.
>=20
> So, I propose, as a first step, convert all uint64_t parameters to
> int64_t.
>=20
> Still, I don't have good idea of how to split this into more than 3
> patches, so, this is an RFC.
>=20
> What's next?
>=20
> Converting write_zero and discard is not as simple: we can't just
> s/int/uint64_t/, as some functions may use some int variables for
> calculations and this will be broken by something larger than int.
>=20
> So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
> .bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
> drivers updated - drop unused 32bit functions, and then drop "64" suffix
> from API. If not - we'll live with both APIs.
>=20
> Another thing to do is updating default limiting of request (currently
> they are limited to INT_MAX).
>=20
> Then we may move some drivers to 64bit discard/write_zero: I think about
> qcow2, file-posix and nbd (as a proof-of-concept for already proposed
> NBD extension).

Sounds good to me.  This is a good series to merge early in the QEMU 5.1
release cycle.  That way we'll have time to catch any issues.

Stefan

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gaHEACgkQnKSrs4Gr
c8hlXQf+IVm/gexcMzoq6L9KRx+q95Fj0Q/0SbVdOgmWY5FzwHYBOosH9sGv9snp
Ab2X4bmw7ucmLD5uJrAzTIltjn4RRmZrQVjZdog3KSIfxhfK1DOF6Wk6x8ualpOW
L/wRHHTY7mWcSo3SJINYycU0Go8DZq/CszLLYnxVufu0S78EW+dN4lCFstymjptP
DwU0IoXtqw9OGi+vWKjz7nvHKNe5JdArYS1Sh9dNOHRg9tkmLTkJtdLXbiUOvWpb
otJ2RSksE/+crbr0LHF1GE/tPubXNr7d+B/8mxzkGlZ2ONB7RK4RoDxkzqX1kh1Q
aCgruH0IFMoc23AFZjZfq7UKe5OMTw==
=Wl+/
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--

