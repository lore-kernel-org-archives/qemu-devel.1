Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B28C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4853821738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4853821738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54641 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwRA-0001yh-Kz
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:30:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hIwOR-0000Nx-5e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hIwOQ-0008FR-44
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:55142 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack@suse.cz>) id 1hIwOP-0008Du-Tv
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 8B5DAACB8;
	Tue, 23 Apr 2019 14:27:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 9F7B41E15B7; Tue, 23 Apr 2019 16:27:23 +0200 (CEST)
Date: Tue, 23 Apr 2019 16:27:23 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190423142723.GD9910@quack2.suse.cz>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-5-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423080612.15361-5-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [PATCH v6 4/6] dax: check synchronous mapping is
 supported
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
	jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
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
Message-ID: <20190423142723.PRwudwk9ucCvRjwPNEH8xjNv457Rf2zsa7fBpnl7SJo@z>

On Tue 23-04-19 13:36:10, Pankaj Gupta wrote:
> This patch introduces 'daxdev_mapping_supported' helper
> which checks if 'MAP_SYNC' is supported with filesystem
> mapping. It also checks if corresponding dax_device is
> synchronous. Virtio pmem device is asynchronous and
> does not not support VM_SYNC. 
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  include/linux/dax.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index c97fc0cc7167..41b4a5db6305 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -41,6 +41,18 @@ void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
>  bool dax_synchronous(struct dax_device *dax_dev);
> +/*
> + * Check if given mapping is supported by the file / underlying device.
> + */
> +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> +				struct dax_device *dax_dev)
> +{
> +	if (!(vma->vm_flags & VM_SYNC))
> +		return true;
> +	if (!IS_DAX(file_inode(vma->vm_file)))
> +		return false;
> +	return dax_synchronous(dax_dev);
> +}
>  #else
>  static inline struct dax_device *dax_get_by_host(const char *host)
>  {
> @@ -68,6 +80,11 @@ static inline bool dax_write_cache_enabled(struct dax_device *dax_dev)
>  {
>  	return false;
>  }
> +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> +				struct dax_device *dax_dev)
> +{
> +	return !(vma->flags & VM_SYNC);
> +}
>  #endif
>  
>  struct writeback_control;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

