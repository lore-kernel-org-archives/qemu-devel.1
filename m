Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62499C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 23:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4C320835
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajorpSfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4C320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNnJa-0004H7-Hr
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 19:46:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hNnIe-0003st-UC
	for qemu-devel@nongnu.org; Mon, 06 May 2019 19:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hNnId-0005ii-Pj
	for qemu-devel@nongnu.org; Mon, 06 May 2019 19:45:36 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hNnIb-0005gh-Qu; Mon, 06 May 2019 19:45:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id e24so7577815pfi.12;
	Mon, 06 May 2019 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=e2l5pJUPKknXNnVeHY0YKdAoD5TP9xyoisvplkCBUy8=;
	b=ajorpSfbmoisKj/1ZSK//M5sgm9+9wag3l8ZT34fek4itCt9vKZMFBrqS9Kkq9pnzt
	V2BhoS+QiluwCxePnLcjmVXGOb4EYDxh29a6uzyheYQjln9voR3/IrMRCq2kzc0hrtXT
	qu/VPjzEBov+Se8hPOdu4yCpsDgDR+Jv8cJ91sKBtj5elm1vMU9ArjAsLgq7Gqm/xxhw
	rxyDYebDzOdsy7d5FAUGQREML5V0VCUZc1uyK7rfoTt43l3QT+njfYrRZ6bzLFU5IzXj
	bPuZEElpG8HKZgZmgllE7kuEFL8CJZDyDSQoVWBoMCTzqZ/P3i5SmM8hBnA9BYu80jbK
	xwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=e2l5pJUPKknXNnVeHY0YKdAoD5TP9xyoisvplkCBUy8=;
	b=Xij+y+hpcBZ84iQ3GXHgTim/bb6/oJB3oFXapnaQkqmGizqL/+p3AWL6fJQJS3+ycA
	pxN7PQ3ZkD8xw39hUT5lycRKS4EXch24rnwAHdqlET+RLfUWkuTV0t3iyFJ5i9ie5y8f
	ZcX+0Jg4yhn1S9HWG3KI1PLCmhcSTX0uLVjdUDXhPJia02ZxTm/xSEkJ2Raoln+I/m9C
	fzLCQwxzJGdFYp6gXAs4K0CxoRh5BSC1FoHavE2Leuo5qDrZi/GWjFrdc6U8M/fn/BPQ
	y8sXLneZP7AFQlF37v7umD7tztW8YhkpNEQu5Ky8idx2xF2RwJSmkfz6tsa9DONEhJFH
	kjsw==
X-Gm-Message-State: APjAAAWsZqcr5P3vC9YC/Rq6SQ5VwGo22Zwc8xZdl+RoN+BsqHwYbwVS
	1aMSKkRnMv8zx8Dgr+wZ/C+Tg36V
X-Google-Smtp-Source: APXvYqyssnp5TejzYTSQhHnBYUVa37JjQ99go1YmITQUD/sl7TThVO+w63tmb7MANDxfs4urqqV+XA==
X-Received: by 2002:aa7:9203:: with SMTP id 3mr5187533pfo.123.1557186331321;
	Mon, 06 May 2019 16:45:31 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
	by smtp.googlemail.com with ESMTPSA id
	w125sm18859739pfw.69.2019.05.06.16.45.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 06 May 2019 16:45:30 -0700 (PDT)
Message-ID: <1557186326.6435.4.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 07 May 2019 09:45:26 +1000
In-Reply-To: <20190506062023.GK6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190506062023.GK6790@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 00/13] target/ppc: Implement KVM
 support under TCG
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-05-06 at 16:20 +1000, David Gibson wrote:
> On Fri, May 03, 2019 at 03:53:03PM +1000, Suraj Jitindar Singh wrote:
> > This patch series adds the necessary parts so that a tcg guest is
> > able to use
> > kvm facilities. That is a tcg guest can boot its own kvm guests.
> 
> The topic line is a bit hard to parse.  IIUC there are basically two
> things in this series:
> 
> 1) Implement / fix TCG emulation of TCG hypervisor facilities, so
> that
>    a TCG powernv machine can use them to run KVM guests.
> 
> 2) Have the pseries machine under TCG implement the paravirtualized
>    interfaces to allow nested virtualizationm therefore allowing TCG
>    pseries machines to run KVM guests
> 
> Is that right?

That is correct.

Patches 1-7 achieve 1) TCG emulation of hypervisor facilities

Patches 8-13 achieve 2) emulation of paravirtualised KVM for pseries
guest

> 
> > The main requirements for this were a few registers and
> > instructions as well as
> > some hcalls and the addition of partition scoped translation in the
> > radix mmu
> > emulation.
> > 
> > This can be used to boot a kvm guest under a pseries tcg guest:
> > Use power9_v2.2 cpu and add -machine cap-nested-hv=on for the first
> > guest.
> > Then inside that guest boot a kvm guest as normal.
> > This takes advantage of the new hcalls with qemu emulating them as
> > a normal
> > hypervisor would on a real machine.
> > 
> > This can also be used to boot a kvm guest under a powernv tcg
> > guest:
> > Use any power9 cpu type.
> > This takes advantage of the new hv register access added.
> > Note that for powernv there is no xive interrupt excalation for KVM
> > which means
> > that while the guest will boot, it won't receive any interrupts.
> > 
> > Suraj Jitindar Singh (13):
> >   target/ppc: Implement the VTB for HV access
> >   target/ppc: Work [S]PURR implementation and add HV support
> >   target/ppc: Add SPR ASDR
> >   target/ppc: Add SPR TBU40
> >   target/ppc: Add privileged message send facilities
> >   target/ppc: Enforce that the root page directory size must be at
> > least
> >     5
> >   target/ppc: Handle partition scoped radix tree translation
> >   target/ppc: Implement hcall H_SET_PARTITION_TABLE
> >   target/ppc: Implement hcall H_ENTER_NESTED
> >   target/ppc: Implement hcall H_TLB_INVALIDATE
> >   target/ppc: Implement hcall H_COPY_TOFROM_GUEST
> >   target/ppc: Introduce POWER9 DD2.2 cpu type
> >   target/ppc: Enable SPAPR_CAP_NESTED_KVM_HV under tcg
> > 
> >  hw/ppc/ppc.c                    |  46 ++++-
> >  hw/ppc/spapr_caps.c             |  22 ++-
> >  hw/ppc/spapr_cpu_core.c         |   1 +
> >  hw/ppc/spapr_hcall.c            | 409
> > +++++++++++++++++++++++++++++++++++++++
> >  include/hw/ppc/ppc.h            |   4 +-
> >  include/hw/ppc/spapr.h          |   7 +-
> >  linux-user/ppc/cpu_loop.c       |   5 +
> >  target/ppc/cpu-models.c         |   2 +
> >  target/ppc/cpu-models.h         |   1 +
> >  target/ppc/cpu.h                |  70 +++++++
> >  target/ppc/excp_helper.c        |  79 +++++++-
> >  target/ppc/helper.h             |   9 +
> >  target/ppc/misc_helper.c        |  46 +++++
> >  target/ppc/mmu-radix64.c        | 412
> > ++++++++++++++++++++++++++++------------
> >  target/ppc/mmu-radix64.h        |   4 +
> >  target/ppc/timebase_helper.c    |  20 ++
> >  target/ppc/translate.c          |  28 +++
> >  target/ppc/translate_init.inc.c | 107 +++++++++--
> >  18 files changed, 1115 insertions(+), 157 deletions(-)
> > 
> 
> 

