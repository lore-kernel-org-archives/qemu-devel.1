Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C65F2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="e3pGrQxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C65F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sWY-00056Q-W9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sVr-0004BP-Gp; Wed, 29 Jul 2020 16:17:19 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sVo-0002Cs-N1; Wed, 29 Jul 2020 16:17:19 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 09EB3BF616;
 Wed, 29 Jul 2020 20:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596053832;
 bh=TLGpsGoro2jWDSQLksTfadQMtd2cZaWGgQV5iq+6NAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e3pGrQxxkUWspjkEvkdWgxNd3/bQtb5bLYsAu5qtBnN8yWlebgT8w2eYv5rj76We9
 lhKCcQusjG9d71fh5NiDQUEGNByQI0oKYMHCuIoF40f2HvKfuoDofK874kGlVWxnI0
 Wpbyunq4MjQban0eIyRHMCWGIPMjq9JT/9CRmBukdqmrRnlLDgur3SEmoAA2rN2+jB
 E6lJZ5S4YWqlskuO9sW+pT24c/DLuS7teGRRkaK/ze50GcdttSI/sx9mJisIppIOBP
 pBpKVAB87O9qKwKdggfSaGyYXyec0kgSWXkWcY+kg+I1LHAB76N21CVnQ01KlRrF34
 CxAGpTNWS0JpQ==
Date: Wed, 29 Jul 2020 22:17:10 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v5 3/3] nvme: allow cmb and pmr to be enabled on same
 device
Message-ID: <20200729201710.GB318046@apples.localdomain>
References: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
 <20200723160325.41734-4-andrzej.jakowski@linux.intel.com>
 <20200727090609.GA42976@apples.localdomain>
 <80974eaa-70cf-04dc-13ac-cc09b05adfbd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80974eaa-70cf-04dc-13ac-cc09b05adfbd@linux.intel.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, kbusch@kernel.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 27 11:59, Andrzej Jakowski wrote:
> On 7/27/20 2:06 AM, Klaus Jensen wrote:
> > On Jul 23 09:03, Andrzej Jakowski wrote:
> >> So far it was not possible to have CMB and PMR emulated on the same
> >> device, because BAR2 was used exclusively either of PMR or CMB. This
> >> patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.
> >>
> >> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> >> ---
> >>  hw/block/nvme.c      | 120 +++++++++++++++++++++++++++++--------------
> >>  hw/block/nvme.h      |   1 +
> >>  include/block/nvme.h |   4 +-
> >>  3 files changed, 85 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> >> index 43866b744f..d55a71a346 100644
> >> --- a/hw/block/nvme.c
> >> +++ b/hw/block/nvme.c
> >> @@ -22,12 +22,13 @@
> >>   *              [pmrdev=<mem_backend_file_id>,] \
> >>   *              max_ioqpairs=<N[optional]>
> >>   *
> >> - * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> >> - * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> >> + * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
> >> + * to be resident in BAR4 at offset that is 2MiB aligned. When CMB is emulated
> >> + * on Linux guest it is recommended to make cmb_size_mb multiple of 2. Both
> >> + * size and alignment restrictions are imposed by Linux guest.
> >>   *
> >> - * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
> >> - * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
> >> - * both provided.
> >> + * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
> >> + * whole BAR2/BAR3 exclusively.
> >>   * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
> >>   * For example:
> >>   * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
> >> @@ -57,8 +58,8 @@
> >>  #define NVME_MAX_IOQPAIRS 0xffff
> >>  #define NVME_DB_SIZE  4
> >>  #define NVME_SPEC_VER 0x00010300
> >> -#define NVME_CMB_BIR 2
> >>  #define NVME_PMR_BIR 2
> >> +#define NVME_MSIX_BIR 4
> > 
> > I think that either we keep the CMB constant (but updated with '4' of
> > course) or we just get rid of both NVME_{CMB,MSIX}_BIR and use a literal
> > '4' in nvme_bar4_init. It is very clear that is only BAR 4 we use.
> > 
> >>  #define NVME_TEMPERATURE 0x143
> >>  #define NVME_TEMPERATURE_WARNING 0x157
> >>  #define NVME_TEMPERATURE_CRITICAL 0x175
> >> @@ -111,16 +112,18 @@ static uint16_t nvme_sqid(NvmeRequest *req)
> >>  
> >>  static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> >>  {
> >> -    hwaddr low = n->ctrl_mem.addr;
> >> -    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
> >> +    hwaddr low = memory_region_to_absolute_addr(&n->ctrl_mem, 0);
> >> +    hwaddr hi  = low + int128_get64(n->ctrl_mem.size);
> > 
> > Are we really really sure we want to use a global helper like this? What
> > are the chances/risk that we ever introduce another overlay? I'd say
> > zero. We are not even using a *real* overlay, it's just an io memory
> > region (ctrl_mem) on top of a pure container (bar4). Can't we live with
> > an internal helper doing `n->bar4.addr + n->ctrl_mem.addr` and be done
> > with it? It also removes a data structure walk on each invocation of
> > nvme_addr_is_cmb (which is done for **all** addresses in PRP lists and
> > SGLs).
> 
> Thx!
> My understanding of memory_region_absolute_addr()([1]) function is that it walks
> memory hierarchy up to root while incrementing absolute addr. It is very 
> similar to n->bar4.addr + n->ctrl_mem.addr approach with following 
> differences:
>  * n->bar4.addr + n->ctrl_mem.addr assumes single level hierarchy. Updates would
>    be needed when another memory level is added.
>  * memory_region_to_absolute_addr() works for any-level hierarchy at tradeoff
>    of dereferencing data structure. 
> 
> I don't have data for likelihood of adding new memory level, nor how much more
> memory_region_to_absolute_addr() vs n->bar4.addr + n->ctrl_mem.addr costs.
> 
> Please let me know which approach is preferred.
> 

Since you are directly asking me for my preference, then that is
"n->bar4.addr + n->ctrl_mem.addr". I don't like the walk, even though it
is super short. I know that the raw addition assumes single level
hierarchy, but I am fine with that. I would still like it to be in an
inline helper though.

