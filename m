Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE63C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3821206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhkP7Qyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3821206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRKO-0006uf-0w
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:05:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMRDH-00019D-2U
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMRDF-0005qa-UD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMRDF-0005qK-NC; Fri, 03 May 2019 01:58:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id 85so2203818pgc.3;
	Thu, 02 May 2019 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=WCQkcT5ngtSCJw7dr2VFRTss9x1IgvdYs7Q3LRr0k8c=;
	b=EhkP7QyqwmFe/YQHe3Rf2iFeAIw92hZHrHgwMk6m0BHvMlIWbJoIPzqhdlHuxNsB1M
	5/TEoJTIiI/XtJOgkWUQ1EgcZEBeNvn4vVQqML/RO8RUyoudvETkqVYi41VOlRnkBQso
	CVhsIuPgUHF6VijydhdugJjUQ6qFUgQF1lUwCcADGzO4rQlymQtastH8t48+0250wIjm
	CYNxzJe27Xudxbqk1gPXVN0wU5HSV6SjsY1BrNFmxBFZ1HyGB5tKBIhhlYTxSGVhER0t
	XGoRFZULLgLV4AJ1iwwvY4CX0s0DkekNZZ8jaMZNt/pBi6ZGBH00mQCypih3feoeV2L2
	3gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=WCQkcT5ngtSCJw7dr2VFRTss9x1IgvdYs7Q3LRr0k8c=;
	b=GnRPFAJ+n+jIHOsT37BI/QUuIzXPeLhPNWsDS/vSEcONb+B5klE5FdeIQmZ8CImSyT
	jVqvhDDo6fd7k/96a0ILvM6qp80vePhEp1eEABmm5boeyAnawQO47tfYMsJfjcw9cebs
	uUQv2k54OaqTgDkQpN/s8K7um6Ma1aMlXeo18zU2NeiqSflzMqcmF0pPN5bqAu95X0a2
	Z9Q0OmjePhvbQpZujDfgI1OBN2lQ4vX5KzIAY1Xa4iW57xF1idPxSGtxRhIoRWGx3xUM
	zWQpfBKeVXwf8vGYUblgDeR7Ymy06O3r0msqF6Ad0WyNVnOj39XomSXfddnlIhj5giZ/
	m+zg==
X-Gm-Message-State: APjAAAVGB/sOLHEwsERtK89UtGo6qGDP9RfTXtfrRWpRChXpzB+fKWNf
	8e2YvrziqbPU9N7Wm4XVsLGfLkpJWWo=
X-Google-Smtp-Source: APXvYqzG9jK1RICnG1iTObW+6ASIwodmuZZkKgsLPXjvcHvKGMZAee4ewoCHaeHqQ4HqZRjOzD5T2A==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr8147854pgs.193.1556863104737; 
	Thu, 02 May 2019 22:58:24 -0700 (PDT)
Received: from localhost.localdomain ([1.129.142.155])
	by smtp.googlemail.com with ESMTPSA id
	t7sm287953pfa.42.2019.05.02.22.58.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:58:23 -0700 (PDT)
Message-ID: <1556863097.1887.4.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 03 May 2019 15:58:17 +1000
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503055817.rImS7xFNBjRhL3UGUwEIUsvZgjjvH6l1X0Yz8mF4u1Q@z>

On Fri, 2019-05-03 at 15:53 +1000, Suraj Jitindar Singh wrote:
> This patch series adds the necessary parts so that a tcg guest is
> able to use
> kvm facilities. That is a tcg guest can boot its own kvm guests.
> 
> The main requirements for this were a few registers and instructions
> as well as
> some hcalls and the addition of partition scoped translation in the
> radix mmu
> emulation.
> 
> This can be used to boot a kvm guest under a pseries tcg guest:
> Use power9_v2.2 cpu and add -machine cap-nested-hv=on for the first
> guest.
> Then inside that guest boot a kvm guest as normal.
> This takes advantage of the new hcalls with qemu emulating them as a
> normal
> hypervisor would on a real machine.
> 
> This can also be used to boot a kvm guest under a powernv tcg guest:
> Use any power9 cpu type.
> This takes advantage of the new hv register access added.
> Note that for powernv there is no xive interrupt excalation for KVM
> which means
> that while the guest will boot, it won't receive any interrupts.

Ah so I'm suddenly aware I based this on the wrong tree so it won't
apply to your dwg-ppc-for-4.1 David.

Consider this a RFC and I'll rebase and resend when required.

> 
> Suraj Jitindar Singh (13):
>   target/ppc: Implement the VTB for HV access
>   target/ppc: Work [S]PURR implementation and add HV support
>   target/ppc: Add SPR ASDR
>   target/ppc: Add SPR TBU40
>   target/ppc: Add privileged message send facilities
>   target/ppc: Enforce that the root page directory size must be at
> least
>     5
>   target/ppc: Handle partition scoped radix tree translation
>   target/ppc: Implement hcall H_SET_PARTITION_TABLE
>   target/ppc: Implement hcall H_ENTER_NESTED
>   target/ppc: Implement hcall H_TLB_INVALIDATE
>   target/ppc: Implement hcall H_COPY_TOFROM_GUEST
>   target/ppc: Introduce POWER9 DD2.2 cpu type
>   target/ppc: Enable SPAPR_CAP_NESTED_KVM_HV under tcg
> 
>  hw/ppc/ppc.c                    |  46 ++++-
>  hw/ppc/spapr_caps.c             |  22 ++-
>  hw/ppc/spapr_cpu_core.c         |   1 +
>  hw/ppc/spapr_hcall.c            | 409
> +++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/ppc.h            |   4 +-
>  include/hw/ppc/spapr.h          |   7 +-
>  linux-user/ppc/cpu_loop.c       |   5 +
>  target/ppc/cpu-models.c         |   2 +
>  target/ppc/cpu-models.h         |   1 +
>  target/ppc/cpu.h                |  70 +++++++
>  target/ppc/excp_helper.c        |  79 +++++++-
>  target/ppc/helper.h             |   9 +
>  target/ppc/misc_helper.c        |  46 +++++
>  target/ppc/mmu-radix64.c        | 412 ++++++++++++++++++++++++++++
> ------------
>  target/ppc/mmu-radix64.h        |   4 +
>  target/ppc/timebase_helper.c    |  20 ++
>  target/ppc/translate.c          |  28 +++
>  target/ppc/translate_init.inc.c | 107 +++++++++--
>  18 files changed, 1115 insertions(+), 157 deletions(-)
> 

