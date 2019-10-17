Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46CECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451A420872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451A420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9PE-0003am-2f
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iL8Lg-0005I9-QM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iL8Lf-0000Am-Jc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iL8Lf-0000AS-BM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:09:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96BB43090FED;
 Thu, 17 Oct 2019 16:09:58 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18216194B6;
 Thu, 17 Oct 2019 16:09:54 +0000 (UTC)
Date: Thu, 17 Oct 2019 17:09:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
Message-ID: <20191017160953.GC1266@stefanha-x1.localdomain>
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 17 Oct 2019 16:09:58 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 01:23:57PM +0200, Miklos Szeredi wrote:
> On Thu, Oct 17, 2019 at 12:05 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >
> > On Wed, Oct 16, 2019 at 07:37:52PM +0900, Misono Tomohiro wrote:
> > > Hello,
> > >
> > > I test xattr operation on virtiofs using xfstest generic/062
> > > (with -o xattr option and XFS backend) and see some problems.
> > >
> > > These patches fixes the two of the problems.
> > >
> > > The remaining problems are:
> > >  1. we cannot xattr to block device created by mknod
> > >     which does not have actual device (since open in virtiofsd fails)
> > >  2. we cannot xattr to symbolic link
> > >
> > > I don't think 1 is a big problem but can we fix 2?
> >
> > Sorry, I don't know the answer.  Maybe it would be necessary to add a
> > new O_SYMLINK open flag to open(2) so that fgetxattr()/fsetxattr()
> > operations can be performed.  A kernel change like that would take some
> > time to get accepted upstream and shipped by distros, but it might be
> > the only way since the current syscall interface doesn't seem to offer a
> > way to do this.
>=20
> The real problem is that open() on a non-regular, non-directory file
> may have side effects (unless O_PATH is used).  These patches try to
> paper over that, but the fact is: opening special files from a file
> server is forbidden.
>=20
> I see why this is being done, and it's not easy to fix properly
> without the ..at() versions of these syscalls.  One idea is to fork()
> + fchdir(lo->proc_self_fd) + ..xattr().  Another related idea is to do
> a unshare(CLONE_FS) after each thread's startup (will pthread library
> balk?  I don't know) so that it's safe to do fchdir(lo->proc_self_fd)
> + ...xattr() + fchdir(lo->root_fd).

Looking at the f*xattr() code in the kernel, it doesn't really care
about the file descriptor, it wants the inode instead.  So the O_SYMLINK
idea I mentioned could also be called O_XATTR and be similar to O_PATH,
except that only f*xattr() calls are allowed on this file descriptor.

Stefan

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2oklEACgkQnKSrs4Gr
c8iiaAgAhKZnZLjRSpcFf1nJFWVOr+mJG0FqTEaivYCCOF73tUkhrRdfYz2J45Km
kkOJen8ZDZuNZPFl+y9WVn1OH7qtHHzYpNKXbmhyEa1FB1nPStM5+AGs5qNHIQgf
sXpFoQ56an1JyXg1IBqsH9V0blNVbH1vwlSsy7IkTXSNNFLz314CinvYe1RcfaWe
1EGL15xV8pEw1Zw5rHmhNx4c/E4HOcI5vBz9FwO/HGI9Z/Dui/bAyatb/Ko54YAS
lWObKy1P4ugUmz5COJzX/utS0SBEeidbjWhr81qs4p42fQYrDYZj/JsG2U/Ys8+H
t6XaGP9hT3Hoghq0e39FkATwyF72TQ==
=qReH
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

