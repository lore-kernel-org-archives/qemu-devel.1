Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BDDC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C132067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpFDwzyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C132067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLSi-0002k7-RX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jBLRx-0002F4-Oe
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jBLRw-0004UU-NP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:40:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jBLRw-0004UG-JG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583772016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vthUwcoR83pkJX6727uEbcs9bqc6PktRpq7keoSX31I=;
 b=GpFDwzyS73KNG1XzbI42FlMcia+hfT/UqW5S/KvRZm9fz1jE1wzh2lQ4tFHncRqH0abRQ0
 KgTHcJsffGkbbOTbrGyUO+d1swBUqsWfQVrcI6Z6sfg0Bsz0Mo2OQYWdVtbkcM7QQL6dJt
 FuR0+FbRwCX2vqjIjh00/1S9AEmEPAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-klQ2cae4OyG441xOcCY0YQ-1; Mon, 09 Mar 2020 12:40:13 -0400
X-MC-Unique: klQ2cae4OyG441xOcCY0YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66DAF107ACC4;
 Mon,  9 Mar 2020 16:40:12 +0000 (UTC)
Received: from localhost (unknown [10.36.118.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F00BE19C58;
 Mon,  9 Mar 2020 16:40:11 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:40:10 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
Message-ID: <20200309164010.GD46227@stefanha-x1.localdomain>
References: <20200224103406.1894923-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200224103406.1894923-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 10:34:04AM +0000, Stefan Hajnoczi wrote:
> QLIST_REMOVE() and friends leave dangling linked list pointers in the nod=
e that
> was removed.  This makes it impossible to decide whether a node is curren=
tly in
> a list or not.  It also makes debugging harder.
>=20
> Based-on: 20200222085030.1760640-1-stefanha@redhat.com
>           ("[PULL 00/31] Block patches")
>=20
> Stefan Hajnoczi (2):
>   qemu/queue.h: clear linked list pointers on remove
>   aio-posix: remove confusing QLIST_SAFE_REMOVE()
>=20
>  include/qemu/queue.h | 19 +++++++++++++++----
>  util/aio-posix.c     |  2 +-
>  2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.24.1
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5mcWoACgkQnKSrs4Gr
c8jsvQgAr4mX4XmwyL/Gcpvp/KLHpflsCue4DKTmNqY+Sc+tLrQDjbR5thYdl9js
rKFUaH1Sv9/h5m4b0AompqrEotPfJEIbpP5gNNbBtehU9PCdzespKp0dKeXLNeLI
tqz4zwMIeTuZpQ1kk3VAXPubvxbdYxajnv/EN7rA4bmLx5I5UaGP8Lf7ZogoF5pt
C/TDjo8oLq3338mrMm17m4KFs4rhPVJr0wBm9CFY1ysVTqMUEJdPkng40plKZsqC
Iab5MrWaud/MNGzZ8+ChHcsF0LewqXRmxKC5Px8DmBHkOUxV0ym723BGV7I5RvAs
DBTKJHEuxi/dVCAucQ8LxBZs6d14QQ==
=20Qh
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--


