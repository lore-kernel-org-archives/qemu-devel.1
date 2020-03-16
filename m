Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF15C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24DB20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24DB20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuLE-0001Ox-QD
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDtVA-0007fT-5y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDtV8-00005I-Q8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:07 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:47793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDtV8-0008LG-Ec
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:26:06 -0400
Received: from player734.ha.ovh.net (unknown [10.108.35.158])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5F54315F390
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 18:26:04 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 88C201057C669;
 Mon, 16 Mar 2020 17:25:47 +0000 (UTC)
Date: Mon, 16 Mar 2020 18:25:46 +0100
From: Greg Kurz <groug@kaod.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/8] ppc/spapr: Change FWNMI names
Message-ID: <20200316182546.65def6fd@bahia.lan>
In-Reply-To: <20200316171845.dq425igrgb5gion2@in.ibm.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-3-npiggin@gmail.com>
 <20200316171845.dq425igrgb5gion2@in.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13162895813958474148
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.220
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 22:48:45 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 2020-03-17 00:26:07 Tue, Nicholas Piggin wrote:
> > The option is called "FWNMI", and it involves more than just machine
> > checks, also machine checks can be delivered without the FWNMI option,
> > so re-name various things to reflect that.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/spapr.c                    | 28 ++++++++++++++--------------
> >  hw/ppc/spapr_caps.c               | 14 +++++++-------
> >  hw/ppc/spapr_events.c             | 14 +++++++-------
> >  hw/ppc/spapr_rtas.c               | 17 +++++++++--------
> >  include/hw/ppc/spapr.h            | 27 +++++++++++++++++----------
> >  tests/qtest/libqos/libqos-spapr.h |  2 +-
> >  6 files changed, 55 insertions(+), 47 deletions(-)
> > 
> [...]
> > @@ -626,14 +626,14 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
> >          .type = "bool",
> >          .apply = cap_ccf_assist_apply,
> >      },
> > -    [SPAPR_CAP_FWNMI_MCE] = {
> > -        .name = "fwnmi-mce",
> > -        .description = "Handle fwnmi machine check exceptions",
> > -        .index = SPAPR_CAP_FWNMI_MCE,
> > +    [SPAPR_CAP_FWNMI] = {
> > +        .name = "fwnmi",
> 
> I guess this should be fine and should hit QEMU 5.0 release so that we
> don't end up with two different CAP names for 5.0 and future releases.
> 

Yeah we really want this patch and the next one (which affects migration) to
go to 5.0.

> Thanks,
> -Mahesh.
> 


