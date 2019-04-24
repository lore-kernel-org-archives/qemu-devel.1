Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04807C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDF6218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDF6218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAOn-0004RV-Qm
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:24:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hJANR-0003kg-93
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hJALq-000613-Vr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hJALq-0005yT-Ne
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE0839D51C;
	Wed, 24 Apr 2019 05:21:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D21345D719;
	Wed, 24 Apr 2019 05:21:44 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7A2163FB10;
	Wed, 24 Apr 2019 05:21:44 +0000 (UTC)
Date: Wed, 24 Apr 2019 01:21:44 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Jan Kara <jack@suse.cz>
Message-ID: <1325148804.23168491.1556083304080.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190423142748.GE9910@quack2.suse.cz>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-6-pagupta@redhat.com>
	<20190423142748.GE9910@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.97, 10.4.195.9]
Thread-Topic: ext4: disable map_sync for async flush
Thread-Index: I6R5hXfMlzDnCoWVf4J0x3p7zay/cA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 24 Apr 2019 05:21:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 5/6] ext4: disable map_sync for async
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
Cc: kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
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
	stefanha@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	cohuck@redhat.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
	darrick wong <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424052144.5BEn6KK8lH_wFJPO_3EcEjREvD9ONYaRztoKGbsnAvU@z>


> 
> On Tue 23-04-19 13:36:11, Pankaj Gupta wrote:
> > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > with asynchronous dax_device. Virtio pmem provides
> > asynchronous host page cache flush mechanism. We don't
> > support 'MAP_SYNC' with virtio pmem and ext4.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you. Will add this.

Best regards,
Pankaj

> 
> 								Honza
> 
> 
> > ---
> >  fs/ext4/file.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 69d65d49837b..4b2ccaf1932e 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -360,15 +360,16 @@ static const struct vm_operations_struct
> > ext4_file_vm_ops = {
> >  static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> >  	struct inode *inode = file->f_mapping->host;
> > +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > +	struct dax_device *dax_dev = sbi->s_daxdev;
> >  
> > -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> > +	if (unlikely(ext4_forced_shutdown(sbi)))
> >  		return -EIO;
> >  
> > -	/*
> > -	 * We don't support synchronous mappings for non-DAX files. At least
> > -	 * until someone comes with a sensible use case.
> > +	/* We don't support synchronous mappings for non-DAX files and
> > +	 * for DAX files if underneath dax_device is not synchronous.
> >  	 */
> > -	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
> > +	if (!daxdev_mapping_supported(vma, dax_dev))
> >  		return -EOPNOTSUPP;
> >  
> >  	file_accessed(file);
> > --
> > 2.20.1
> > 
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
> 

