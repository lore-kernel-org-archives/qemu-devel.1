Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EC4C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8786024650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgf3Td1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8786024650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j57vh-0002oX-Nv
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j57uL-0001x9-KO
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j57uK-0001kx-NV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:59:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j57uK-0001jV-GQ; Fri, 21 Feb 2020 07:59:52 -0500
Received: by mail-wr1-x442.google.com with SMTP id g3so1946811wrs.12;
 Fri, 21 Feb 2020 04:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ic3TvMR6sY3dYWACWQNCTqlhOmpqqdXsiEb0ZyUjNC0=;
 b=cgf3Td1cQy/95jueOLliGhjHCs0VTanfSRpktp4mS7wOxRHWem903iCDBn6TSxe/Jp
 dlFTwatnIG+jK9trXciiCrZDdfi/EDbigJdYM9v97oD6MGI+3V4r90ZV4Dpts61I/Mru
 aT4CblgEGvPFM9f5aVhUKzjf5nZYSzLSjJnhrFc0VL5lNyrPSA7sQLLjNiw/0/nU1MPf
 Nj+1qYkeK6AyL3XZVqqMzoheyvsJjz/6ml5kUhhEJ44IzKuIF3pNbZ7xPdq/P+S62cC4
 QEdFEEehC9XH8xz3nsatSaYenaTKSidFKz/d/2LBFTkoVLnoBid5qfw41yfalKdkR17l
 890g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ic3TvMR6sY3dYWACWQNCTqlhOmpqqdXsiEb0ZyUjNC0=;
 b=JB04Dp7agbHX1QnZdr40pRHrLe0nVRnhWMYqZnc8cfj5m59oZNrBFn8wFtDNIb7Bwf
 TkQyyqZYecJXcEYZmGcLyDCUUz6Wfz4E4XnfzJ/fxqFL+b+vGVW8hVlRGTQsfiHLDxqV
 qK/kGvhBG9d17hUMSo/Mt6BnGO2jPFwAJCuImS1cHuQNLOdCelvpHMWQByUePg4aKeZE
 R10WwnVPYFAot7K4uZd2OC66bWqCzlZGSV6cuejaLIGW4BOXfSfhmC3k4g6dvwvFPcXB
 dUGPH5UfiLiWGiSc7L5rsRB2NSGYFQ9zHAJH13i7CbZcEmfp1d86fR0YCJoAq9OC8n1E
 aRNA==
X-Gm-Message-State: APjAAAXOjcvsXXTMKEuS4F9Z7sE41+dhHfY3NZSBrpFdigIuoz13401F
 J3AMXS7mLqjra5BzGJk87oU=
X-Google-Smtp-Source: APXvYqwVC8ELesI7xmCNH4alde2S0KO7gj/VGbVD8Zb2aSBBBIhEvO+7StatIf659cTGxMo9LYCI6g==
X-Received: by 2002:adf:b193:: with SMTP id q19mr48080779wra.78.1582289991062; 
 Fri, 21 Feb 2020 04:59:51 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h205sm3861712wmf.25.2020.02.21.04.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 04:59:49 -0800 (PST)
Date: Fri, 21 Feb 2020 12:59:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
Message-ID: <20200221125948.GI1484511@stefanha-x1.localdomain>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
 <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
In-Reply-To: <38c8e61b-377b-07bd-f55b-a1a773b72701@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 12:13:40PM +0100, Paolo Bonzini wrote:
> On 14/02/20 18:17, Stefan Hajnoczi wrote:
> > +    while ((node =3D QLIST_FIRST(ready_list))) {
> > +        QLIST_SAFE_REMOVE(node, node_ready);
>=20
> Why does this need safe remove?

Yes, it's necessary.  QLIST_SAFE_REMOVE() has two properties that make
it "safe":
1. It doesn't crash if the node is currently not on a list.
2. It clears the node's linked list pointers so that future linked
   list operations (like QLIST_SAFE_REMOVE()) aren't accidentally
   performed on stale pointers.

The node has a long lifespan and will be inserted into ready_lists
multiple times.  We need to safely remove it from ready_list to protect
against a corruption the next time the node is inserted into a
ready_list again:

  /* Add a handler to a ready list */
  static void add_ready_handler(AioHandlerList *ready_list,
                                AioHandler *node,
                                int revents)
  {
      QLIST_SAFE_REMOVE(node, node_ready); /* remove from nested parent's l=
ist */
      ^---- would cause corruption if node->node_ready was stale!

Would you like me to add a comment?

Stefan

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P1EQACgkQnKSrs4Gr
c8gQpwf/YKcopWjCIC4LQ6VVLNkWY+/saQwwCSWwsXV3PUpuHE6mlNdPxjVElEzp
t09vKlUhB47fG/acZPvixCeVi8Hz9vBdd/ayin9L6kE4kgm5FoTrxA89R6KhqcZU
d0C4UZhfUl6DH1V/6rhivBlB4HOkVx0BzXcbbLOeS0ralpyQJFuBf/PYRbkz4zZX
WX4jtRWei3zv4wppMq2OXyDJdk/wGjo0soXR6acObDudOIVrIGzHlO1zFBq0hsty
xufzLUjffPemF777cmj5dj0NEZG96ge8LqpaITkg/IVwF0k7cGb5MT+igaVoTxfm
sWixRt3UVsHW3Nh3Sxh22pho7pDy0w==
=XjKt
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--

