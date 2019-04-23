Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50013C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223B52148D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223B52148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ3Vu-00027C-4C
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:03:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Uy-0001q3-WE
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Uu-00024I-7I
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:43 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38844)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@fromorbit.com>) id 1hJ3Ul-0001tw-DM
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:02:33 -0400
Received: from dread.disaster.area (pa49-180-172-16.pa.nsw.optusnet.com.au
	[49.180.172.16])
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 613CD105EA0B;
	Wed, 24 Apr 2019 08:02:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
	(envelope-from <david@fromorbit.com>)
	id 1hJ3UX-0002gQ-2Q; Wed, 24 Apr 2019 08:02:17 +1000
Date: Wed, 24 Apr 2019 08:02:17 +1000
From: Dave Chinner <david@fromorbit.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190423220217.GA29573@dread.disaster.area>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-7-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423080612.15361-7-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=UJetJGXy c=1 sm=1 tr=0 cx=a_idp_d
	a=P9M234EABmfYNCwpuVjnFw==:117 a=P9M234EABmfYNCwpuVjnFw==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=oexKYjalfGEA:10
	a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=zOUUIwEDNWhzvqsACr4A:9
	a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.29.132.249
Subject: Re: [Qemu-devel] [PATCH v6 6/6] xfs: disable map_sync for async
 flush
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
	jasowang@redhat.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	adilger.kernel@dilger.ca, zwisler@kernel.org,
	aarcange@redhat.com, dave.jiang@intel.com,
	linux-nvdimm@lists.01.org, vishal.l.verma@intel.com,
	david@redhat.com, willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval.shaia@oracle.com, stefanha@redhat.com,
	pbonzini@redhat.com, dan.j.williams@intel.com,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong.eric@gmail.com,
	darrick.wong@oracle.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423220217.8z7P9J-QLArCwYe5oOEwRIsXnM1m9u1k9-DqE5Dqp9I@z>

On Tue, Apr 23, 2019 at 01:36:12PM +0530, Pankaj Gupta wrote:
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and xfs.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 1f2e2845eb76..0e59be018511 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1196,11 +1196,13 @@ xfs_file_mmap(
>  	struct file	*filp,
>  	struct vm_area_struct *vma)
>  {
> -	/*
> -	 * We don't support synchronous mappings for non-DAX files. At least
> -	 * until someone comes with a sensible use case.
> +	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
> +						(file_inode(filp));
> +
> +	/* We don't support synchronous mappings for non-DAX files and
> +	 * for DAX files if underneath dax_device is not synchronous.
>  	 */

	/*
	 * This is the correct multi-line comment format. Please
	 * update the patch to maintain the existing comment format.
	 */

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

