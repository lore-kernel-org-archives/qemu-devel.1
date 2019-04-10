Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45ABC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A902075B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A902075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE8ek-0000jh-Rm
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 04:32:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hE8df-0000Hg-TJ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hE8de-00031v-RG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hE8dd-00030h-Pj
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:31:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 424F27F6B0;
	Wed, 10 Apr 2019 08:31:20 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09AAF108BEF7;
	Wed, 10 Apr 2019 08:31:20 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9C8ED1803385;
	Wed, 10 Apr 2019 08:31:19 +0000 (UTC)
Date: Wed, 10 Apr 2019 04:31:19 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <299038321.20701113.1554885079188.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190410082504.GF1426@quack2.suse.cz>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-5-pagupta@redhat.com>
	<20190410082504.GF1426@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.19, 10.4.195.8]
Thread-Topic: check synchronous mapping is supported
Thread-Index: 3OuZRphtFQExf6N3zq0ZSCMeImf/pQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 10 Apr 2019 08:31:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: cohuck@redhat.com, kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	david@fromorbit.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
	aarcange@redhat.com, dave jiang <dave.jiang@intel.com>,
	linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, pbonzini@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410083119.P-0FY-r8LTAliWHf_3qubYduEiuEXP_9kXddoAjWGcU@z>


> > This patch introduces 'daxdev_mapping_supported' helper
> > which checks if 'MAP_SYNC' is supported with filesystem
> > mapping. It also checks if corresponding dax_device is
> > synchronous. Virtio pmem device is asynchronous and
> > does not not support VM_SYNC.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  include/linux/dax.h | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > index b896706a5ee9..4a2a60ffec86 100644
> > --- a/include/linux/dax.h
> > +++ b/include/linux/dax.h
> > @@ -38,6 +38,24 @@ void kill_dax(struct dax_device *dax_dev);
> >  void dax_write_cache(struct dax_device *dax_dev, bool wc);
> >  bool dax_write_cache_enabled(struct dax_device *dax_dev);
> >  bool dax_synchronous(struct dax_device *dax_dev);
> > +
> > +/*
> > + * Callers check if synchronous mapping is enabled for DAX file
> > + * and attached dax device is also synchronous.
> > + *
> > + * dax_synchronous function verifies if dax device is synchronous.
> > + * Currently, only virtio pmem device supports asynchronous device
> > + * flush.
> > + */
> 
> Thanks for the patch! I'd restructure this comment like:
> 
> /*
>  * Check if given mapping is supported by the file / underlying device.
>  */

Sure.

> > +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> > +				struct dax_device *dax_dev)
> > +{
> 
> 	/* Everyone supports non-sync mappings */
> > +	if (!(vma->vm_flags & VM_SYNC))
> > +		return true;
> 	/* Sync mappings are supported only for files using DAX */
> > +	if (!IS_DAX(file_inode(vma->vm_file)))
> > +		return false;
> 	/* Underlying device must support persisting through CPU instructions */
> > +	return dax_synchronous(dax_dev);
> > +}
> >  #else
> >  static inline struct dax_device *dax_get_by_host(const char *host)
> >  {
> > @@ -69,6 +87,11 @@ static inline bool dax_synchronous(struct dax_device
> > *dax_dev)
> >  {
> >  	return true;
> >  }
> > +static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
> > +				struct dax_device *dax_dev)
> > +{
> > +	return true;
> 
> This looks wrong. Shouldn't it rather be:
> 
> 	return !(vma->flags & VM_SYNC);
> 
> ?

Right. I will correct this.

Thanks,
Pankaj

> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

