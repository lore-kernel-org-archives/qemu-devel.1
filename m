Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE897C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB74E21D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB74E21D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0dJ-0000E7-WB
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD0c3-0007sm-Jb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD0c2-0007Et-3Z
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:17:19 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:58812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD0bw-00077n-FN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:17:16 -0400
Received: from player759.ha.ovh.net (unknown [10.108.42.119])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 54D24208691
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:17:03 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 14761A3A23BC;
 Wed, 25 Sep 2019 06:16:55 +0000 (UTC)
Date: Wed, 25 Sep 2019 08:16:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH v14 4/7] target/ppc: Build rtas error log upon an MCE
Message-ID: <20190925081654.2d970842@bahia.lan>
In-Reply-To: <3282d800-46d5-d270-542c-bcf8bd937944@linux.vnet.ibm.com>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
 <156879435456.18368.1144480383769624512.stgit@aravinda>
 <20190925013052.GG17405@umbus>
 <3282d800-46d5-d270-542c-bcf8bd937944@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 459085690125851028
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.57.129
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, ganeshgr@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 11:31:30 +0530
Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> 
> 
> On Wednesday 25 September 2019 07:00 AM, David Gibson wrote:
> > On Wed, Sep 18, 2019 at 01:42:34PM +0530, Aravinda Prasad wrote:
> >> Upon a machine check exception (MCE) in a guest address space,
> >> KVM causes a guest exit to enable QEMU to build and pass the
> >> error to the guest in the PAPR defined rtas error log format.
> >>
> >> This patch builds the rtas error log, copies it to the rtas_addr
> >> and then invokes the guest registered machine check handler. The
> >> handler in the guest takes suitable action(s) depending on the type
> >> and criticality of the error. For example, if an error is
> >> unrecoverable memory corruption in an application inside the
> >> guest, then the guest kernel sends a SIGBUS to the application.
> >> For recoverable errors, the guest performs recovery actions and
> >> logs the error.
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

[...]

> >> +
> >> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
> >> +{
> >> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> >> +    CPUState *cs = CPU(cpu);
> >> +    uint64_t rtas_addr;
> >> +    CPUPPCState *env = &cpu->env;
> >> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> >> +    target_ulong msr = 0;
> >> +    struct rtas_error_log log;
> >> +    struct mc_extended_log *ext_elog;
> >> +    uint32_t summary;
> >> +
> >> +    /*
> >> +     * Properly set bits in MSR before we invoke the handler.
> >> +     * SRR0/1, DAR and DSISR are properly set by KVM
> >> +     */
> >> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> >> +        msr |= (1ULL << MSR_LE);
> >> +    }
> >> +
> >> +    if (env->msr & (1ULL << MSR_SF)) {
> >> +        msr |= (1ULL << MSR_SF);
> >> +    }
> >> +
> >> +    msr |= (1ULL << MSR_ME);
> >> +
> >> +    ext_elog = g_malloc0(sizeof(*ext_elog));
> > 
> > g_new0() is preferred for this sort of thing.
> 
> I feel g_malloc0() is used to allocate extended logs in other places in
> this file, so I think g_malloc0() should be fine. Please let me know.
> 

CODING_STYLE indeed promotes the use of g_new0() but it accepts
the g_malloc(sizeof(*foo)) syntax:

Declarations like

.. code-block:: c

    T *v = g_malloc(sizeof(*v))

are acceptable, though.


