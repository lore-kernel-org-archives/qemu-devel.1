Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0542FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD992073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD992073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqF4r-0004PY-5U
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqF3a-0003Cn-SG; Tue, 30 Jun 2020 08:08:10 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jqF3Y-00009H-DC; Tue, 30 Jun 2020 08:08:10 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DA560BF676;
 Tue, 30 Jun 2020 12:08:04 +0000 (UTC)
Date: Tue, 30 Jun 2020 14:08:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 08/18] hw/block/nvme: Make Zoned NS Command Set
 definitions
Message-ID: <20200630120801.hvy736qj2y2ogiiq@apples.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-9-dmitry.fomichev@wdc.com>
 <20200630114448.pspldgtlxrzjxps3@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630114448.pspldgtlxrzjxps3@apples.localdomain>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 04:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 30 13:44, Klaus Jensen wrote:
> On Jun 18 06:34, Dmitry Fomichev wrote:
> > Define values and structures that are needed to support Zoned
> > Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> > 
> > All new protocol definitions are located in include/block/nvme.h
> > and everything added that is specific to this implementation is kept
> > in hw/block/nvme.h.
> > 
> > In order to improve scalability, all open, closed and full zones
> > are organized in separate linked lists. Consequently, almost all
> > zone operations don't require scanning of the entire zone array
> > (which potentially can be quite large) - it is only necessary to
> > enumerate one or more zone lists. Zone lists are designed to be
> > position-independent as they can be persisted to the backing file
> > as a part of zone metadata. NvmeZoneList struct defined in this patch
> > serves as a head of every zone list.
> > 
> > NvmeZone structure encapsulates NvmeZoneDescriptor defined in Zoned
> > Command Set specification and adds a few more fields that are
> > internal to this implementation.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Alexey Bogoslavsky <alexey.bogoslavsky@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  hw/block/nvme.h      | 130 +++++++++++++++++++++++++++++++++++++++++++
> >  include/block/nvme.h | 119 ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 248 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 0d29f75475..2c932b5e29 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -121,6 +165,86 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> >      return n->ns_size >> nvme_ns_lbads(ns);
> >  }
> >  
> > +static inline uint8_t nvme_get_zone_state(NvmeZone *zone)
> > +{
> > +    return zone->d.zs >> 4;
> > +}
> > +
> > +static inline void nvme_set_zone_state(NvmeZone *zone, enum NvmeZoneState state)
> > +{
> > +    zone->d.zs = state << 4;
> > +}
> > +
> > +static inline uint64_t nvme_zone_rd_boundary(NvmeCtrl *n, NvmeZone *zone)
> > +{
> > +    return zone->d.zslba + n->params.zone_size;
> > +}
> > +
> > +static inline uint64_t nvme_zone_wr_boundary(NvmeZone *zone)
> > +{
> > +    return zone->d.zslba + zone->d.zcap;
> > +}
> 
> Everything working on zone->d needs leXX_to_cpu() conversions.

Disregard this. I see from the following patches that you keep zone->d
in cpu endianess and convert on zone management receive.

Sorry!

