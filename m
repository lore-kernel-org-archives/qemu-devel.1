Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54640C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAA0206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAA0206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHCc-0002p3-GU
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jrHC2-00027e-Ti; Fri, 03 Jul 2020 04:37:10 -0400
Received: from charlie.dont.surf ([128.199.63.193]:53386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jrHC0-0006yY-4D; Fri, 03 Jul 2020 04:37:10 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id CC063BF465;
 Fri,  3 Jul 2020 08:37:04 +0000 (UTC)
Date: Fri, 3 Jul 2020 10:37:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 15/18] hw/block/nvme: reject invalid nsid values in
 active namespace id list
Message-ID: <20200703083701.sj4xlgyzp6xte4xi@apples.localdomain>
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-16-its@irrelevant.dk>
 <6a038075-13fd-2f60-23a2-ddc7081cff32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a038075-13fd-2f60-23a2-ddc7081cff32@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:42:13
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  3 10:20, Philippe Mathieu-Daudé wrote:
> On 7/3/20 8:34 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Reject the nsid broadcast value (0xffffffff) and 0xfffffffe in the
> > Active Namespace ID list.
> 
> Can we have a definition instead of this 0xfffffffe magic value please?
> 

Hmm, not really actually. It's not a magic value, its just because the
logic in Active Namespace ID list would require that it should report
any namespaces with ids *higher* than the one specified, so since
0xffffffff (NVME_NSID_BROADCAST) is invalid, NVME_NSID_BROADCAST - 1
needs to be as well.

What do you say I change it to `min_nsid >= NVME_NSID_BROADCAST - 1`?
The original condition just reads well if you are sitting with the spec
on the side.

> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 65c2fa3ac1f4..0dac7a41ddae 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -956,6 +956,10 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
> >  
> >      trace_pci_nvme_identify_nslist(min_nsid);
> >  
> > +    if (min_nsid == 0xfffffffe || min_nsid == NVME_NSID_BROADCAST) {
> > +        return NVME_INVALID_NSID | NVME_DNR;
> > +    }
> > +
> >      list = g_malloc0(data_len);
> >      for (i = 0; i < n->num_namespaces; i++) {
> >          if (i < min_nsid) {
> > 
> 

