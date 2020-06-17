Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47924C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D71F21548
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbIADM32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D71F21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYQX-0000Uc-8D
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYOy-0007OG-VC; Wed, 17 Jun 2020 09:46:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYOx-0007Js-3H; Wed, 17 Jun 2020 09:46:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id r15so2065791wmh.5;
 Wed, 17 Jun 2020 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=1b/4an5jiWrnNGFhUDqge0c+0ZlE5AaWLFGrYR3dnMo=;
 b=BbIADM320hJs1OQ73t+xp/8rtPrSp8Ft/+sU4fl1tRVUm0XVytVKZ5/QWPd4Vqn7X4
 M/djZjr2gP2JvrNjZ8zyvV6sMcXzWELH8dCxgwvMWmd1dqUKrb8+KSj9Cpg/2niEElZ4
 yB+JqWQUAjDogRyqzgDLxLQebBHNKsfX76UXXlGV5rIs2xcV3MikQuOYO4IH6EVONqcF
 aQ1bj8Y+MuHAf9lWL4NWs9Fc4WtgEcVzKODHWOhUOgEfkFELGamTXbPLcpRwO1SAuIY0
 apgRoX0a4fQoNEOuVtwpjv11VdGucLPDhcXXeLZOCh7RKRzkHqB++y+eRgJ1B0Jp8La1
 DoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1b/4an5jiWrnNGFhUDqge0c+0ZlE5AaWLFGrYR3dnMo=;
 b=ssTc2kTD/qYs8lt5/AbVUMa2lfTRffjWDXoU/v4PUrOx9g2JI9FocsW63Uu2gCcCg7
 Nm5AByLtxaBwOM83TR2xtB0DvplH35LcEBzvuKxHu52Az35pqaUdj1DYeLKD0FNITIu9
 TgDGGUByxQYHBwLNegA9Ha/kdDyjBqfP3wf0Y5bC1gSyK+km2zQH+BIBG/U+P4Lh0Pnw
 yPWb6q2DHf4qHTcKtepB30Pj41RSrAfnAWNHNirV/mEaQS3dmmNjcYvOA1OFtoJD/GVz
 T3tLu4u7vQP8yQdOCoIvCknQyMDfVZ3J1KCxxz3pGdjKYWUV4NhSYzqMR3xssjHzO8L3
 bM4A==
X-Gm-Message-State: AOAM532NUaMnY7lnP5qhm6k8pjrsY+kECGTu5VFvXjjcRaRQt28uuw3w
 vY0bsgThE72AI1ZEy31mThs=
X-Google-Smtp-Source: ABdhPJxeVUoOgxRc+9XhU9I4CcQcFLY4TJw5s7dwgKNHCPN8rBzmDnV2Cy7knyF9XMTBX1Y0e/5Csw==
X-Received: by 2002:a1c:4009:: with SMTP id n9mr8729348wma.104.1592401608358; 
 Wed, 17 Jun 2020 06:46:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c16sm419398wml.45.2020.06.17.06.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 06:46:47 -0700 (PDT)
Date: Wed, 17 Jun 2020 14:46:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3] block: Factor out bdrv_run_co()
Message-ID: <20200617134645.GE1728005@stefanha-x1.localdomain>
References: <20200520144901.16589-1-vsementsov@virtuozzo.com>
 <20200528151707.GH158218@stefanha-x1.localdomain>
 <99f13039-ae61-fc5e-43fa-8cbc3f3e1bab@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <99f13039-ae61-fc5e-43fa-8cbc3f3e1bab@virtuozzo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Stefan Hajnoczi <stefanha@redhat.com>, den@openvz.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 08:38:04PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 28.05.2020 18:17, Stefan Hajnoczi wrote:
> > On Wed, May 20, 2020 at 05:49:01PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > We have a few bdrv_*() functions that can either spawn a new coroutine
> > > and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
> > > alreeady running in a coroutine. All of them duplicate basically the
> > > same code.
> > >=20
> > > Factor the common code into a new function bdrv_run_co().
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > >     [Factor out bdrv_run_co_entry too]
> > > ---
> > >=20
> > > v3: keep created coroutine in BdrvRunCo struct for debugging [Kevin]
> > >=20
> > >   block/io.c | 193 ++++++++++++++++++++------------------------------=
---
> > >   1 file changed, 72 insertions(+), 121 deletions(-)
> >=20
> > Thanks, applied to my block tree:
> > https://github.com/stefanha/qemu/commits/block
> >=20
> > Stefan
> >=20
>=20
> Actually, [PATCH v5 0/7] coroutines: generate wrapper code
> substites this patch.. What do you think of it, could we take it instead?

This patch has already been merged but the "coroutines: generate wrapper
code" series can be reviewed and merged separately.

Stefan

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qHsUACgkQnKSrs4Gr
c8iDqwf9HD20gjTdTgiJnBGbKAKHSlQV9ZQpE6HH7ujfjyGGV4capaRjSxIcg3w8
xjaGfznS94POYOL7BYD7g9h6bPmqUZNQe3EpSu3WG9IvYQG2Ba7muUxYOjBGJx2N
KCBskcY5aIFU4lhRTkAhcxZN33XZxMEIgBBdLCxtXM7rotVWVeyoyvjQOASMtsv1
jafoBreaNJAOmN1PyzP7NsCvDQDXZ6fOopyA6GX2jtoTJ6DPAm9rNrflxu6Vc6IB
aGnZ3UXMy9dgsr/ShaOuYSVcP5QIvteAKqR0BW6EU335KBq+bFBfZKaQ4Dii8ArF
HhVF5a8MpUnm0Qle53UBxBhcsnxEGA==
=OZvs
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--

