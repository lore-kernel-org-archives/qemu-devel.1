Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A2BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493882077C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 08:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493882077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49714 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIqMT-0007I5-FB
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 04:01:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIqKv-0006SZ-Ec
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIqKu-0000fR-9x
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hIqKu-0000ee-43
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C19B358E25;
	Tue, 23 Apr 2019 07:59:26 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60BA71001E69;
	Tue, 23 Apr 2019 07:59:23 +0000 (UTC)
Date: Tue, 23 Apr 2019 09:59:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190423095921.3af966b8.cohuck@redhat.com>
In-Reply-To: <20190419191910-mutt-send-email-mst@kernel.org>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-3-yuval.shaia@oracle.com>
	<20190419191910-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 23 Apr 2019 07:59:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] hw/virtio-rdma: VirtIO rdma device
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
Cc: linux-rdma@vger.kernel.org, qemu-devel@nongnu.org,
	Yuval Shaia <yuval.shaia@oracle.com>,
	virtualization@lists.linux-foundation.org, jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423075921.eyC2Oom6lR7sZz3JlMskrZ0ScjiFndL2bDxwUAvTGCA@z>

On Fri, 19 Apr 2019 19:20:22 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Apr 11, 2019 at 02:01:56PM +0300, Yuval Shaia wrote:
> > diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> > index 6d5c3b2d4f..bd2c699450 100644
> > --- a/include/standard-headers/linux/virtio_ids.h
> > +++ b/include/standard-headers/linux/virtio_ids.h
> > @@ -43,5 +43,6 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_RDMA         26 /* virtio crypto */

I think 26 is already de facto used by virtio-audio(?) and 27 has just
been reserved for virtio-pmem. The next free id seems to be 28.

(Also, the comment is a straight copy-paste :)

> >  
> >  #endif /* _LINUX_VIRTIO_IDS_H */  
> 
> 
> Please reserve an ID with the virtio TC.
> Process:
> - create a github issue
> - post patch with Fixes: tag
> - wait a bit
> - if no comments on either ask for a vote

Agreed, let's reserve an id. There seems to be enough interest in this
device type.

