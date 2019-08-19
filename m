Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43329C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EF320651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EF320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzk9t-0007A9-AD
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1hzk93-0006Zg-VY
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hzk92-0008W7-8v
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hzk92-0008UC-0k
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:04:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9B993CA06;
 Mon, 19 Aug 2019 16:04:29 +0000 (UTC)
Received: from localhost (ovpn-116-205.ams2.redhat.com [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5592F857BC;
 Mon, 19 Aug 2019 16:04:26 +0000 (UTC)
Date: Mon, 19 Aug 2019 17:04:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com
Message-ID: <20190819160426.GB2625@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 19 Aug 2019 16:04:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [ANNOUNCE] virtio-fs v0.3 release
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
Cc: qemu-devel@nongnu.org, kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am delighted to announce the release of virtio-fs v0.3, a shared file
system that lets virtual machines access a directory tree on the host.
This release is based on QEMU 4.1.0 and Linux 5.3-rc3.

For more information about virtio-fs: https://virtio-fs.gitlab.io/

This is a development release aimed at early adopters of virtio-fs.  Work is
being done to upstream the code into Linux and QEMU.  We expect to stop
publishing virtio-fs releases once the code has been merged by these upstream
projects.

Where to get it:

  https://gitlab.com/virtio-fs/linux/-/tags/virtio-fs-v0.3
  https://gitlab.com/virtio-fs/qemu/-/tags/virtio-fs-v0.3

Changes:

 * Please note that the mount syntax has changed to:

     # mount -t virtio_fs myfs /mnt -o ...

   The old syntax was "mount -t virtio_fs none /mnt -o tag=myfs,...".

 * virtiofsd --fd=FDNUM takes a listen socket file descriptor number.  File
   descriptor passing is an alternative way to manage the vhost-user UNIX
   domain socket.  The parent process no longer needs to wait for virtiofsd to
   create the listen socket before spawning the VM.

 * virtiofsd --syslog logs to syslog(2) instead of stderr.  Useful for unifying
   logging and when the virtiofsd process is not being supervised.

 * virtiofsd --thread-pool-size=NUM sets the maximum number of worker threads
   for FUSE request processing.  This can be used to control the host queue
   depth.  The default is 64.

 * Performance improvements and bug fixes.

Note for Kata Containers: the new kernel is not compatible with existing
Kata Containers releases due to the mount syntax change.  To try it out,
please apply the following kata-runtime patch:

  https://gitlab.com/virtio-fs/runtime/commit/a2e44de817e438c02a495cf258039774527e3178

Kata Containers patches for virtio-fs v0.3 are under development and will be
submitted to Kata soon.

Thanks to the following people for contributing code and to many more
for helping the virtio-fs effort:

Dr. David Alan Gilbert <dgilbert@redhat.com>
Eric Ren <renzhen@linux.alibaba.com>
Eryu Guan <eguan@linux.alibaba.com>
Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
Jiufei Xue <jiufei.xue@linux.alibaba.com>
Liu Bo <bo.liu@linux.alibaba.com>
Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Miklos Szeredi <mszeredi@redhat.com>
Peng Tao <tao.peng@linux.alibaba.com>
piaojun <piaojun@huawei.com>
Sebastien Boeuf <sebastien.boeuf@intel.com>
Stefan Hajnoczi <stefanha@redhat.com>
Vivek Goyal <vgoyal@redhat.com>
Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ayIkACgkQnKSrs4Gr
c8hAzQf9E4PbRDszsY7PdMkSP1YTi+I3Nv+dejPOnv98yeUdhv+vJFrrmsi4ZT0c
403/aP5zUg6+iIPUu8kjF1yCBeLNK5a6mNKtZT5k0o3uyUlHk1cNKAZaJimOm1UD
MYzgKTwvHkPd8ZLKwo1Ion1L597neZnF3SqhJE7pMbkKBNJvRPduY531zl2NwdJ8
+gH3MxPqyIlu0lwCdE1kdYe9gFP+CvWK9g0PMvkD+XhjdO21JxBNFaTu4jjzc+WV
MRndGHtT0fbqj75bS6coe8CMnaWUDoRbH03ByK048YjTidlYL2z5SVOLFKIidSmo
cA6OS1FyZs8XDU+GwvoHPvpCff8iJw==
=zbZx
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

