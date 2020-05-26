Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D065FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB19207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgDiceer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB19207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdg3t-0000iF-Q3
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jdg3F-0000CT-RK
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:19:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jdg3E-00041D-87
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590524390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTtt9LMjfJw2IHxrEcqSdlDibKWSqdvA8/c3DDMFwRk=;
 b=VgDiceeruo219s9Lj+3SYZeISB4u67BMVSl/MbyatrxdA1Mjty1ylFcTUEz0bUI8zN0hzx
 Z9A9eqIw+Oket89KYyGPKJ0J0/kdUzgbX71jBjMZlItt0JEmwbqqUrHQgE/Qcqa8fMxV5/
 x00JskZn/4KLSBo1zPLjjR1yOfSOSP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-OMk8aasiMCmllyd0oIcpSA-1; Tue, 26 May 2020 16:19:45 -0400
X-MC-Unique: OMk8aasiMCmllyd0oIcpSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F58A107ACCA;
 Tue, 26 May 2020 20:19:43 +0000 (UTC)
Received: from x1.home (ovpn-114-203.phx2.redhat.com [10.3.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B52479C4F;
 Tue, 26 May 2020 20:19:41 +0000 (UTC)
Date: Tue, 26 May 2020 14:19:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200526141939.2632f100@x1.home>
In-Reply-To: <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
 <20200525065925.GA698@joy-OptiPlex-7040>
 <426a5314-6d67-7cbe-bad0-e32f11d304ea@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 25 May 2020 18:50:54 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/25/2020 12:29 PM, Yan Zhao wrote:
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
> > hi Alex
> > after porting gvt/i40e vf migration code to kernel/qemu v23, we spoted
> > two bugs.
> > 1. "Failed to get dirty bitmap for iova: 0xfe011000 size: 0x3fb0 err: 22"
> >     This is a qemu bug that the dirty bitmap query range is not the same
> >     as the dma map range. It can be fixed in qemu. and I just have a little
> >     concern for kernel to have this restriction.
> >   
> 
> I never saw this unaligned size in my testing. In this case if you can 
> provide vfio_* event traces, that will helpful.

Yeah, I'm curious why we're hitting such a call path, I think we were
designing this under the assumption we wouldn't see these.  I also
wonder if we really need to enforce the dma mapping range for getting
the dirty bitmap with the current implementation (unmap+dirty obviously
still has the restriction).  We do shift the bitmap in place for
alignment, but I'm not sure why we couldn't shift it back and only
clear the range that was reported.  Kirti, do you see other issues?  I
think a patch to lift that restriction is something we could plan to
include after the initial series is included and before we've committed
to the uapi at the v5.8 release.
 
> > 2. migration abortion, reporting
> > "qemu-system-x86_64-lm: vfio_load_state: Error allocating buffer
> > qemu-system-x86_64-lm: error while loading state section id 49(vfio)
> > qemu-system-x86_64-lm: load of migration failed: Cannot allocate memory"
> > 
> > It's still a qemu bug and we can fixed it by
> > "
> > if (migration->pending_bytes == 0) {
> > +            qemu_put_be64(f, 0);
> > +            qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > "  
> 
> In which function in QEMU do you have to add this?

I think this is relative to QEMU path 09/ where Yan had the questions
below on v16 and again tried to get answers to them on v22:

https://lore.kernel.org/qemu-devel/20200520031323.GB10369@joy-OptiPlex-7040/

Kirti, please address these questions.

> > and actually there are some extra concerns about this part, as reported in
> > [1][2].
> > 
> > [1] data_size should be read ahead of data_offset
> > https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02795.html.
> > [2] should not repeatedly update pending_bytes in vfio_save_iterate()
> > https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02796.html.
> > 
> > but as those errors are all in qemu, and we have finished basic tests in
> > both gvt & i40e, we're fine with the kernel part interface in general now.
> > (except for my concern [1], which needs to update kernel patch 1)
> >   
> 
>  >> what if pending_bytes is not 0, but vendor driver just does not want  to
>  >> send data in this iteration? isn't it right to get data_size first   
> before
>  >> getting data_offset?  
> 
> If vendor driver doesn't want to send data but still has data in staging 
> buffer, vendor driver still can control to send pending_bytes for this 
> iteration as 0 as this is a trap field.
> 
> I would defer this to Alex.

This is my understanding of the protocol as well, when the device is
running, pending_bytes might drop to zero if no internal state has
changed and may be non-zero on the next iteration due to device
activity.  When the device is not running, pending_bytes reporting zero
indicates the device is done, there is no further state to transmit.
Does that meet your need/expectation?

> > so I wonder which way in your mind is better, to give our reviewed-by to
> > the kernel part now, or hold until next qemu fixes?
> > and as performance data from gvt is requested from your previous mail, is
> > that still required before the code is accepted?

The QEMU series does not need to be perfect, I kind of expect we might
see a few iterations of that beyond the kernel portion being accepted.
We should have the QEMU series to the point that we've resolved any
uapi issues though, which it seems like we're pretty close to having.
Ideally I'd like to get the kernel series into my next branch before
the merge window opens, where it seems like upstream is on schedule to
have that happen this Sunday.  If you feel we're to the point were we
can iron a couple details out during the v5.8 development cycle, then
please provide your reviewed-by.  We haven't fully committed to a uapi
until we've committed to it for a non-rc release.

I think the performance request was largely due to some conversations
with Dave Gilbert wondering if all this actually works AND is practical
for a LIVE migration.  I think we're all curious about things like how
much data does a GPU have to transfer in each phase of migration, and
particularly if the final phase is going to be a barrier to claiming
the VM is actually sufficiently live.  I'm not sure we have many
options if a device simply has a very large working set, but even
anecdotal evidence that the stop-and-copy phase transfers abMB from the
device while idle or xyzMB while active would give us some idea what to
expect.  Kirti, have you done any of those sorts of tests for NVIDIA's
driver?

> > BTW, we have also conducted some basic tests when viommu is on, and found out
> > errors like
> > "qemu-system-x86_64-dt: vtd_iova_to_slpte: detected slpte permission error (iova=0x0, level=0x3, slpte=0x0, write=1)
> > qemu-system-x86_64-dt: vtd_iommu_translate: detected translation failure (dev=00:03:00, iova=0x0)
> > qemu-system-x86_64-dt: New fault is not recorded due to compression of faults".
> >   
> 
> I saw these errors, I'm looking into it.

Let's try to at least determine if this is a uapi issue or just a QEMU
implementation bug for progressing the kernel series.  Thanks,

Alex


