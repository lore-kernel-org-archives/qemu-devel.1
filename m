Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E22C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A373C20781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agu230Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A373C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35733 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEO3-0005T8-SA
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJEMy-0003vU-O2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJEMx-0008Qa-FG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:43:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJEMx-0008Pz-Bs
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585651422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0Baq7HfJJzRoGwBTi7Al5a1UpXKh7r6x4Tja9LMQUw=;
 b=agu230Z4ia50c3/Kf9zgy1yy2e+TXDaLs5sfhOg/lm/J0fyq/+ZswjPQee+3st8KXenBHF
 FInPVt9Y3r4ogJGa34zv+TpcjKywMp+nqhMljceXGkSW0tQ9Tr2vGfsp1e3S5I+3wA23N3
 dmL1Del/sk349uV7BifdyEKt2Vzozks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Gv3FHmd5N8mfLTIlcG9j7Q-1; Tue, 31 Mar 2020 06:43:38 -0400
X-MC-Unique: Gv3FHmd5N8mfLTIlcG9j7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83F14101FC72;
 Tue, 31 Mar 2020 10:43:37 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3847A5D9CA;
 Tue, 31 Mar 2020 10:43:35 +0000 (UTC)
Message-ID: <ae6cde248f173b5e82335f6aab409110ff93eb0a.camel@redhat.com>
Subject: Re: [PATCH v6 04/42] nvme: bump spec data structures to v1.3
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 13:43:34 +0300
In-Reply-To: <20200331053829.wprsixru5machmwp@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-5-its@irrelevant.dk>
 <edab0548c595bee319de4db4eefec87c1edfa1cd.camel@redhat.com>
 <20200331053829.wprsixru5machmwp@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:38 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:37, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:28 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Add missing fields in the Identify Controller and Identify Namespace
> > > data structures to bring them in line with NVMe v1.3.
> > > 
> > > This also adds data structures and defines for SGL support which
> > > requires a couple of trivial changes to the nvme block driver as well.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Acked-by: Fam Zheng <fam@euphon.net>
> > > ---
> > >  block/nvme.c         |  18 ++---
> > >  hw/block/nvme.c      |  12 ++--
> > >  include/block/nvme.h | 153 ++++++++++++++++++++++++++++++++++++++-----
> > >  3 files changed, 151 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index d41c4bda6e39..99b9bb3dac96 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c
> > > @@ -589,6 +675,16 @@ enum NvmeIdCtrlOncs {
> > >  #define NVME_CTRL_CQES_MIN(cqes) ((cqes) & 0xf)
> > >  #define NVME_CTRL_CQES_MAX(cqes) (((cqes) >> 4) & 0xf)
> > >  
> > > +#define NVME_CTRL_SGLS_SUPPORTED_MASK            (0x3 <<  0)
> > > +#define NVME_CTRL_SGLS_SUPPORTED_NO_ALIGNMENT    (0x1 <<  0)
> > > +#define NVME_CTRL_SGLS_SUPPORTED_DWORD_ALIGNMENT (0x1 <<  1)
> > > +#define NVME_CTRL_SGLS_KEYED                     (0x1 <<  2)
> > > +#define NVME_CTRL_SGLS_BITBUCKET                 (0x1 << 16)
> > > +#define NVME_CTRL_SGLS_MPTR_CONTIGUOUS           (0x1 << 17)
> > > +#define NVME_CTRL_SGLS_EXCESS_LENGTH             (0x1 << 18)
> > > +#define NVME_CTRL_SGLS_MPTR_SGL                  (0x1 << 19)
> > > +#define NVME_CTRL_SGLS_ADDR_OFFSET               (0x1 << 20)
> > 
> > OK
> > > +
> > >  typedef struct NvmeFeatureVal {
> > >      uint32_t    arbitration;
> > >      uint32_t    power_mgmt;
> > > @@ -611,6 +707,10 @@ typedef struct NvmeFeatureVal {
> > >  #define NVME_INTC_THR(intc)     (intc & 0xff)
> > >  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
> > >  
> > > +#define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
> > 
> > Nitpick: If we are adding this, I'll add a #define for the values as well
> > 
> 
> Done. And used in the subsequent "nvme: add temperature threshold
> feature" patch.
Thank you!

> 
> > > +#define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
> > > +#define NVME_TEMP_TMPTH(temp)  ((temp >>  0) & 0xffff)
> > > +
> > >  enum NvmeFeatureIds {
> > >      NVME_ARBITRATION                = 0x1,
> > >      NVME_POWER_MANAGEMENT           = 0x2,
> > > @@ -653,18 +753,37 @@ typedef struct NvmeIdNs {
> > >      uint8_t     mc;
> > >      uint8_t     dpc;
> > >      uint8_t     dps;
> > > -
> > >      uint8_t     nmic;
> > >      uint8_t     rescap;
> > >      uint8_t     fpi;
> > >      uint8_t     dlfeat;
> > > -
> > > -    uint8_t     res34[94];
> > > +    uint16_t    nawun;
> > > +    uint16_t    nawupf;
> > > +    uint16_t    nacwu;
> > > +    uint16_t    nabsn;
> > > +    uint16_t    nabo;
> > > +    uint16_t    nabspf;
> > > +    uint16_t    noiob;
> > > +    uint8_t     nvmcap[16];
> > > +    uint8_t     rsvd64[40];
> > > +    uint8_t     nguid[16];
> > > +    uint64_t    eui64;
> > >      NvmeLBAF    lbaf[16];
> > > -    uint8_t     res192[192];
> > > +    uint8_t     rsvd192[192];
> > >      uint8_t     vs[3712];
> > >  } NvmeIdNs;
> > 
> > Also checked this against V5, looks OK now
> > 
> > >  
> > > +typedef struct NvmeIdNsDescr {
> > > +    uint8_t nidt;
> > > +    uint8_t nidl;
> > > +    uint8_t rsvd2[2];
> > > +} NvmeIdNsDescr;
> > 
> > OK
> > 
> > 
> > 
> > > +
> > > +#define NVME_NIDT_UUID_LEN 16
> > > +
> > > +enum {
> > > +    NVME_NIDT_UUID = 0x3,
> > 
> > Very minor nitpick: I'll would add others as well just for the sake
> > of better understanding what this is
> > 
> 
> Done.
Thanks!
> 
> > > +};
> > >  
> > >  /*Deallocate Logical Block Features*/
> > >  #define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
> > 
> > Looks very good.
> > 
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> 

Best regards,
	Maxim Levitsky



