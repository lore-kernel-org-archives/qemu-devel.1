Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9700C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4EC222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHR4sTpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4EC222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2D6m-0006OE-TD
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 06:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j2D5z-0005xz-Ty
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j2D5y-0005gQ-Sw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:55:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55427
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j2D5y-0005f9-ON
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581594950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1rVMWxOReqCblrRoQZXhcRuM3Ib6hO1d5IufaNIrnbs=;
 b=OHR4sTpl04WV6XiMHp1DzzuGb8dfpVl7ewkORG7tzMLoEON4Cx/Wo2PasYsptoKuXcuZns
 AW5LfyM6aekbV7lUpmq5eS7oxTQfjpKAxipYa9VPEWPkHgKZF8iW3gFRwx27RoZvjQCOrU
 XatINNt8FO1/NPG3XnlekL/7Mhj6Uf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-o0EH71H7N3qDki2ayJaztw-1; Thu, 13 Feb 2020 06:55:42 -0500
X-MC-Unique: o0EH71H7N3qDki2ayJaztw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E3941088383;
 Thu, 13 Feb 2020 11:55:41 +0000 (UTC)
Received: from localhost (unknown [10.36.118.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F63F5C1D6;
 Thu, 13 Feb 2020 11:55:37 +0000 (UTC)
Date: Thu, 13 Feb 2020 11:55:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v9 01/23] checkpatch: replace vl.c in the top of repo check
Message-ID: <20200213115536.GC544499@stefanha-x1.localdomain>
References: <20200211203510.3534-1-alxndr@bu.edu>
 <20200211203510.3534-2-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200211203510.3534-2-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
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

--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 03:34:48PM -0500, Alexander Bulekov wrote:
> 524b4c2c5c moves vl.c into softmmu/ , breaking the checkpatch

524b4c2c5c is a local git sha1.  That commit will have a different sha1
when applied to qemu.git/master.  Saying "The next patch" instead would
be fine.

However, this patch leaves the tree in a state where checkpatch.pl will
fail because softmmu/ doesn't exist yet!  Please squash this patch into
the next commit instead.

I guess you kept it separate because changing checkpatch.pl can be
thought of as a separate change.  However, they two need to happen in a
single step in order for checkpatch.pl to function correctly at each
commit.  Therefore it's appropriate to combine them into a single
commit.

> top-of-kernel-tree check. Replace with checks for softmmu and linux-user
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index ce43a306f8..2e2273b8a3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -462,7 +462,7 @@ sub top_of_kernel_tree {
>  =09my @tree_check =3D (
>  =09=09"COPYING", "MAINTAINERS", "Makefile",
>  =09=09"README.rst", "docs", "VERSION",
> -=09=09"vl.c"
> +=09=09"softmmu", "linux-user"
>  =09);
> =20
>  =09foreach my $check (@tree_check) {
> --=20
> 2.25.0
>=20

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5FOTgACgkQnKSrs4Gr
c8g/yQf9HFDHQ1rz4DrxBaQiZGMzSJgaMfrCKFDQ3zmhgvXkifa2anWd3RfmRUsm
Yl1psRtSm98VB3ADBuYtYMPx53kO7Cr6Ptyi4DiTYI8mkGExccRWMR+DT76VWJPm
IjuIGUVIf8D/ysqeHsFB4lwyHKUDLHI5RuOms+YlThWWOCkXkrrvsqLhrwbXyoE/
SgimeGz77mTTULGUvBjM8E3OXoop78K16Qezrp15tPt5JTdKlKhuQRySR2RQbLAb
oLghoaHAFW1Tf91vyBPv/hQjCRP1nAeWX7WEqWKBpS7Sd2DSdSNWG9VF6tBrzuO/
LFT3wOT9ZqLtQf/gsxrnGOjmRAmpRQ==
=QD9H
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--


