Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA400C282E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C206E2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C206E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqik-0005le-2A
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:37:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqet-0002p5-50
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqes-00008H-1T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:33:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hTqep-0008Jm-8U; Thu, 23 May 2019 12:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3217589C42;
	Thu, 23 May 2019 16:33:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CDDEC1001E6F;
	Thu, 23 May 2019 16:33:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 524351138648; Thu, 23 May 2019 18:33:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190523152250.106717-1-sgarzare@redhat.com>
	<20190523152250.106717-2-sgarzare@redhat.com>
Date: Thu, 23 May 2019 18:33:06 +0200
In-Reply-To: <20190523152250.106717-2-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Thu, 23 May 2019 17:22:48 +0200")
Message-ID: <8736l5i119.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 16:33:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi/block-core: update documentation
 of preallocation parameter
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> Add default and available values in the documentation block of
> each block device or protocol that supports the 'preallocation'
> parameter during the image creation.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  qapi/block-core.json | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..6aab0ebfe3 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4103,7 +4103,10 @@
>  #
>  # @filename         Filename for the new image file
>  # @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (default: off)
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values for file-posix: off,
> +#                   falloc (if defined CONFIG_POSIX_FALLOCATE), full;
> +#                   allowed values for file-win32: off)

"file-win32" isn't a QAPI thing, it's the stem of the source file where
the driver consuming this is defined.  Not ideal

Perhaps: off, falloc (if defined CONFIG_POSIX_FALLOCATE), full (if
defined CONFIG_POSIX).

>  # @nocow            Turn off copy-on-write (valid only on btrfs; default: off)
>  #
>  # Since: 2.12
> @@ -4121,7 +4124,10 @@
>  #
>  # @location         Where to store the new image file
>  # @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (default: off)
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values: off,
> +#                   falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
> +#                   full (if defined CONFIG_GLUSTERFS_ZEROFILL))
>  #
>  # Since: 2.12
>  ##
> @@ -4225,7 +4231,8 @@
>  # @backing-fmt      Name of the block driver to use for the backing file
>  # @encrypt          Encryption options if the image should be encrypted
>  # @cluster-size     qcow2 cluster size in bytes (default: 65536)
> -# @preallocation    Preallocation mode for the new image (default: off)
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values: off, falloc, full, metadata)
>  # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
>  # @refcount-bits    Width of reference counts in bits (default: 16)
>  #
> @@ -4408,7 +4415,8 @@
>  # @location         Where to store the new image file
>  # @size             Size of the virtual disk in bytes
>  # @backing-file     File name of a base image
> -# @preallocation    Preallocation mode (allowed values: off, full)
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values: off, full)
>  # @redundancy       Redundancy of the image
>  # @object-size      Object size of the image
>  #
> @@ -4443,8 +4451,8 @@
>  #
>  # @file             Node to create the image format on
>  # @size             Size of the virtual disk in bytes
> -# @preallocation    Preallocation mode for the new image (allowed values: off,
> -#                   metadata; default: off)
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values: off, metadata)
>  #
>  # Since: 2.12
>  ##

Preferably with file-win32 rephrased:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

