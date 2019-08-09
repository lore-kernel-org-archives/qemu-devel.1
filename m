Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE43C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9BE20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9BE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw09k-0000Ye-1t
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36411)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hw09B-0008AQ-RA
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hw098-0004yH-W2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hw097-0004tl-15
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 191773172D8A
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 08:21:04 +0000 (UTC)
Received: from localhost (ovpn-116-125.ams2.redhat.com [10.36.116.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2005C21A;
 Fri,  9 Aug 2019 08:21:03 +0000 (UTC)
Date: Fri, 9 Aug 2019 09:21:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190809082102.GB25286@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20190808095316.GC2852@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 09 Aug 2019 08:21:04 +0000 (UTC)
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> > 2. Can MAP/UNMAP be performed directly in QEMU via a separate virtqueue?
>=20
> I think there's two things to solve here that I don't currently know the
> answer to:
>   2a) We'd need to get the fd to qemu for the thing to mmap;
>       we might be able to cache the fd on the qemu side for existing
>       mappings, so when asking for a new mapping for an existing file then
>       it would already have the fd.
>=20
>   2b) Running a device with a mix of queues inside QEMU and on
>       vhost-user; I don't think we have anything with that mix

vhost-user-net works in the same way.  The ctrl queue is handled by QEMU
and the rx/tx queues by the vhost device.  This is in fact how vhost was
initially designed: the vhost device is not a full virtio device, only
the dataplane.

> > 3. Can READ/WRITE be performed directly in QEMU via a separate virtqueue
> >    to eliminate the bad address problem?
>=20
> Are you thinking of doing all read/writes that way, or just the corner
> cases? It doesn't seem worth it for the corner cases unless you're
> finding them cropping up in real work loads.

Send all READ/WRITE requests to QEMU instead of virtiofsd.

Only handle metadata requests in virtiofsd (OPEN, RELEASE, READDIR,
MKDIR, etc).

> > I'm not going to tackle DAX optimization myself right now but wanted to
> > share these ideas.
>=20
> One I was thinking about that feels easier than (2) was to change the
> vhost slave protocol to be split transaction; it wouldn't do anything
> for the latency but it would be able to do some in parallel if we can
> get the kernel to feed it.

There are two cases:
1. mmapping multiple inode.  This should benefit from parallelism,
   although mmap is still expensive because it involves TLB shootdown
   for all other threads running this process.
2. mmapping the same inode.  Here the host kernel is likely to serialize
   mmaps even more, making it hard to gain performance.

It's probably worth writing a tiny benchmark first to evaluate the
potential gains.

Stefan

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NLO4ACgkQnKSrs4Gr
c8jYDQf/XN0ZXJtQPCKujLwEvslkkiEkk+qyHbfXikVQJZHvYQgV7hWU8jNIcs6s
xMJDkbHp2fm6aOGj3f5Aihuzj41zHRfTgdPdsnQKZqB4X6nuCrkza63cC3GSdEpV
o6tfk3ef38OM17H7bDy5A25GVXYVsmfD2uR+8EPL55Zgjs6G/luZOx40tV340fZY
XchZsrGqNpcgxPK0pUk/mjb6PaZ0nnMGh7ggaWmx5VnLDM6DDu5A23twEqHRCJtM
uQ/Dc89oe1s2vSPeeiwapsXZK1lf3VE/5HUd20GcfMDbPuDflarTNB0Elj5p+zeU
ZeEDcjN8KnZ6vq0VmBWe3Z89duEYYA==
=2wte
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--

