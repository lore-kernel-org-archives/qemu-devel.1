Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC90C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71C02077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 11:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71C02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hniX8-0006nb-Qj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 07:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hniWy-0006OH-3l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hniWx-0005xR-14
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hniWw-0005x3-RV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 07:55:30 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A8CD8307D91E;
 Wed, 17 Jul 2019 11:55:29 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0503C19D7D;
 Wed, 17 Jul 2019 11:55:25 +0000 (UTC)
Date: Wed, 17 Jul 2019 13:55:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190717135523.7012b8df.cohuck@redhat.com>
In-Reply-To: <20190716145632.3b73b73d@x1.home>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-2-git-send-email-kwankhede@nvidia.com>
 <20190716145632.3b73b73d@x1.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 17 Jul 2019 11:55:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 01/13] vfio: KABI for migration interface
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 14:56:32 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 9 Jul 2019 15:19:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:

> > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> > index 24f505199f83..6696a4600545 100644
> > --- a/linux-headers/linux/vfio.h
> > +++ b/linux-headers/linux/vfio.h
> > @@ -372,6 +372,172 @@ struct vfio_region_gfx_edid {
> >   */
> >  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> >  
> > +/* Migration region type and sub-type */
> > +#define VFIO_REGION_TYPE_MIGRATION	        (2)  
> 
> Region type #2 is already claimed by VFIO_REGION_TYPE_CCW, so this would
> need to be #3 or greater (we should have a reference table somewhere in
> this header as it gets easier to miss claimed entries as the sprawl
> grows).

I agree, this is too easy to miss. I came up with "vfio: re-arrange
vfio region definitions" (<20190717114956.16263-1-cohuck@redhat.com>),
maybe that helps a bit.

