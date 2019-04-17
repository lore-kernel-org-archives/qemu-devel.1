Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A426FC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BD2206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 12:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BD2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGjHF-0000ce-Kt
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 08:02:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hGjGB-0000F9-Bu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hGjGA-0008SS-DJ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:01:51 -0400
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:45471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hGjGA-0008MP-1P
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:01:50 -0400
Received: from player762.ha.ovh.net (unknown [10.109.146.211])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A1EEA16AC09
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 14:01:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player762.ha.ovh.net (Postfix) with ESMTPSA id DF36D4DE4434;
	Wed, 17 Apr 2019 12:01:30 +0000 (UTC)
Date: Wed, 17 Apr 2019 14:01:29 +0200
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190417140129.18980f0e@bahia.lan>
In-Reply-To: <1555498879.055yucy998.astroid@bobo.none>
References: <20190416045552.24573-1-npiggin@gmail.com>
	<20190417015934.GH32705@umbus.fritz.box>
	<1555498879.055yucy998.astroid@bobo.none>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1558526946723862979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrfeefgdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.60.232
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] spapr: add splpar hcalls
 H_PROD, H_CONFER
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	=?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417120129.-xWmAvItjT9LIDWjAT-L_QBQeNfQaEcekjidrFg91OE@z>

On Wed, 17 Apr 2019 21:20:00 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:
> [...]
> >> @@ -1860,6 +1928,9 @@ static void hypercall_register_types(void)
> >>      /* hcall-splpar */
> >>      spapr_register_hypercall(H_REGISTER_VPA, h_register_vpa);
> >>      spapr_register_hypercall(H_CEDE, h_cede);
> >> +    spapr_register_hypercall(H_CONFER, h_confer);
> >> +    spapr_register_hypercall(H_PROD, h_prod);
> >> +
> >>      spapr_register_hypercall(H_SIGNAL_SYS_RESET, h_signal_sys_reset);  
> > 
> > You're no longer enabling the KVM CONFER and PROD hypercalls.  Are
> > they enabled by default, or is that an intentional change?  
> 

AFAICT they seem to be enabled by default in HV KVM.

> Oh, it was not intentional, I must not understand how this works. Why
> is this no longer enabling the those hcalls?
> 

Since linux commit 699a0ea0823d ("KVM: PPC: Book3S: Controls for in-kernel 
sPAPR hypercall handling"), in-kernel hypercalls are disabled by default
and must be explicitely enabled by userspace. QEMU does that for some
hypercalls already (search kvmppc_enable_set_mode_hcall() in QEMU for an
example).

Since H_CONFER and H_PROD are listed in default_hcall_list[] in book3s_hv.c,
no need for QEMU to enable them in KVM.

Not sure about David's "no longer" wording though.

> Thanks,
> Nick
> 
> 

Cheers,

--
Greg

