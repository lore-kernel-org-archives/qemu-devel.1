Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CEE2065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VovyrsBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CEE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRsR-0004bA-LR
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jbRrj-0003lS-58
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:46:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jbRri-0004eZ-69
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589993204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7vjx9ftJhMQ0P4vMekqxWsrl2y5tpT+NNgg8eoV8o3U=;
 b=VovyrsBq8JfQoXGS+LnrVkcIU6uCx6ryH+7UiKW/4kp7c9YdclloNBBk7OatJqVumENeEd
 f3hdP7iQnovl0asNkIIrPXX2RaCgYlZgwxly7NcRv8cf/lH8OvT/5vR/OVi0GxJniWOkzu
 5ykSjTNHDkJUMeTQXWdey/Ey3ZUw+74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-SrR44d4uOamW-7TG2ZJlow-1; Wed, 20 May 2020 12:46:38 -0400
X-MC-Unique: SrR44d4uOamW-7TG2ZJlow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34D481CBE3;
 Wed, 20 May 2020 16:46:35 +0000 (UTC)
Received: from w520.home (ovpn-112-50.phx2.redhat.com [10.3.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D99BB79C2B;
 Wed, 20 May 2020 16:46:12 +0000 (UTC)
Date: Wed, 20 May 2020 10:46:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200520104612.03a32977@w520.home>
In-Reply-To: <97977ede-3c5b-c5a5-7858-7eecd7dd531c@nvidia.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200520025500.GA10369@joy-OptiPlex-7040>
 <97977ede-3c5b-c5a5-7858-7eecd7dd531c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, Yan Zhao <yan.y.zhao@intel.com>,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 19:10:07 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/20/2020 8:25 AM, Yan Zhao wrote:
> > On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:  
> >> Hi folks,
> >>
> >> My impression is that we're getting pretty close to a workable
> >> implementation here with v22 plus respins of patches 5, 6, and 8.  We
> >> also have a matching QEMU series and a proposal for a new i40e
> >> consumer, as well as I assume GVT-g updates happening internally at
> >> Intel.  I expect all of the latter needs further review and discussion,
> >> but we should be at the point where we can validate these proposed
> >> kernel interfaces.  Therefore I'd like to make a call for reviews so
> >> that we can get this wrapped up for the v5.8 merge window.  I know
> >> Connie has some outstanding documentation comments and I'd like to make
> >> sure everyone has an opportunity to check that their comments have been
> >> addressed and we don't discover any new blocking issues.  Please send
> >> your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
> >> interface and implementation.  Thanks!
> >>  
> > hi Alex and Kirti,
> > after porting to qemu v22 and kernel v22, it is found out that
> > it can not even pass basic live migration test with error like
> > 
> > "Failed to get dirty bitmap for iova: 0xca000 size: 0x3000 err: 22"
> >   
> 
> Thanks for testing Yan.
> I think last moment change in below cause this failure
> 
> https://lore.kernel.org/kvm/1589871178-8282-1-git-send-email-kwankhede@nvidia.com/
> 
>  > 	if (dma->iova > iova + size)
>  > 		break;  
> 
> Surprisingly with my basic testing with 2G sys mem QEMU didn't raise 
> abort on g_free, but I do hit this with large sys mem.
> With above change, that function iterated through next vfio_dma as well. 
> Check should be as below:
> 
> -               if (dma->iova > iova + size)
> +               if (dma->iova > iova + size -1)


Or just:

	if (dma->iova >= iova + size)

Thanks,
Alex


>                          break;
> 
> Another fix is in QEMU.
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg04751.html
> 
>  > > +        range->bitmap.size = ROUND_UP(pages, 64) / 8;  
>  >
>  > ROUND_UP(npages/8, sizeof(u64))?
>  >  
> 
> If npages < 8, npages/8 is 0 and ROUND_UP(0, 8) returns 0.
> 
> Changing it as below
> 
> -        range->bitmap.size = ROUND_UP(pages / 8, sizeof(uint64_t));
> +        range->bitmap.size = ROUND_UP(pages, sizeof(__u64) * 
> BITS_PER_BYTE) /
> +                             BITS_PER_BYTE;
> 
> I'm updating patches with these fixes and Cornelia's suggestion soon.
> 
> Due to short of time I may not be able to address all the concerns 
> raised on previous versions of QEMU, I'm trying make QEMU side code 
> available for testing for others with latest kernel changes. Don't 
> worry, I will revisit comments on QEMU patches. Right now first priority 
> is to test kernel UAPI and prepare kernel patches for 5.8
> 
> Thanks,
> Kirti
> 


