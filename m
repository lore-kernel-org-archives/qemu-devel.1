Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9748C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD95D2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD95D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx7Dh-0008TT-VP
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 06:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hx7D7-00080d-Am
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hx7D5-00069y-SI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hx7D5-000697-Kb
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 06:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FD2D300C22C;
 Mon, 12 Aug 2019 10:05:50 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6206D19C4F;
 Mon, 12 Aug 2019 10:05:47 +0000 (UTC)
Date: Mon, 12 Aug 2019 11:05:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: piaojun <piaojun@huawei.com>
Message-ID: <20190812100546.GB9959@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
 <20190807205715.GE18557@redhat.com>
 <20190808090213.GD31476@stefanha-x1.localdomain>
 <20190808095316.GC2852@work-vm>
 <20190809082102.GB25286@stefanha-x1.localdomain>
 <277d9cd6-a8fa-fa1f-9cbc-7a7cd0897c84@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <277d9cd6-a8fa-fa1f-9cbc-7a7cd0897c84@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 10:05:50 +0000 (UTC)
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
 Vivek Goyal <vgoyal@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2019 at 10:26:18AM +0800, piaojun wrote:
> On 2019/8/9 16:21, Stefan Hajnoczi wrote:
> > On Thu, Aug 08, 2019 at 10:53:16AM +0100, Dr. David Alan Gilbert wrote:
> >> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> >>> On Wed, Aug 07, 2019 at 04:57:15PM -0400, Vivek Goyal wrote:
> >>> 3. Can READ/WRITE be performed directly in QEMU via a separate virtqu=
eue
> >>>    to eliminate the bad address problem?
> >>
> >> Are you thinking of doing all read/writes that way, or just the corner
> >> cases? It doesn't seem worth it for the corner cases unless you're
> >> finding them cropping up in real work loads.
> >=20
> > Send all READ/WRITE requests to QEMU instead of virtiofsd.
> >=20
> > Only handle metadata requests in virtiofsd (OPEN, RELEASE, READDIR,
> > MKDIR, etc).
> >=20
>=20
> Sorry for not catching your point, and I like the virtiofsd to do
> READ/WRITE requests and qemu handle metadata requests, as virtiofsd is
> good at processing dataplane things due to thread-pool and CPU
> affinity(maybe in the future). As you said, virtiofsd is just acting as
> a vhost-user device which should care less about ctrl request.
>=20
> If our concern is improving mmap/write/read performance, why not adding
> a delay worker for unmmap which could decrease the ummap times. Maybe
> virtiofsd could still handle both data and meta requests by this way.

Doing READ/WRITE in QEMU solves the problem that vhost-user slaves only
have access to guest RAM regions.  If a guest transfers other memory,
like an address in the DAX Window, to/from the vhost-user device then
virtqueue buffer address translation fails.

Dave added a code path that bounces such accesses through the QEMU
process using the VHOST_USER_SLAVE_FS_IO slavefd request, but it would
be simpler, faster, and cleaner to do I/O in QEMU in the first place.

What I don't like about moving READ/WRITE into QEMU is that we need to
use even more virtqueues for multiqueue operation :).

Stefan

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1ROfoACgkQnKSrs4Gr
c8i7pAf/UJVpVsfhaGANERAC2RS0451GRendQAyY7OIsHn/AcPA3FPs3trDolMFc
HH5/5KXVoXYdBNxmD2Y+k8snYxE/oIfACdOtxtcrv6UXz0qkd1AuJZPCofFReqhm
GpTrurV6GiITCQy4wa2rKSmLArsag6SZF/M6DJnHttuvqyPAphGsueP6yVF4ya5/
elPfokel4IgsoWUr1apQ1dFA4CQ4bZT3ETs9+gy0QnIf707qnaEnsGFfGopwYAXi
NVpVyBqSWERHpGvMZ588wBMXHcQmwrjuhK3JbXapae26uyaG0YhTxwQWpEsz+AdV
SA5gybi8yPaNdYoTXR2hNbPpHzPG/Q==
=NNAf
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

