Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964BC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D4220726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQCkgHLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D4220726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzxH-0005a6-KN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izzwd-00058L-BA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izzwZ-0006jK-K1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:29:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izzwZ-0006j6-EB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581067738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BW6YJMmtelWtT/KA86ycR2d2cdxrJb35lAcMI0v5/4Y=;
 b=hQCkgHLoesvgBmu1evuzsfKgCSpX2WQ276rAjpAPwRktM+4bNJFqu/+ae9DJRfLCib2GCQ
 x3X8TU4sVsMAHMO9Wi3kmaeQrPcryIRgZ4OrHzmileWF9S0N+J+s1RGgxVRHlhYJUHejol
 1b4KLH9LNu0LXm/UtroK9JWbD4+2/Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-AcJraUtgPjaz2pzuUuGP9Q-1; Fri, 07 Feb 2020 04:28:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F8801034B40;
 Fri,  7 Feb 2020 09:28:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA565C3FD;
 Fri,  7 Feb 2020 09:28:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 941A311386A7; Fri,  7 Feb 2020 10:28:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 10:28:47 +0100
In-Reply-To: <20200206173040.17337-9-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:19 +0000")
Message-ID: <87pnequ4og.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AcJraUtgPjaz2pzuUuGP9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Some qapi doc comments have forgotten the ':' after the
> @argument, like this:
>
> # @filename         Filename for the new image file
> # @size             Size of the virtual disk in bytes
>
> The result is that these are parsed as part of the body
> text and appear as a run-on line:
>   filename Filename for the new image file size Size of the virtual disk =
in bytes"
> followed by
>   filename: string
>     Not documented
>   size: int
>     Not documented
>
> in the 'Members' section.

Easy error to make, and due to the "anything goes" nature of the doc
comment syntax, the QAPI generator won't help you.

>
> Correct the formatting.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json | 236 +++++++++++++++++++++----------------------
>  1 file changed, 118 insertions(+), 118 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 372f35ee5f0..076a4a4808e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3235,9 +3235,9 @@
>  ##
>  # @SshHostKeyCheckMode:
>  #
> -# @none             Don't check the host key at all
> -# @hash             Compare the host key with a given hash
> -# @known_hosts      Check the host key against the known_hosts file
> +# @none: Don't check the host key at all
> +# @hash: Compare the host key with a given hash
> +# @known_hosts: Check the host key against the known_hosts file
>  #
>  # Since: 2.12
>  ##
> @@ -3247,8 +3247,8 @@
>  ##
>  # @SshHostKeyCheckHashType:
>  #
> -# @md5              The given hash is an md5 hash
> -# @sha1             The given hash is an sha1 hash
> +# @md5: The given hash is an md5 hash
> +# @sha1: The given hash is an sha1 hash
>  #
>  # Since: 2.12
>  ##
> @@ -3258,8 +3258,8 @@
>  ##
>  # @SshHostKeyHash:
>  #
> -# @type             The hash algorithm used for the hash
> -# @hash             The expected hash value
> +# @type: The hash algorithm used for the hash
> +# @hash: The expected hash value
>  #
>  # Since: 2.12
>  ##
> @@ -4265,13 +4265,13 @@
>  #
>  # Driver specific image creation options for file.
>  #
> -# @filename         Filename for the new image file
> -# @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (default: off;
> -#                   allowed values: off,
> -#                   falloc (if defined CONFIG_POSIX_FALLOCATE),
> -#                   full (if defined CONFIG_POSIX))
> -# @nocow            Turn off copy-on-write (valid only on btrfs; default=
: off)
> +# @filename: Filename for the new image file
> +# @size: Size of the virtual disk in bytes
> +# @preallocation: Preallocation mode for the new image (default: off;
> +#                 allowed values: off,
> +#                 falloc (if defined CONFIG_POSIX_FALLOCATE),
> +#                 full (if defined CONFIG_POSIX))
> +# @nocow: Turn off copy-on-write (valid only on btrfs; default: off)
>  #
>  # Since: 2.12
>  ##
> @@ -4286,12 +4286,12 @@
>  #
>  # Driver specific image creation options for gluster.
>  #
> -# @location         Where to store the new image file
> -# @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (default: off;
> -#                   allowed values: off,
> -#                   falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
> -#                   full (if defined CONFIG_GLUSTERFS_ZEROFILL))
> +# @location: Where to store the new image file
> +# @size: Size of the virtual disk in bytes
> +# @preallocation: Preallocation mode for the new image (default: off;
> +#                 allowed values: off,
> +#                 falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
> +#                 full (if defined CONFIG_GLUSTERFS_ZEROFILL))
>  #
>  # Since: 2.12
>  ##
> @@ -4305,11 +4305,11 @@
>  #
>  # Driver specific image creation options for LUKS.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image
> -#                   (since: 4.2)
> -#                   (default: off; allowed values: off, metadata, falloc=
, full)
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @preallocation: Preallocation mode for the new image
> +#                 (since: 4.2)
> +#                 (default: off; allowed values: off, metadata, falloc, =
full)
>  #
>  # Since: 2.12
>  ##
> @@ -4324,8 +4324,8 @@
>  #
>  # Driver specific image creation options for NFS.
>  #
> -# @location         Where to store the new image file
> -# @size             Size of the virtual disk in bytes
> +# @location: Where to store the new image file
> +# @size: Size of the virtual disk in bytes
>  #
>  # Since: 2.12
>  ##
> @@ -4338,9 +4338,9 @@
>  #
>  # Driver specific image creation options for parallels.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @cluster-size     Cluster size in bytes (default: 1 MB)
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @cluster-size: Cluster size in bytes (default: 1 MB)
>  #
>  # Since: 2.12
>  ##
> @@ -4354,11 +4354,11 @@
>  #
>  # Driver specific image creation options for qcow.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @backing-file     File name of the backing file if a backing file
> -#                   should be used
> -# @encrypt          Encryption options if the image should be encrypted
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @backing-file: File name of the backing file if a backing file
> +#                should be used
> +# @encrypt: Encryption options if the image should be encrypted
>  #
>  # Since: 2.12
>  ##
> @@ -4385,24 +4385,24 @@
>  #
>  # Driver specific image creation options for qcow2.
>  #
> -# @file             Node to create the image format on
> -# @data-file        Node to use as an external data file in which all gu=
est
> -#                   data is stored so that only metadata remains in the =
qcow2
> -#                   file (since: 4.0)
> -# @data-file-raw    True if the external data file must stay valid as a
> -#                   standalone (read-only) raw image without looking at =
qcow2
> -#                   metadata (default: false; since: 4.0)
> -# @size             Size of the virtual disk in bytes
> -# @version          Compatibility level (default: v3)
> -# @backing-file     File name of the backing file if a backing file
> -#                   should be used
> -# @backing-fmt      Name of the block driver to use for the backing file
> -# @encrypt          Encryption options if the image should be encrypted
> -# @cluster-size     qcow2 cluster size in bytes (default: 65536)
> -# @preallocation    Preallocation mode for the new image (default: off;
> -#                   allowed values: off, falloc, full, metadata)
> -# @lazy-refcounts   True if refcounts may be updated lazily (default: of=
f)
> -# @refcount-bits    Width of reference counts in bits (default: 16)
> +# @file: Node to create the image format on
> +# @data-file: Node to use as an external data file in which all guest
> +#             data is stored so that only metadata remains in the qcow2
> +#             file (since: 4.0)
> +# @data-file-raw: True if the external data file must stay valid as a
> +#                 standalone (read-only) raw image without looking at qc=
ow2
> +#                 metadata (default: false; since: 4.0)
> +# @size: Size of the virtual disk in bytes
> +# @version: Compatibility level (default: v3)
> +# @backing-file: File name of the backing file if a backing file
> +#                should be used
> +# @backing-fmt: Name of the block driver to use for the backing file
> +# @encrypt: Encryption options if the image should be encrypted
> +# @cluster-size: qcow2 cluster size in bytes (default: 65536)
> +# @preallocation: Preallocation mode for the new image (default: off;
> +#                 allowed values: off, falloc, full, metadata)
> +# @lazy-refcounts: True if refcounts may be updated lazily (default: off=
)
> +# @refcount-bits: Width of reference counts in bits (default: 16)
>  #
>  # Since: 2.12
>  ##
> @@ -4425,13 +4425,13 @@
>  #
>  # Driver specific image creation options for qed.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @backing-file     File name of the backing file if a backing file
> -#                   should be used
> -# @backing-fmt      Name of the block driver to use for the backing file
> -# @cluster-size     Cluster size in bytes (default: 65536)
> -# @table-size       L1/L2 table size (in clusters)
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @backing-file: File name of the backing file if a backing file
> +#                should be used
> +# @backing-fmt: Name of the block driver to use for the backing file
> +# @cluster-size: Cluster size in bytes (default: 65536)
> +# @table-size: L1/L2 table size (in clusters)
>  #
>  # Since: 2.12
>  ##
> @@ -4448,10 +4448,10 @@
>  #
>  # Driver specific image creation options for rbd/Ceph.
>  #
> -# @location         Where to store the new image file. This location can=
not
> -#                   point to a snapshot.
> -# @size             Size of the virtual disk in bytes
> -# @cluster-size     RBD object size
> +# @location: Where to store the new image file. This location cannot
> +#            point to a snapshot.
> +# @size: Size of the virtual disk in bytes
> +# @cluster-size: RBD object size
>  #
>  # Since: 2.12
>  ##
> @@ -4499,23 +4499,23 @@
>  #
>  # Driver specific image creation options for VMDK.
>  #
> -# @file         Where to store the new image file. This refers to the im=
age
> -#               file for monolithcSparse and streamOptimized format, or =
the
> -#               descriptor file for other formats.
> -# @size         Size of the virtual disk in bytes
> -# @extents      Where to store the data extents. Required for monolithcF=
lat,
> -#               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
> -#               monolithicFlat, only one entry is required; for
> -#               twoGbMaxExtent* formats, the number of entries required =
is
> -#               calculated as extent_number =3D virtual_size / 2GB. Prov=
iding
> -#               more extents than will be used is an error.
> -# @subformat    The subformat of the VMDK image. Default: "monolithicSpa=
rse".
> -# @backing-file The path of backing file. Default: no backing file is us=
ed.
> -# @adapter-type The adapter type used to fill in the descriptor. Default=
: ide.
> -# @hwversion    Hardware version. The meaningful options are "4" or "6".
> -#               Default: "4".
> -# @zeroed-grain Whether to enable zeroed-grain feature for sparse subfor=
mats.
> -#               Default: false.
> +# @file: Where to store the new image file. This refers to the image
> +#        file for monolithcSparse and streamOptimized format, or the
> +#        descriptor file for other formats.
> +# @size: Size of the virtual disk in bytes
> +# @extents: Where to store the data extents. Required for monolithcFlat,
> +#           twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
> +#           monolithicFlat, only one entry is required; for
> +#           twoGbMaxExtent* formats, the number of entries required is
> +#           calculated as extent_number =3D virtual_size / 2GB. Providin=
g
> +#           more extents than will be used is an error.
> +# @subformat: The subformat of the VMDK image. Default: "monolithicSpars=
e".
> +# @backing-file: The path of backing file. Default: no backing file is u=
sed.
> +# @adapter-type: The adapter type used to fill in the descriptor. Defaul=
t: ide.
> +# @hwversion: Hardware version. The meaningful options are "4" or "6".
> +#             Default: "4".
> +# @zeroed-grain: Whether to enable zeroed-grain feature for sparse subfo=
rmats.
> +#                Default: false.
>  #
>  # Since: 4.0
>  ##
> @@ -4533,9 +4533,9 @@
>  ##
>  # @SheepdogRedundancyType:
>  #
> -# @full             Create a fully replicated vdi with x copies
> -# @erasure-coded    Create an erasure coded vdi with x data strips and
> -#                   y parity strips
> +# @full: Create a fully replicated vdi with x copies
> +# @erasure-coded: Create an erasure coded vdi with x data strips and
> +#                 y parity strips
>  #
>  # Since: 2.12
>  ##
> @@ -4545,7 +4545,7 @@
>  ##
>  # @SheepdogRedundancyFull:
>  #
> -# @copies           Number of copies to use (between 1 and 31)
> +# @copies: Number of copies to use (between 1 and 31)
>  #
>  # Since: 2.12
>  ##
> @@ -4555,8 +4555,8 @@
>  ##
>  # @SheepdogRedundancyErasureCoded:
>  #
> -# @data-strips      Number of data strips to use (one of {2,4,8,16})
> -# @parity-strips    Number of parity strips to use (between 1 and 15)
> +# @data-strips: Number of data strips to use (one of {2,4,8,16})
> +# @parity-strips: Number of parity strips to use (between 1 and 15)
>  #
>  # Since: 2.12
>  ##
> @@ -4580,13 +4580,13 @@
>  #
>  # Driver specific image creation options for Sheepdog.
>  #
> -# @location         Where to store the new image file
> -# @size             Size of the virtual disk in bytes
> -# @backing-file     File name of a base image
> -# @preallocation    Preallocation mode for the new image (default: off;
> -#                   allowed values: off, full)
> -# @redundancy       Redundancy of the image
> -# @object-size      Object size of the image
> +# @location: Where to store the new image file
> +# @size: Size of the virtual disk in bytes
> +# @backing-file: File name of a base image
> +# @preallocation: Preallocation mode for the new image (default: off;
> +#                 allowed values: off, full)
> +# @redundancy: Redundancy of the image
> +# @object-size: Object size of the image
>  #
>  # Since: 2.12
>  ##
> @@ -4603,8 +4603,8 @@
>  #
>  # Driver specific image creation options for SSH.
>  #
> -# @location         Where to store the new image file
> -# @size             Size of the virtual disk in bytes
> +# @location: Where to store the new image file
> +# @size: Size of the virtual disk in bytes
>  #
>  # Since: 2.12
>  ##
> @@ -4617,10 +4617,10 @@
>  #
>  # Driver specific image creation options for VDI.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (default: off;
> -#                   allowed values: off, metadata)
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @preallocation: Preallocation mode for the new image (default: off;
> +#                 allowed values: off, metadata)
>  #
>  # Since: 2.12
>  ##
> @@ -4645,17 +4645,17 @@
>  #
>  # Driver specific image creation options for vhdx.
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @log-size         Log size in bytes, must be a multiple of 1 MB
> -#                   (default: 1 MB)
> -# @block-size       Block size in bytes, must be a multiple of 1 MB and =
not
> -#                   larger than 256 MB (default: automatically choose a =
block
> -#                   size depending on the image size)
> -# @subformat        vhdx subformat (default: dynamic)
> -# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-stan=
dard,
> -#                   but default.  Do not set to 'off' when using 'qemu-i=
mg
> -#                   convert' with subformat=3Ddynamic.
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @log-size: Log size in bytes, must be a multiple of 1 MB
> +#            (default: 1 MB)
> +# @block-size: Block size in bytes, must be a multiple of 1 MB and not
> +#              larger than 256 MB (default: automatically choose a block
> +#              size depending on the image size)
> +# @subformat: vhdx subformat (default: dynamic)
> +# @block-state-zero: Force use of payload blocks of type 'ZERO'. Non-sta=
ndard,
> +#                    but default.  Do not set to 'off' when using 'qemu-=
img
> +#                    convert' with subformat=3Ddynamic.
>  #
>  # Since: 2.12
>  ##
> @@ -4683,12 +4683,12 @@
>  #
>  # Driver specific image creation options for vpc (VHD).
>  #
> -# @file             Node to create the image format on
> -# @size             Size of the virtual disk in bytes
> -# @subformat        vhdx subformat (default: dynamic)
> -# @force-size       Force use of the exact byte size instead of rounding=
 to the
> -#                   next size that can be represented in CHS geometry
> -#                   (default: false)
> +# @file: Node to create the image format on
> +# @size: Size of the virtual disk in bytes
> +# @subformat: vhdx subformat (default: dynamic)
> +# @force-size: Force use of the exact byte size instead of rounding to t=
he
> +#              next size that can be represented in CHS geometry
> +#              (default: false)
>  #
>  # Since: 2.12
>  ##
> @@ -4703,7 +4703,7 @@
>  #
>  # Options for creating an image format on a given node.
>  #
> -# @driver           block driver to create the image format
> +# @driver: block driver to create the image format
>  #
>  # Since: 2.12
>  ##

Loses the visual alignment.  I'm okay with that, but the folks who took
the trouble to align the text may have different ideas.  Cc'ing Kevin
and Max.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


