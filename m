Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ECFECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF9720869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF9720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2fd-0005CV-PK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iL2f1-0004nj-Ul
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iL2ez-0005gE-PM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iL2ez-0005fn-JN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:05:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 946BB89B002;
 Thu, 17 Oct 2019 10:05:32 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4965A5D9CA;
 Thu, 17 Oct 2019 10:05:29 +0000 (UTC)
Date: Thu, 17 Oct 2019 11:05:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191017100528.GA24790@stefanha-x1.localdomain>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 17 Oct 2019 10:05:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, mszeredi@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 07:37:52PM +0900, Misono Tomohiro wrote:
> Hello,
>=20
> I test xattr operation on virtiofs using xfstest generic/062
> (with -o xattr option and XFS backend) and see some problems.
>=20
> These patches fixes the two of the problems.
>=20
> The remaining problems are:
>  1. we cannot xattr to block device created by mknod
>     which does not have actual device (since open in virtiofsd fails)
>  2. we cannot xattr to symbolic link
>=20
> I don't think 1 is a big problem but can we fix 2?

Sorry, I don't know the answer.  Maybe it would be necessary to add a
new O_SYMLINK open flag to open(2) so that fgetxattr()/fsetxattr()
operations can be performed.  A kernel change like that would take some
time to get accepted upstream and shipped by distros, but it might be
the only way since the current syscall interface doesn't seem to offer a
way to do this.

>=20
> Misono Tomohiro (2):
>   virtiofsd: Avoid process hang when doing xattr operation to FIFO
>   virtiofsd: Allow setxattr operation to directry
>=20
>  contrib/virtiofsd/passthrough_ll.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.21.0
>=20
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2oPOgACgkQnKSrs4Gr
c8jxtgf/WI9gWbbOf82Q7BK4jYeVjCxtU+4YSMk2a9IWhkctkK6irnIYUsj9Aw/X
EqQ8by0dZmAYqDV6e9rtW1gaKS0wAOEYhaf5hh+mKAi+NXT+bYyfKp00yePClObI
N0lEO9oVNnDlXag5T3BBfgN/Nrw9StUlBhY9S8eOYsl9nhBgiJJSpbpzYK6FsvMw
TtkR1MRGf90GGgDXkAeKvbUgVnT+TLEchHogS3TwUHBeKxX3+EvR0kCuw+NoUolB
VUyd9JnhSuNswXiY4ghlJfPBI1K42pohzHF8Ax39Qq0aLN573hSEV0VmM5vKWiMB
dprF3PxuPcRZt355mz5puhlUqVKoFQ==
=No4s
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

