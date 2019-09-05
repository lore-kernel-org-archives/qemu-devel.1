Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26865C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2527206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2527206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5tuu-0003tX-6e
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5ttp-0003NC-07
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5ttn-00060K-Lk
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i5ttj-0005ys-Lq; Thu, 05 Sep 2019 11:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DB624307D942;
 Thu,  5 Sep 2019 15:42:10 +0000 (UTC)
Received: from localhost (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7FE55D9E1;
 Thu,  5 Sep 2019 15:42:03 +0000 (UTC)
Date: Thu, 5 Sep 2019 16:42:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190905154202.GA31604@stefanha-x1.localdomain>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 05 Sep 2019 15:42:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/4] virtio/block: handle zoned backing
 devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 05:00:56PM -0400, Dmitry Fomichev wrote:
> Currently, attaching zoned block devices (i.e., storage devices
> compliant to ZAC/ZBC standards) using several virtio methods doesn't
> work properly as zoned devices appear as regular block devices at the
> guest. This may cause unexpected i/o errors and, potentially, some
> data corruption.
>=20
> To be more precise, attaching a zoned device via virtio-pci-blk,
> virtio-scsi-pci/scsi-disk or virtio-scsi-pci/scsi-hd demonstrates the
> above behavior. The virtio-scsi-pci/scsi-block method works with a
> recent patch. The virtio-scsi-pci/scsi-generic method also appears to
> handle zoned devices without problems.
>=20
> This patch set adds code to check if the backing device that is being
> opened is a zoned Host Managed device. If this is the case, the patch
> prohibits attaching such device for all use cases lacking proper
> zoned support.
>=20
> Host Aware zoned block devices are designed to work as regular block
> devices at a guest system that does not support ZBD. Therefore, this
> patch set doesn't prohibit attachment of Host Aware devices.
>=20
> Considering that there is still a couple of different working ways
> to attach a ZBD, this patch set provides a reasonable short-term
> solution for this problem.
>=20
> ZBD support for virtio-scsi-pci/scsi-disk and virtio-scsi-pci/scsi-hd
> does not seem as necessary. Users will be expected to attach zoned
> block devices via virtio-scsi-pci/scsi-block instead.
>=20
> This patch set contains some Linux-specific code. This code is
> necessary to obtain Zoned Block Device model value from Linux sysfs.
>=20
> History:
>=20
> v1 -> v2:
> - rework code to be permission-based
> - always allow Host Aware devices to be attached
> - add fix for Host Aware attachments aka RCAP output snoop
>=20
> v2 -> v3:
> - drop the patch for RCAP output snoop - merged separately
>=20
> v3 -> v4:
> - rebase to the current code
>=20
> v4 -> v5:
> - avoid checkpatch warning
>=20
> v5 -> v6:
> - address review comments from Stefan Hajnoczi
>=20
> Dmitry Fomichev (4):
>   block: Add zoned device model property
>   raw: Recognize zoned backing devices
>   block/ide/scsi: Set BLK_PERM_SUPPORT_HM_ZONED
>   raw: Don't open ZBDs if backend can't handle them
>=20
>  block.c                   | 15 +++++++
>  block/file-posix.c        | 89 +++++++++++++++++++++++++++++++++------
>  block/io.c                |  5 +++
>  hw/block/block.c          |  8 +++-
>  hw/block/fdc.c            |  5 ++-
>  hw/block/nvme.c           |  2 +-
>  hw/block/virtio-blk.c     |  2 +-
>  hw/block/xen-block.c      |  2 +-
>  hw/ide/qdev.c             |  2 +-
>  hw/scsi/scsi-disk.c       | 13 +++---
>  hw/scsi/scsi-generic.c    |  2 +-
>  hw/usb/dev-storage.c      |  2 +-
>  include/block/block.h     | 19 ++++++++-
>  include/block/block_int.h |  3 ++
>  include/hw/block/block.h  |  3 +-
>  15 files changed, 141 insertions(+), 31 deletions(-)
>=20
> --=20
> 2.21.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1xLMoACgkQnKSrs4Gr
c8gm9wf/eWHqRSxaAz1s1oLN94xefGAWUVkNj+FANr3fXtXkwuYrGByXnMzXTu8c
y8BWKXFg9PC2Hn1ze9+mJaXZE9BcOz+WqQygQN9mGWIGXdZ7XomYyrjlAvCUjQni
n3Wd8GvZGIvagFbPOyX42wbOP7zyI5gJ3Pie201/2Bt0STjCjBScPAiDVH6bvGVH
bwSLEuCI78MW6W/aJ7t2BtbviGKhrq+BQnkYb+UDPMdyKs1iek/BzO+9aPoQ8USJ
X0u7I6AW0jKD+sdH9vCMufWqbuG1t4IDAtgNzNNq6ePW6FlLe4AlFd5LMWaUKQ6q
ZYKt/pH/XqAbd0cI3BdHG/LaC0xWog==
=8DX6
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

