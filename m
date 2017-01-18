Received: from eggs.gnu.org ([2001:4830:134:3::10]:36946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsgo-0001dE-Lu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsgo-0006hF-0C
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsgn-0006g8-Qy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:02:21 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E659DD3C21
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:02:21 +0000 (UTC)
Date: Wed, 18 Jan 2017 16:02:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118160219.GR30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOEfHYdX8LquYLAx"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/16] aio_context_acquire/release pushdown, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--qOEfHYdX8LquYLAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:15PM +0100, Paolo Bonzini wrote:
>  hw/block/virtio-blk.c          |  19 +++-
>  hw/scsi/scsi-bus.c             |   2 +
>  hw/scsi/scsi-disk.c            |  15 +++
>  hw/scsi/scsi-generic.c         |  20 +++-
>  hw/scsi/virtio-scsi.c          |   6 ++

Are all the other device models safe because they don't support
IOThread?

Stefan

--qOEfHYdX8LquYLAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf5GLAAoJEJykq7OBq3PIpV0IALRxxvaqNHSn5GubySAut371
z/gbXe1AyVOxV8npdNdSKG+fPMtjTrXizRCy8PnsidZvvinOZaf7yowaEIe+JdIW
8/IebAOs4l0bCVXsYtFhUBlG9AI0oPeQIQV9HbJdc7/SAY+QHf03ZU4MiDa14gO8
RZyGL45kOqSL6jvfZClpFbec2sp9kHMlbSJ3o8tIgBQiQ+aoxHbSCqnfsV+RkA0m
PslIaeJoPseehR/MQR82kmXfGmzb/HqjK10X2NrhOs8eGElDrgIAVNrU/PhsgiKX
2vh6FotJ/XIkgcPnyD3e5K+syt5CFcSvVdAVGxyUfuL0D+ZEk86R4+bZnzMqp/s=
=CD8z
-----END PGP SIGNATURE-----

--qOEfHYdX8LquYLAx--
