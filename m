Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD6C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0630F24640
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0630F24640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX21M-0007us-2W
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX20j-0007DB-6i
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:54:05 -0400
Received: from 2.mo51.mail-out.ovh.net ([178.33.255.19]:47043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX20h-0001K9-5s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:54:04 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.141])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 67033232439;
 Mon, 26 Oct 2020 13:54:00 +0100 (CET)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 26 Oct
 2020 13:53:59 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004e743171c-85ae-4edd-a0cf-011f0558621b,
 D69A261E470FD7A087455D2B3B9CC66C186A091D) smtp.auth=groug@kaod.org
Date: Mon, 26 Oct 2020 13:53:57 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/4] spapr: Error handling fixes and cleanups (round 5)
Message-ID: <20201026135357.365abeac@bahia.lan>
In-Reply-To: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2d5f7991-0358-4f88-bec0-24be6a5f7400
X-Ovh-Tracer-Id: 14332424339855350237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.255.19; envelope-from=groug@kaod.org;
 helo=2.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:54:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Heh... this is round 4 actually :)

On Mon, 26 Oct 2020 13:40:26 +0100
Greg Kurz <groug@kaod.org> wrote:

> Hi,
> 
> This the last round I had on my queue for 5.2. Basically ensuring that
> meaningful negative errnos get propagated to VMState, with some fairly
> simple cleanups on the way.
> 
> ---
> 
> Greg Kurz (4):
>       spapr: qemu_memalign() doesn't return NULL
>       spapr: Use error_append_hint() in spapr_reallocate_hpt()
>       target/ppc: Fix kvmppc_load_htab_chunk() error reporting
>       spapr: Improve spapr_reallocate_hpt() error reporting
> 
> 
>  hw/ppc/spapr.c         |   36 ++++++++++++++++++------------------
>  hw/ppc/spapr_hcall.c   |    8 ++------
>  include/hw/ppc/spapr.h |    3 +--
>  target/ppc/kvm.c       |   11 +++++------
>  target/ppc/kvm_ppc.h   |    5 +++--
>  5 files changed, 29 insertions(+), 34 deletions(-)
> 
> --
> Greg
> 
> 


