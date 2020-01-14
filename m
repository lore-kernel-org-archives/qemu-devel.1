Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76F8C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B2424672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJzwfxcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B2424672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJe7-0004OS-Nx
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irJd9-0003R4-TF
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irJd8-0005LS-Qa
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:41:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1irJd6-0005KD-LM; Tue, 14 Jan 2020 05:41:00 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so13171020wmc.2;
 Tue, 14 Jan 2020 02:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LwgH84WUF6L6aEHAyScVkQk8vbZ229NPCtpSAuc5NLM=;
 b=VJzwfxcHjRe+4HxCwt6jX63ZsKluWPQx5TkNE5P2/RDh+hRh/2RkWX6PP5s6jZfPQD
 9cTrALmzRxBzxm6hZQRJNuYAPzvEtHEEhxU4DsNZuwmTyJ1+KhXICPf7Jv+aBQXj3GKw
 Zc+5JGzuc07oE5K08uFQ7XEyjphudpkQGBWHVdF2LWYtk0e08ItoZSwFvUc13AC0rNQb
 FDoZ8STuf5fgdrnvk/cRHAMgEHlO9FTkZho/rtFqhJ4bU8XOQfz8l14FfrorAOHXxzmb
 NpBc78z9jxoJJt4VDbcmEFetAHvC8rETDeeZAJwpQ0BtN6XQbZVJ1VmcvBKZnQcxQCGf
 N2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LwgH84WUF6L6aEHAyScVkQk8vbZ229NPCtpSAuc5NLM=;
 b=NefefDW6J/Gz+48CqqtSqDLCkPPwiXJK53fRR+irT8/lzXhRL7LiEoucapA1VHG9ED
 DegAZqo3jf9mcETZo5+pC/kuCTcyrivOFUNtf2WbXU0txS0iUUd/gJ3f4m6NKez1Oy3E
 XlFmOhzR1TG2Ps+ToPejQHOjHb6hHMetNc7zUkQR1Mxw9y1wSYMp0RKLuDfCSehps/nD
 AWkJCl7KTa7sPBU0CbzWRre4t1A3A+vHwEfvDDq0PPVPfI0dTVFd45p8iT8oQO0RYF2w
 SaxL6/+r2croK1ytaU08aX1zK6xj/DICg8FWD7dKrg+INYStFBM2f86vBgvcHR3leyQV
 3/UA==
X-Gm-Message-State: APjAAAVMkvMWq6FHJwwboA/EbT5k5MoLxM0kpQ8fbdgwGt40ugaHSoxw
 9ScXXUJjdE55f0eQwX2l0aA=
X-Google-Smtp-Source: APXvYqywRKjkxnt614sNVEtx0Nu0Y6isuA5OZfEZFa0o45/YmwKZ5I99YqsJ7WPCCvNi3uzOf2Hd5g==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr27474201wmh.104.1578998459780; 
 Tue, 14 Jan 2020 02:40:59 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y7sm3089263wmd.1.2020.01.14.02.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 02:40:58 -0800 (PST)
Date: Tue, 14 Jan 2020 10:40:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 04/15] block/io_uring: implements interfaces for
 io_uring
Message-ID: <20200114104057.GC118882@stefanha-x1.localdomain>
References: <20191218163228.1613099-1-stefanha@redhat.com>
 <20191218163228.1613099-5-stefanha@redhat.com>
 <20200113112407.xp7aad2m5b7t2xxi@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20200113112407.xp7aad2m5b7t2xxi@steredhat>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 12:24:07PM +0100, Stefano Garzarella wrote:
> On Wed, Dec 18, 2019 at 04:32:17PM +0000, Stefan Hajnoczi wrote:
> > From: Aarushi Mehta <mehta.aaru20@gmail.com>
> >=20
> > Aborts when sqe fails to be set as sqes cannot be returned to the
> > ring. Adds slow path for short reads for older kernels
> >=20
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v11:
> >  * Fix git bisect compilation breakage: move trace_luring_init_state()
> >    into the tracing commit.
> > v10:
> >  * Update MAINTAINERS file [Julia]
> >  * Rename MAX_EVENTS to MAX_ENTRIES [Julia]
> >  * Define ioq_submit() before callers so the prototype isn't necessary =
[Julia]
> >  * Declare variables at the beginning of the block in luring_init() [Ju=
lia]
> > ---
> >  MAINTAINERS             |   8 +
> >  block/Makefile.objs     |   3 +
> >  block/io_uring.c        | 401 ++++++++++++++++++++++++++++++++++++++++
> >  include/block/aio.h     |  16 +-
> >  include/block/raw-aio.h |  12 ++
> >  5 files changed, 439 insertions(+), 1 deletion(-)
> >  create mode 100644 block/io_uring.c
>=20
> There are few double spaces in several comment blocks, so if you need to
> respin maybe you can clean these, otherwise we can do later.

Double spaces are used throughout include/block/aio.h and generally in
QEMU.  Both a single space and double space are fine.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4dmrgACgkQnKSrs4Gr
c8jm0Af8Dp7rrVk2VJZ1HLWAKAdUpS8YqXLo6Uuhev3pZdWOFajEYzuXtZSJDhXU
G/ikrVEyYDOxbeqDMTHxFws4DMsQtXHaFsZ5P5NAxGXq4dR/8NL46iAJb2+Br6qs
IkU8obiIvjrEMTszXdniPf3MaiicyQxSP2Ssq5a7kzOaoqgmglUjfyHuHbe1Z1qa
MTxv96QkiLn1BInZmJ+RwV+WX8M+DF7ETod6b1a85KuzkUiTYKYkHi0mUTH4ajed
DLbZUZSj+yjSlKs5VWT4UyqNMi9eoGp4T5Gys7OH95AU3X0RpkYaSPlSPATunP1o
qR6w4UeyLnSJ1yl1mMS/9BWfmCdqdA==
=hiZZ
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

