Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8776BC32757
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D172173E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D172173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0Cg-00028B-Kb
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hw0Bu-0001Gv-Qh
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hw0Bt-0006nb-Jn
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hw0Bt-0006mX-Bf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A15023CA14
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 08:24:00 +0000 (UTC)
Received: from localhost (ovpn-116-125.ams2.redhat.com [10.36.116.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81AE710013A1;
 Fri,  9 Aug 2019 08:23:57 +0000 (UTC)
Date: Fri, 9 Aug 2019 09:23:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID: <20190809082356.GC25286@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm> <20190808125320.GB3147@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20190808125320.GB3147@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 09 Aug 2019 08:24:00 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 08:53:20AM -0400, Vivek Goyal wrote:
> On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> > > > Kernel also serializes MAP/UNMAP on one inode. So you will need to =
run
> > > > multiple jobs operating on different inodes to see parallel MAP/UNM=
AP
> > > > (atleast from kernel's point of view).
> > >=20
> > > Okay, there is still room to experiment with how MAP and UNMAP are
> > > handled by virtiofsd and QEMU even if the host kernel ultimately beco=
mes
> > > the bottleneck.
> > >=20
> > > One possible optimization is to eliminate REMOVEMAPPING requests when
> > > the guest driver knows a SETUPMAPPING will follow immediately.  I see
> > > the following request pattern in a fio randread iodepth=3D64 job:
> > >=20
> > >   unique: 995348, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80,=
 pid: 1351
> > >   lo_setupmapping(ino=3D135, fi=3D0x(nil), foffset=3D3860856832, len=
=3D2097152, moffset=3D859832320, flags=3D0)
> > >      unique: 995348, success, outsize: 16
> > >   unique: 995350, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60=
, pid: 12
> > >      unique: 995350, success, outsize: 16
> > >   unique: 995352, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80,=
 pid: 1351
> > >   lo_setupmapping(ino=3D135, fi=3D0x(nil), foffset=3D16777216, len=3D=
2097152, moffset=3D861929472, flags=3D0)
> > >      unique: 995352, success, outsize: 16
> > >   unique: 995354, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60=
, pid: 12
> > >      unique: 995354, success, outsize: 16
> > >   virtio_send_msg: elem 9: with 1 in desc of length 16
> > >   unique: 995356, opcode: SETUPMAPPING (48), nodeid: 135, insize: 80,=
 pid: 1351
> > >   lo_setupmapping(ino=3D135, fi=3D0x(nil), foffset=3D383778816, len=
=3D2097152, moffset=3D864026624, flags=3D0)
> > >      unique: 995356, success, outsize: 16
> > >   unique: 995358, opcode: REMOVEMAPPING (49), nodeid: 135, insize: 60=
, pid: 12
> > >=20
> > > The REMOVEMAPPING requests are unnecessary since we can map over the =
top
> > > of the old mapping instead of taking the extra step of removing it
> > > first.
> >=20
> > Yep, those should go - I think Vivek likes to keep them for testing
> > since they make things fail more completely if there's a screwup.
>=20
> I like to keep them because otherwise they keep the resources busy
> on host. If DAX range is being used immediately, then this optimization
> makes more sense. I will keep this in mind.

Skipping all unmaps is has drawbacks, as you've said.  I'm just thinking
about the case where a mapping is replaced with a new one.

> >=20
> > > Some more questions to consider for DAX performance optimization:
> > >=20
> > > 1. Is FUSE_READ/FUSE_WRITE more efficient than DAX for some I/O patte=
rns?
> >=20
> > Probably for cases where the data is only accessed once, and you can't
> > preemptively map.
> > Another variant on (1) is whether we could do read/writes while the mmap
> > is happening to absorb the latency.
>=20
> For small random I/O, dax might not be very effective. Overhead of
> setting up mapping and tearing it down is significant.

Plus there is still an EPT violation and the host page cache needs to be
filled if we haven't prefetched it.  So I imagine FUSE_READ/FUSE_WRITE
will be faster than DAX here.  DAX will be better for repeated,
long-lived accesses.

Stefan

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NLZwACgkQnKSrs4Gr
c8haKQf/XDBFBSlJUHtGbmAeiJLkNMMmc3oabsCjQ+KUava1ZfbiG/bITLuQNUI3
LuKB0L8/LnXGU6F4Ua+YmOOPbmhdamoXVdRE9N5dN3sWz7j3kndS3zgETcR74OTL
cQIf3LLsKJ2vbnsQriQtZZpwdIbl71AYwAPUym20DE4JbjAV8IviiankxjxhCtgM
QIgYAdFDi5BHyl02wT883vd3RGnURZhOW+oGLrQX5PtSP3rLiOpfrUHnoRY4pksM
z1O98qAYH9iPxOah0LgPHfH8a+24rYXVk8pzCGX81DVoj63/xi3kqSvo9XAggHl4
/djr9k5hTfMkLondNe7vxBZg+dc6iA==
=IvQY
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--

