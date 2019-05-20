Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A12FC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C21214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C21214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlRI-0001hb-GM
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:47:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hSlPQ-0000F5-7a
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hSlPO-0001FT-NW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:45:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hSlPK-0001DY-Vl; Mon, 20 May 2019 12:45:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E13867EBDC;
	Mon, 20 May 2019 16:45:01 +0000 (UTC)
Received: from [10.3.116.56] (ovpn-116-56.phx2.redhat.com [10.3.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3373C17CD3;
	Mon, 20 May 2019 16:45:01 +0000 (UTC)
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, qemu-block@nongnu.org
References: <20190517084234.26923-1-klaus@birkelund.eu>
	<20190517084234.26923-9-klaus@birkelund.eu>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <f94686a4-b402-36c6-8070-185c0416b303@redhat.com>
Date: Mon, 20 May 2019 11:45:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517084234.26923-9-klaus@birkelund.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6iX2ARR7hZ2FehcUGWzivgn28DXPqxRKK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 20 May 2019 16:45:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 8/8] nvme: add an OpenChannel 2.0 NVMe
 device (ocssd)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6iX2ARR7hZ2FehcUGWzivgn28DXPqxRKK
From: Eric Blake <eblake@redhat.com>
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, qemu-block@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <f94686a4-b402-36c6-8070-185c0416b303@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] nvme: add an OpenChannel 2.0 NVMe device
 (ocssd)
References: <20190517084234.26923-1-klaus@birkelund.eu>
 <20190517084234.26923-9-klaus@birkelund.eu>
In-Reply-To: <20190517084234.26923-9-klaus@birkelund.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/17/19 3:42 AM, Klaus Birkelund Jensen wrote:
> This adds a new 'ocssd' block device that emulates an OpenChannel 2.0
> device. The device is backed by a new 'ocssd' block backend that is
> based on the raw format driver but includes a header that holds the
> device geometry and write data requirements. This new block backend is
> special in that the size is not specified explicitly but in terms of
> sector size, number of chunks, number of parallel units, etc. This
> called for the addition of the `no_size_required` field in `struct
> BlockDriver` to not fail image creation when the size parameter is
> missing.
>=20
> The ocssd device is an individual device but shares a lot of code with
> the nvme device. Thus, some core functionality of nvme/nvme.c has been
> exported for use by nvme/ocssd.c.
>=20
> Thank you to the following people for their contributions to the
> original qemu-nvme (github.com/OpenChannelSSD/qemu-nvme) implementation=
=2E
>=20
>   Matias Bj=C3=B8rling <mb@lightnvm.io>
>   Javier Gonz=C3=A1lez <javier@javigon.com>
>   Simon Andreas Frimann Lund <ocssd@safl.dk>
>   Hans Holmberg <hans@owltronix.com>
>   Jesper Devantier <contact@pseudonymous.me>
>   Young Tack Jin <youngtack.jin@circuitblvd.com>
>=20
> Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> ---
>  MAINTAINERS                     |   14 +-
>  Makefile.objs                   |    1 +
>  block.c                         |    2 +-
>  block/Makefile.objs             |    2 +-
>  block/nvme.c                    |    2 +-
>  block/ocssd.c                   |  690 ++++++++
>  hw/block/Makefile.objs          |    2 +-
>  hw/block/{ =3D> nvme}/nvme.c      |  192 ++-
>  hw/block/nvme/ocssd.c           | 2647 +++++++++++++++++++++++++++++++=

>  hw/block/nvme/ocssd.h           |  140 ++
>  hw/block/nvme/trace-events      |  136 ++
>  hw/block/trace-events           |  109 --
>  include/block/block_int.h       |    3 +
>  include/block/nvme.h            |   12 +-
>  include/block/ocssd.h           |  231 +++
>  {hw =3D> include/hw}/block/nvme.h |   61 +
>  include/hw/pci/pci_ids.h        |    2 +
>  qapi/block-core.json            |   47 +-
>  18 files changed, 4121 insertions(+), 172 deletions(-)
>  create mode 100644 block/ocssd.c
>  rename hw/block/{ =3D> nvme}/nvme.c (94%)
>  create mode 100644 hw/block/nvme/ocssd.c
>  create mode 100644 hw/block/nvme/ocssd.h
>  create mode 100644 hw/block/nvme/trace-events
>  create mode 100644 include/block/ocssd.h
>  rename {hw =3D> include/hw}/block/nvme.h (63%)

Feels big; are you sure this can't be split into smaller pieces to ease
review?

I'm focusing just on the qapi portions:


> +++ b/qapi/block-core.json
> @@ -113,6 +113,44 @@
>        'extents': ['ImageInfo']
>    } }
> =20
> +##
> +# @ImageInfoSpecificOcssd:
> +#
> +# @num-ns: number of namespaces
> +#
> +# @namespaces: List of namespsaces

Inconsistent on whether you start with lower or upper case.

> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'ImageInfoSpecificOcssd',
> +  'data': {
> +      'num-ns': 'int',
> +      'sector-size': 'int',
> +      'metadata-size': 'int',
> +      'namespaces': ['ImageInfoSpecificOcssdNS']

Is num-ns redundant information (that is, if I count the length of the
array in namespaces, I don't need num-ns)?

You failed to document sector-size and metadata-size.

> +  } }
> +
> +##
> +# @ImageInfoSpecificOcssdNS:
> +#
> +# @num-grp: number of groups
> +#
> +# @num-pu: number of parallel units per group
> +#
> +# @num-chk: number of chunks per parallel unit
> +#
> +# @num-sec: number of sectors per chunk

Why the abbreviation? Machines don't care if they have to pass something
slightly longer, and if it makes the job easier for the human reading
the machine traces, then spelling things out (such as 'num-groups'),
then abbreviation didn't buy us anything useful.

> +#
> +# Since: 3.1

You missed 3.1 by a long shot. The next release is 4.1.

> +##
> +{ 'struct': 'ImageInfoSpecificOcssdNS',
> +  'data': {
> +      'num-grp': 'int',
> +      'num-pu': 'int',
> +      'num-chk': 'int',
> +      'num-sec': 'int'
> +  } }
> +
>  ##
>  # @ImageInfoSpecific:
>  #
> @@ -124,6 +162,7 @@
>    'data': {
>        'qcow2': 'ImageInfoSpecificQCow2',
>        'vmdk': 'ImageInfoSpecificVmdk',
> +      'ocssd': 'ImageInfoSpecificOcssd',

Perhaps missing a doc comment that ocssd is new to 4.1; although it may
be implied by the documentation adding 'occsd' to the list of overall
block types elsewhere....

>        # If we need to add block driver specific parameters for
>        # LUKS in future, then we'll subclass QCryptoBlockInfoLUKS
>        # to define a ImageInfoSpecificLUKS
> @@ -282,7 +321,7 @@
>  # @drv: the name of the block format used to open the backing device. =
As of
>  #       0.14.0 this can be: 'blkdebug', 'bochs', 'cloop', 'cow', 'dmg'=
,
>  #       'file', 'file', 'ftp', 'ftps', 'host_cdrom', 'host_device',
> -#       'http', 'https', 'luks', 'nbd', 'parallels', 'qcow',
> +#       'http', 'https', 'luks', 'nbd', 'ocssd', 'parallels', 'qcow',
>  #       'qcow2', 'raw', 'vdi', 'vmdk', 'vpc', 'vvfat'
>  #       2.2: 'archipelago' added, 'cow' dropped
>  #       2.3: 'host_floppy' deprecated
> @@ -290,6 +329,7 @@
>  #       2.6: 'luks' added
>  #       2.8: 'replication' added, 'tftp' dropped
>  #       2.9: 'archipelago' dropped
> +#       4.1: 'ocssd' added

=2E..here

>  #
>  # @backing_file: the name of the backing file (for copy-on-write)
>  #
> @@ -2815,8 +2855,8 @@
>    'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',=

>              'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
>              'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'lu=
ks',
> -            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', =
'qcow',
> -            'qcow2', 'qed', 'quorum', 'raw', 'rbd',
> +            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'ocssd', 'par=
allels',
> +            'qcow', 'qcow2', 'qed', 'quorum', 'raw', 'rbd',
>              { 'name': 'replication', 'if': 'defined(CONFIG_REPLICATION=
)' },
>              'sheepdog',
>              'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', =
'vxhs' ] }
> @@ -3917,6 +3957,7 @@
>        'null-aio':   'BlockdevOptionsNull',
>        'null-co':    'BlockdevOptionsNull',
>        'nvme':       'BlockdevOptionsNVMe',
> +      'ocssd':      'BlockdevOptionsGenericFormat',

I guess you don't support qemu creating one of these devices yet?

>        'parallels':  'BlockdevOptionsGenericFormat',
>        'qcow2':      'BlockdevOptionsQcow2',
>        'qcow':       'BlockdevOptionsQcow',
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6iX2ARR7hZ2FehcUGWzivgn28DXPqxRKK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzi2YwACgkQp6FrSiUn
Q2rsfAf/UV784Ckd0piM4V81UA7CTQYL87t+QN2PY8yjiehze0X4eRKjIL4qJtUL
1VAZiVta7cSCHJAyzCTl6jjWbsyImxbbCgH5EzzRrOoE77xopjuKM8SwRbNDDt1X
wSU3AXhuSrfApAXXwCTZqkwyw8/hhQz6xYqkQF+jwwOlDFNU1MQdpzUeNiOJvdSc
X80jFIs6d12OXWdkSmNfeEHl/WzRXPgjBuu2GBu3IEdtcXFNdhweE7NFPnVEvwFl
EMo/lceIMVxvaPEs5iqqDghskHCHGL6uxOepMJp0US7DXrJa4HA62PTgfs9dAlNy
o84sK95fsin21TXGiH3oMUALcq7QGA==
=ul4O
-----END PGP SIGNATURE-----

--6iX2ARR7hZ2FehcUGWzivgn28DXPqxRKK--

