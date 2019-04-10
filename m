Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5B4206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5B4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE8YX-0007Bn-B3
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 04:26:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hE8Xe-0006QW-1c
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hE8Xd-0007wk-0d
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:25:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36538 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack@suse.cz>) id 1hE8Xc-0007vL-Ma
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 30A60ABD4;
	Wed, 10 Apr 2019 08:25:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 1D74A1E429B; Wed, 10 Apr 2019 10:25:04 +0200 (CEST)
Date: Wed, 10 Apr 2019 10:25:04 +0200
From: Jan Kara <jack@suse.cz>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190410082504.GF1426@quack2.suse.cz>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-5-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190410040826.24371-5-pagupta@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [PATCH v5 4/6] dax: check synchronous mapping is
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
Message-ID: <20190410082504.cuDATQAnBK7k8czRC0C3nRYBua5yhKoORlzpcYcaLAQ@z>

On Wed 10-04-19 09:38:24, Pankaj Gupta wrote:
> This patch introduces 'daxdev_mapping_supported' helper
> which checks if 'MAP_SYNC' is supported with filesystem
> mapping. It also checks if corresponding dax_device is
> synchronous. Virtio pmem device is asynchronous and
> does not not support VM_SYNC. 
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  include/linux/dax.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b896706a5ee9..4a2a60ffec86 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -38,6 +38,24 @@ void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
>  bool dax_write_cache_enabled(struct dax_device *dax_dev);
>  bool dax_synchronous(struct dax_device *dax_dev);
> +
> +/*
> + * Callers check if synchronous mapping is enabled for DAX file
> + * and attached dax device is also synchronous.
> + *
> + * dax_synchronous function verifies if dax device is synchronous.
> + * Currently, only virtio pmem device supports asynchronous device
> + * flush.
> + */

Thanks for the patch! I'd restructure this comment like:

/*
 * Check if given mapping is supported by the file / underlying device.
 */
> +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> +				struct dax_device *dax_dev)
> +{

	/* Everyone supports non-sync mappings */
> +	if (!(vma->vm_flags & VM_SYNC))
> +		return true;
	/* Sync mappings are supported only for files using DAX */
> +	if (!IS_DAX(file_inode(vma->vm_file)))
> +		return false;
	/* Underlying device must support persisting through CPU instructions */
> +	return dax_synchronous(dax_dev);
> +}
>  #else
>  static inline struct dax_device *dax_get_by_host(const char *host)
>  {
> @@ -69,6 +87,11 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
>  {
>  	return true;
>  }
> +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> +				struct dax_device *dax_dev)
> +{
> +	return true;

This looks wrong. Shouldn't it rather be:

	return !(vma->flags & VM_SYNC);

?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

