Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AC5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BCB2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BCB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveJq-0004zG-5w
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hveJP-0004Xy-Sb
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hveJO-0003Se-Pt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hveJO-0003S4-Hq
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F0C03CA16
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 09:02:17 +0000 (UTC)
Received: from localhost (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C60FC600CC;
 Thu,  8 Aug 2019 09:02:14 +0000 (UTC)
Date: Thu, 8 Aug 2019 10:02:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20190808090213.GD31476@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20190807205715.GE18557@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 08 Aug 2019 09:02:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> Kernel also serializes MAP/UNMAP on one inode. So you will need to run
> multiple jobs operating on different inodes to see parallel MAP/UNMAP
> (atleast from kernel's point of view).

Okay, there is still room to experiment with how MAP and UNMAP are
handled by virtiofsd and QEMU even if the host kernel ultimately becomes
the bottleneck.

One possible optimization is to eliminate REMOVEMAPPING requests when
the guest driver knows a SETUPMAPPING will follow immediately.  I see
the following request pattern in a fio randread iodepth=64 job:

  unique: 995348, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
  lo_setupmapping(ino=135, fi=0x(nil), foffset=3860856832, len=2097152, moffset=859832320, flags=0)
     unique: 995348, success, outsize: 16
  unique: 995350, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
     unique: 995350, success, outsize: 16
  unique: 995352, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
  lo_setupmapping(ino=135, fi=0x(nil), foffset=16777216, len=2097152, moffset=861929472, flags=0)
     unique: 995352, success, outsize: 16
  unique: 995354, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12
     unique: 995354, success, outsize: 16
  virtio_send_msg: elem 9: with 1 in desc of length 16
  unique: 995356, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80, pid: 1351
  lo_setupmapping(ino=135, fi=0x(nil), foffset=383778816, len=2097152, moffset=864026624, flags=0)
     unique: 995356, success, outsize: 16
  unique: 995358, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60, pid: 12

The REMOVEMAPPING requests are unnecessary since we can map over the top
of the old mapping instead of taking the extra step of removing it
first.

Some more questions to consider for DAX performance optimization:

1. Is FUSE_READ/FUSE_WRITE more efficient than DAX for some I/O patterns?
2. Can MAP/UNMAP be performed directly in QEMU via a separate virtqueue?
3. Can READ/WRITE be performed directly in QEMU via a separate virtqueue
   to eliminate the bad address problem?
4. Can OPEN+MAP be fused into a single request for small files, avoiding
   the 2nd request?

I'm not going to tackle DAX optimization myself right now but wanted to
share these ideas.

Stefan

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1L5RUACgkQnKSrs4Gr
c8incggAoZCwEuTXkyQ6ttuPr8P1Rdi6m087BP7xgEgY9DGCioI13VAgBAoqG/YK
G+RLw90se/SMsxwjLFFgR1jRr+0yuxjLiy16Z35o9gSjEQAZ1MH9LVMm+3SECNYi
eV6Y1Dg73ilBjWPeLl9fw8QvWXy0mzZfpR8QsRvDQodCRsa+Ow9uNSafNPPCFQjS
OdxO0XIm8rpLAFC9ihganIFwAtJqJ8xw2F0tB7XO1Tm/eAv7AAHW2qjpQKblDcaD
zoq+56Nhr4lAu0gf4B/5+3czo9RVSUS+C5gJiYx7b7iisIGgB8GgniTmKaN7gQV6
tACb6kmjhl94zgP9yyzWxBuUjbWmlw==
=5pmm
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

