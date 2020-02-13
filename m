Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FEC3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CCA222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz/+VddL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CCA222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DA6-0000w5-Tf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2D8j-0007Vx-Of
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2D8i-00015d-Qz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2D8i-00015D-Ly
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581595120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7FKZn0341jFZl274bJiz1Mawl11b4qXCkZQjAuSv58=;
 b=Uz/+VddLhpgtC9zVB75kfB/HBl2u13b+IBMzLxrQs4mkWufU6GOCmNb25qy/ZEi3PVuDfZ
 hUCXzkZPeI85Y5vHIVYdn7MgYR5Iwh6xJu8w5MlUXFhb7e0Cex+DrOB38t8TSTATPpALBd
 rEB1mEDkm7yCRwntulUE9BhWSnmu1Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-PVyuMt8yP929W2QfMzcZiQ-1; Thu, 13 Feb 2020 06:58:35 -0500
X-MC-Unique: PVyuMt8yP929W2QfMzcZiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB1F418FF662;
 Thu, 13 Feb 2020 11:58:33 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F286427061;
 Thu, 13 Feb 2020 11:58:28 +0000 (UTC)
Date: Thu, 13 Feb 2020 11:58:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v9 02/23] softmmu: move vl.c to softmmu/
Message-ID: <20200213115827.GD544499@stefanha-x1.localdomain>
References: <20200211203510.3534-1-alxndr@bu.edu>
 <20200211203510.3534-3-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200211203510.3534-3-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2020 at 03:34:49PM -0500, Alexander Bulekov wrote:
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  Makefile.objs         | 2 --
>  Makefile.target       | 1 +
>  softmmu/Makefile.objs | 2 ++
>  vl.c => softmmu/vl.c  | 0
>  4 files changed, 3 insertions(+), 2 deletions(-)

Please update the ./MAINTAINERS entry for vl.c here too.

There is also a top_of_tree check in scripts/get_maintainer.pl that
needs to be updated in this commit.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FOeMACgkQnKSrs4Gr
c8h0cAf/ZlefFWQNaH1jgRyT1nWA3cVuQb+7JqiRGY1uNsH2XVI8udnWni4WYpoW
6ts7hpRS4UGkek6EMkZOV4Ja2Wh3/QxCssUD9dk10cjF+153IYFRF8jMBFK//CTB
zgVMT/ADdblxuFGG02vgXUkyVv+dIpVeqCyEOj2Ghjxiw1/hlM3cgKlA5uFr079I
TtUW5KFD9Q/aU+soGd337K0SJznARSk+ZS1OuUBQtu9GRgIIMkSUvZRi1QQYl+r1
u+i/zURVFuOhNvupV8m58haEzdRn6s48XQBaFTlr5X9xJRXJxITQeFD4u8rL6GFt
X3+bZ4nXofMTGPH+2r/LTziHUarN6g==
=63ri
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--


