Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657792168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657792168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4ic-0002j3-Kr
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU4hL-00023Y-B7
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU4hK-0005id-6O
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:33:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hU4hJ-0005dU-VW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:33:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so8878701wrx.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4EsjwW+GFdUt98v5h2+ZDU4JACMLxmVUBKA0zXPSEOk=;
	b=njunJuZzcqpPcyzYrgE3V6v2N49XuqIMgdXxHw090Mee9DCWRhT98y/ND5+wlNSBWj
	EqPjwf7ibDR14fdHMWpJ8BBA8zoNV+ExSi+ckjVT5JErzwig05sohyM/YJ/zqtVljNwC
	6o40x6Reee/WOzmO5HyXEedpFQCwMq6STxf2nxbt4amgypwL0u0kux60Jj13iCkxJreR
	JvI8NRcLbuvCk9Z1U4oqO6HHh3LAf8cmqJzbHmW62fyL71KWJW/+Tw28CvAXxdlqMQ1Y
	182VuCtpzFMaoQgkOZ3b+Hn1GbNLwMP/WwS7xOvYpMJXOTTI3CDZ2f/Gyf2cDXKqBiB8
	UD1A==
X-Gm-Message-State: APjAAAWZKmtBfrUV7R9w4Scso2JwtD4J3GL+LmJUp5oh/7UXGUfxM8d+
	RFImvoKoUOzu/qAIFs4J0yIKCw==
X-Google-Smtp-Source: APXvYqwdUqBlC7caZ1luD/bPnBn51bbdKSw/K7Jnc6USJmoIZxNBzR82cNIvYwOMBv05/0b4hSDppA==
X-Received: by 2002:adf:cc8b:: with SMTP id p11mr47797280wrj.13.1558683180979; 
	Fri, 24 May 2019 00:33:00 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	i15sm1411936wre.30.2019.05.24.00.32.59
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 00:33:00 -0700 (PDT)
Date: Fri, 24 May 2019 09:32:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190524073257.jdylw3dohrpahsrh@steredhat>
References: <20190523152250.106717-1-sgarzare@redhat.com>
	<20190523152250.106717-2-sgarzare@redhat.com>
	<8736l5i119.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736l5i119.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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

On Thu, May 23, 2019 at 06:33:06PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > Add default and available values in the documentation block of
> > each block device or protocol that supports the 'preallocation'
> > parameter during the image creation.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  qapi/block-core.json | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ccbfff9d0..6aab0ebfe3 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4103,7 +4103,10 @@
> >  #
> >  # @filename         Filename for the new image file
> >  # @size             Size of the virtual disk in bytes
> > -# @preallocation    Preallocation mode for the new image (default: off)
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values for file-posix: off,
> > +#                   falloc (if defined CONFIG_POSIX_FALLOCATE), full;
> > +#                   allowed values for file-win32: off)
> 
> "file-win32" isn't a QAPI thing, it's the stem of the source file where
> the driver consuming this is defined.  Not ideal
> 
> Perhaps: off, falloc (if defined CONFIG_POSIX_FALLOCATE), full (if
> defined CONFIG_POSIX).
> 

Yes, it's better :) I'll fix it in the v2.

> >  # @nocow            Turn off copy-on-write (valid only on btrfs; default: off)
> >  #
> >  # Since: 2.12
> > @@ -4121,7 +4124,10 @@
> >  #
> >  # @location         Where to store the new image file
> >  # @size             Size of the virtual disk in bytes
> > -# @preallocation    Preallocation mode for the new image (default: off)
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off,
> > +#                   falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
> > +#                   full (if defined CONFIG_GLUSTERFS_ZEROFILL))
> >  #
> >  # Since: 2.12
> >  ##
> > @@ -4225,7 +4231,8 @@
> >  # @backing-fmt      Name of the block driver to use for the backing file
> >  # @encrypt          Encryption options if the image should be encrypted
> >  # @cluster-size     qcow2 cluster size in bytes (default: 65536)
> > -# @preallocation    Preallocation mode for the new image (default: off)
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off, falloc, full, metadata)
> >  # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
> >  # @refcount-bits    Width of reference counts in bits (default: 16)
> >  #
> > @@ -4408,7 +4415,8 @@
> >  # @location         Where to store the new image file
> >  # @size             Size of the virtual disk in bytes
> >  # @backing-file     File name of a base image
> > -# @preallocation    Preallocation mode (allowed values: off, full)
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off, full)
> >  # @redundancy       Redundancy of the image
> >  # @object-size      Object size of the image
> >  #
> > @@ -4443,8 +4451,8 @@
> >  #
> >  # @file             Node to create the image format on
> >  # @size             Size of the virtual disk in bytes
> > -# @preallocation    Preallocation mode for the new image (allowed values: off,
> > -#                   metadata; default: off)
> > +# @preallocation    Preallocation mode for the new image (default: off;
> > +#                   allowed values: off, metadata)
> >  #
> >  # Since: 2.12
> >  ##
> 
> Preferably with file-win32 rephrased:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks,
Stefano

