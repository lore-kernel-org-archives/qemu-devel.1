Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A8C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588E520663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588E520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEF7j-0002E8-GP
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jEEom-00056d-Io
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jEEol-0000Be-47
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:11:48 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:40098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jEEok-0007GI-Ru
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:11:47 -0400
Received: from player699.ha.ovh.net (unknown [10.108.42.239])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id D71501B64A8
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 17:11:35 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 3D27E10806006;
 Tue, 17 Mar 2020 16:11:28 +0000 (UTC)
Date: Tue, 17 Mar 2020 17:11:22 +0100
From: Greg Kurz <groug@kaod.org>
To: mahesh@linux.ibm.com
Subject: Re: [PATCH] ppc/spapr: Set the effective address provided flag in
 mc error log.
Message-ID: <20200317171122.21c49c15@bahia.lan>
In-Reply-To: <158446030854.25100.12364998990821380964@39012742ff91>
References: <158444819283.31599.12155058652686614304.stgit@jupiter>
 <158446030854.25100.12364998990821380964@39012742ff91>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17777678058329708953
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepphgrthgthhgvfidrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.253.128
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, npiggin@gmail.com,
 ganeshgr@linux.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 08:51:50 -0700 (PDT)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/158444819283.31599.12155058652686614304.stgit@jupiter/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [PATCH] ppc/spapr: Set the effective address provided flag in mc error log.
> Message-id: 158444819283.31599.12155058652686614304.stgit@jupiter
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Switched to a new branch 'test'
> 62d8ada ppc/spapr: Set the effective address provided flag in mc error log.
> 
> === OUTPUT BEGIN ===
> ERROR: code indent should never use tabs
> #57: FILE: hw/ppc/spapr_events.c:739:
> +^Iswitch (ext_elog->mc.error_type) {$
> 

Yeah no tabs allowed in the QEMU code (see CODING_STYLE.rst).

If your editor is emacs, you can consider setting these:

  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

> ERROR: code indent should never use tabs
> #58: FILE: hw/ppc/spapr_events.c:740:
> +^Icase RTAS_LOG_V6_MC_TYPE_UE:$
> 
> ERROR: code indent should never use tabs
> #59: FILE: hw/ppc/spapr_events.c:741:
> +^I^Iext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED;$
> 
> ERROR: code indent should never use tabs
> #60: FILE: hw/ppc/spapr_events.c:742:
> +^I^Ibreak;$
> 
> ERROR: code indent should never use tabs
> #61: FILE: hw/ppc/spapr_events.c:743:
> +^Icase RTAS_LOG_V6_MC_TYPE_SLB:$
> 
> ERROR: code indent should never use tabs
> #62: FILE: hw/ppc/spapr_events.c:744:
> +^Icase RTAS_LOG_V6_MC_TYPE_ERAT:$
> 
> ERROR: code indent should never use tabs
> #63: FILE: hw/ppc/spapr_events.c:745:
> +^Icase RTAS_LOG_V6_MC_TYPE_TLB:$
> 
> ERROR: code indent should never use tabs
> #64: FILE: hw/ppc/spapr_events.c:746:
> +^I^Iext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;$
> 
> ERROR: code indent should never use tabs
> #65: FILE: hw/ppc/spapr_events.c:747:
> +^I^Ibreak;$
> 
> ERROR: code indent should never use tabs
> #66: FILE: hw/ppc/spapr_events.c:748:
> +^Idefault:$
> 
> ERROR: code indent should never use tabs
> #67: FILE: hw/ppc/spapr_events.c:749:
> +^I^Ibreak;$
> 
> ERROR: code indent should never use tabs
> #68: FILE: hw/ppc/spapr_events.c:750:
> +^I}$
> 
> total: 12 errors, 0 warnings, 50 lines checked
> 
> Commit 62d8adac0688 (ppc/spapr: Set the effective address provided flag in mc error log.) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/158444819283.31599.12155058652686614304.stgit@jupiter/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

