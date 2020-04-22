Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA4EC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1666620774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLJPYhHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1666620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHw3-00077s-9s
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHth-0004j6-IU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHth-0001cY-83
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:06:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHtc-0001Qv-5V; Wed, 22 Apr 2020 12:06:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id t63so2993371wmt.3;
 Wed, 22 Apr 2020 09:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1lna5gTgWOeZGs1DR8Skjzz0QrxTfKJV0wqCOhQXZ4c=;
 b=DLJPYhHXbT3xCL3USFzv412GGy9LcukZLGXEKCKvT6Dy1JXAOoo7VOLV+DdtFAmPUN
 KecacajBw3GF+2PmaBxGVlzkNY2JiY0NV2mcNQUlZ+0NzGLLkRjmQCNieTy3n+ObV8Ig
 v2+byD51HT1xt7ofH9bf2V+Q3YeUrdqqSjKgcQiDOtb1WPmSTUcvpbBWGt2MSHMzHaYk
 uiZU8M8un4c3BofNUcPl8w7AdBIqCdCaLsjZniCU2Y/xdNj/hopoIydOD41BiW1FA6p/
 cFVRLwn/Pgmx7vFrcp6t4LYb6y6bRUdJDePJKmv46Cs+yer5Is6LoYZX4/1GCuyNJAIQ
 29Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1lna5gTgWOeZGs1DR8Skjzz0QrxTfKJV0wqCOhQXZ4c=;
 b=EKpbAbN+eyPRHLhkhzwWvgXes2/BUhJSeEetWg/FpyWKZ/r0MmIW18hhyZZfiupvW/
 hPcJKOzJ7yBVfC2kjNGIcOTd3cIn+xuy/UL3Q7C8C3lI0pCV5HM1hvWaD2v3HepdFb3T
 3J5B/jbNS1+ZXCac10AStHPsO6PgTThnUSAfYk7s7xfS4D4hzkNs80wtTW6LyB4Vx1Le
 87O1CA68fPVNUdDzf9k4V4D/ew0IjbNH8zLs7fE9JhXn/Y3WFCqJcrAIxMFIvnexPSTQ
 3CJyPxL1fs7A/3o7pFtDx7LimfrUS6DGQ0rsxzmffiY6lHoaKzm0G5zED3xIZ06EKv0r
 q7bw==
X-Gm-Message-State: AGi0PuZ+5dbLM2FnhD4bnIqvScEIRXppG0E+5lTe5mPIrhJhFIvgMwxf
 tWnzjOfcQwVxt7fiXhDGDw0=
X-Google-Smtp-Source: APiQypKKanCqyxkGPe/DxZAERzdXd+j4Hcsplcw5hOSIJX1t6mlggznvRNTFZ4Q48CXYiwYwj1ggmQ==
X-Received: by 2002:a1c:154:: with SMTP id 81mr11160414wmb.48.1587571601839;
 Wed, 22 Apr 2020 09:06:41 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 74sm9283731wrk.30.2020.04.22.09.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 09:06:40 -0700 (PDT)
Date: Wed, 22 Apr 2020 17:06:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 5/9] block/io: expand in_flight inc/dec section: simple
 cases
Message-ID: <20200422160639.GH47385@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-6-vsementsov@virtuozzo.com>
 <20200420162255.GE7321@stefanha-x1.localdomain>
 <67b95ad8-2a19-5698-d683-f799c024cb01@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline
In-Reply-To: <67b95ad8-2a19-5698-d683-f799c024cb01@virtuozzo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 04:47:07PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 20.04.2020 19:22, Stefan Hajnoczi wrote:
> > On Wed, Apr 08, 2020 at 12:30:47PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > It's safer to expand in_flight request to start before enter to
> >=20
> > Please explain what exeactly "safer" means.  If I understand correctly
> > this is just a refactoring and does not fix bugs that have been hit in
> > the real world.
> >=20
> > Is this just a generate attempt to avoid accidentally performing
> > operations that need to happen as part of the request after the dec
> > call?
>=20
> Consider write.
>=20
> It's possible, that qemu_coroutine_enter only schedules execution, assume=
 such case.
> Then we may possibly have the following:
>=20
> 1. Somehow check that we are not in drained section in outer code
>=20
> 2. call bdrv_pwritev(), assuming that it will increse in_flight, which wi=
ll protect us from starting drained section
>=20
> 3. it calls bdrv_prwv_co -> bdrv_coroutine_enter (not yet increased in_fl=
ight)
>=20
> 4. assume coroutine not yet actually entered, only scheduled, and we go t=
o some code, which starts drained section (as in_flight is zero)
>=20
> 5. scheduled coroutine starts, and blindly increases in_flight, and we ar=
e in drained section with in_flight request.
>=20
> The series does the same thing for block/io.c like Kevin's "block: Fix bl=
k->in_flight during blk_wait_while_drained()" for blk layer.

Please include this in the commit description.  Thanks!

Stefan

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ga48ACgkQnKSrs4Gr
c8gqwQf+N51Jvfl6eeRMeFLHsXfB+G/Tq4yFcN2qZlfq+Ztzj2wggtKYpudMbsmC
evyTErRCKS1/DpvmmJMwjAFyX2A/DnujVhefrY3ELjZnTUzpNAYO3IMHvstPegGw
6NoeRMILfFs0zYU3hn1ta5miZ0K1YvniUGMlbmQGf4E3VN9PczaQY/hQsIfNMp+X
ZcHVAGNDc4ZWblUz5G7ZVpgULdh4hR9n700ofYe+kSOSzvA3F82EjGE/DdeTE6Y/
DFsS6nAo9Kf7bgCzjtK3bZpXAgQkpm/3sPr5nMwiOXc8LZANreRZfJ2H43EXdnZ1
fHCW9IvvEYgPNZnZsdZym5Lgc+9+tg==
=sqNn
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

