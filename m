Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1703AC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02CA20873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02CA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56484 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdD1s-0002it-V0
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56882)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hdD0a-0002H2-OL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hdD0Z-0006wT-J5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hdD0Z-0006db-DC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF2C620264;
 Tue, 18 Jun 2019 12:14:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFD81001DCB;
 Tue, 18 Jun 2019 12:14:11 +0000 (UTC)
Date: Tue, 18 Jun 2019 13:14:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190618121408.GM28525@redhat.com>
References: <20190618112341.513-1-anthony.perard@citrix.com>
 <20190618112341.513-2-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190618112341.513-2-anthony.perard@citrix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 18 Jun 2019 12:14:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/4] xen: Fix build with public headers
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: xen-devel@lists.xenproject.org, Paul Durrant <paul.durrant@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 12:23:38PM +0100, Anthony PERARD wrote:
> Following 37677d7db3 "Clean up a few header guard symbols", QEMU start
> to fail to build:
> 
> In file included from ~/xen/tools/../tools/include/xen/io/blkif.h:31:0,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:5,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> ~/xen/tools/../tools/include/xen/io/ring.h:68:0: error: "__CONST_RING_SIZE" redefined [-Werror]
>  #define __CONST_RING_SIZE(_s, _sz) \
> 
> In file included from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:4:0,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> ~/xen/tools/qemu-xen-dir/include/hw/xen/io/ring.h:66:0: note: this is the location of the previous definition
>  #define __CONST_RING_SIZE(_s, _sz) \
> 
> The issue is that some public xen headers have been imported (by
> f65eadb639 "xen: import ring.h from xen") but not all. With the change
> in the guards symbole, the ring.h header start to be imported twice.

Ah, so the include/hw/xen/io/ring.h file in tree is a copy of
/usr/include/xen/io/ring.h from xen-devel.  Previously both
these used "#ifndef __XEN_PUBLIC_IO_RING_H__". After
the header guard cleanup in 37677d7db3, our local copy used a
different header guard from the installed copy & thus we're
not protected from dual inclusion.

IMHO the right solutions here are either

 - Don't copy public Xen headers into our tree
 - Keep our Xen header copies identical to the originals

Importing public headers and then changing them locally is the worst
thing to do. With that in mind I think we should revert the part of
commit 37677d7db3 that touched the imported Xen headers.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

