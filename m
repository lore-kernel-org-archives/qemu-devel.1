Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BE7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A2C21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DrI-0004v5-GF
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1Doy-0002X4-CJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1Dox-0000KS-5s
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:57:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1Dox-0000KF-0f
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 419C4305B89A
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 17:57:54 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D7E26366;
 Fri, 23 Aug 2019 17:57:45 +0000 (UTC)
Date: Fri, 23 Aug 2019 18:57:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: mst@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Message-ID: <20190823175743.GU2784@work-vm>
References: <20190823175657.12085-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823175657.12085-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 23 Aug 2019 17:57:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH v2 0/2] Add virtio-fs
 (experimental)
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
Cc: virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops, ment to cc mst on this:

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This pair of patches adds the core of the virtio-fs support to qemu;
> it's marked experimental since the kernel patch and spec changes aren't
> in yet; but they're bubbling along.
> 
>   While the spec change is still in progress; the ID number is already
> reserved.
> 
>   A future set of patches will add the optional DAX mapping support.
> 
>   The actual qemu change is pretty minimal, since it's really only
> a virtio device with some queues.
> 
> Some links:
>   Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
>   Dev tree: Including filesystem daemon: https://gitlab.com/virtio-fs/qemu
>   kernel: https://gitlab.com/virtio-fs/linux
>   virtio spec changes: https://lists.oasis-open.org/archives/virtio-dev/201908/msg00104.html
> 
> v2:
>   Renamed num_queues to num_request_queues
>   Add a not-reached assert to vuf_handle_output
>   Kill the one bit of notification queue off
>   Use the same trick as vhost-user-scsi to calculate the number
>     of vectors for the PCI device
> 
> Dr. David Alan Gilbert (2):
>   virtio: add vhost-user-fs base device
>   virtio: add vhost-user-fs-pci device
> 
>  configure                                   |  13 +
>  hw/virtio/Makefile.objs                     |   2 +
>  hw/virtio/vhost-user-fs-pci.c               |  85 ++++++
>  hw/virtio/vhost-user-fs.c                   | 297 ++++++++++++++++++++
>  include/hw/virtio/vhost-user-fs.h           |  45 +++
>  include/standard-headers/linux/virtio_fs.h  |  41 +++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  7 files changed, 484 insertions(+)
>  create mode 100644 hw/virtio/vhost-user-fs-pci.c
>  create mode 100644 hw/virtio/vhost-user-fs.c
>  create mode 100644 include/hw/virtio/vhost-user-fs.h
>  create mode 100644 include/standard-headers/linux/virtio_fs.h
> 
> -- 
> 2.21.0
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

