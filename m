Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0Za-0001nz-0X
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cE0ZW-0000g5-1F
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:13:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cE0ZV-0000fx-OT
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:13:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F06780F8E
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 21:13:12 +0000 (UTC)
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
	<1478105438-20883-3-git-send-email-prasanna.kalever@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2cd3263c-b7a8-cbb8-8b10-5b43f741a4b5@redhat.com>
Date: Mon, 5 Dec 2016 15:13:06 -0600
MIME-Version: 1.0
In-Reply-To: <1478105438-20883-3-git-send-email-prasanna.kalever@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R9KqqFcEo10obs1nvk6mD9WCrbU86d2sK"
Subject: Re: [Qemu-devel] [PATCH for-2.8 v3 2/3] block/nfs: fix QMP to match
 debug option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R9KqqFcEo10obs1nvk6mD9WCrbU86d2sK
From: Eric Blake <eblake@redhat.com>
To: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 qemu-devel@nongnu.org
Cc: jcody@redhat.com, vbellur@redhat.com
Message-ID: <2cd3263c-b7a8-cbb8-8b10-5b43f741a4b5@redhat.com>
Subject: Re: [PATCH for-2.8 v3 2/3] block/nfs: fix QMP to match debug option
References: <1478105438-20883-1-git-send-email-prasanna.kalever@redhat.com>
 <1478105438-20883-3-git-send-email-prasanna.kalever@redhat.com>
In-Reply-To: <1478105438-20883-3-git-send-email-prasanna.kalever@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2016 11:50 AM, Prasanna Kumar Kalever wrote:
> The QMP definition of BlockdevOptionsNfs:
> { 'struct': 'BlockdevOptionsNfs',
>   'data': { 'server': 'NFSServer',
>             'path': 'str',
>             '*user': 'int',
>             '*group': 'int',
>             '*tcp-syn-count': 'int',
>             '*readahead-size': 'int',
>             '*page-cache-size': 'int',
>             '*debug-level': 'int' } }
>=20
> To make this consistent with other block protocols like gluster, lets
> change s/debug-level/debug/
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---
>  block/nfs.c          | 4 ++--
>  qapi/block-core.json | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -2292,7 +2292,7 @@
>  # @page-cache-size:         #optional set the pagecache size in bytes =
(defaults
>  #                           to libnfs default)
>  #
> -# @debug-level:             #optional set the NFS debug level (max 2) =
(defaults
> +# @debug:                   #optional set the NFS debug level (max 2) =
(defaults
>  #                           to libnfs default)
>  #
>  # Since 2.8

This is the first release of this struct. We WANT to avoid making future
name changes, as well as to avoid silly inconsistencies between
different drivers.  So this is definitely 2.8 material.

Apologies for not flagging this thread sooner as needing to go in to one
of the earlier release candidates.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--R9KqqFcEo10obs1nvk6mD9WCrbU86d2sK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRdhiAAoJEKeha0olJ0NqPCMIAKcTimFeYMJ7ArD/o8vGMvrm
uMD49dxPRl5+AwbHokse8AV8HviYA9z25YagIoBarRGgMSWQTVUtPfBK4XSap4z8
RdheriN3fbrqfHJzG64NEhnLAAfRbz4i0SVQKIDEC9kVDzhUwaI+mGENSnBrFW7k
IBfsdyYaQ7qYIvZF2BM9NCKB1/2XzeHRjx60lkN2LXnnAZIotKhSSC1F+XlTp3V9
FISeqSl9u4F6v+lcSNR54RgXMx4BUzg+Rz+geQYSL96EC/FcugcaW8nBpZDafNIb
SCtM6eb5MLvJApZH2GShnk1atQcW27PHGwDenvlxqpK/8la8Gkd7XXQaIl8W4/o=
=khNF
-----END PGP SIGNATURE-----

--R9KqqFcEo10obs1nvk6mD9WCrbU86d2sK--
