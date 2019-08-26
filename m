Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1789FC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13B72053B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13B72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Fhh-0008Qa-1Z
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i2FUj-0004j6-Jv
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i2FUh-0003mv-NS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1i2FUh-0003hf-E3
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:57:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D13043060288;
 Mon, 26 Aug 2019 13:57:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D993460C80;
 Mon, 26 Aug 2019 13:57:10 +0000 (UTC)
Date: Mon, 26 Aug 2019 15:57:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <20190826155709.3ff98671@redhat.com>
In-Reply-To: <19ebf1f4-eb22-d6f7-aecb-9d4f6c941923@oracle.com>
References: <20190816112407.28180-1-imammedo@redhat.com>
 <20190816112407.28180-3-imammedo@redhat.com>
 <19ebf1f4-eb22-d6f7-aecb-9d4f6c941923@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 26 Aug 2019 13:57:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [POC Seabios PATCH] seabios: use isolated SMM
 address space for relocation
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 edk2-devel-groups-io <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>, qemu-devel@nongnu.org, "Yao,
 Jiewen" <jiewen.yao@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
 pbonzini@redhat.com, Joao Marcal Lemos Martins <joao.m.martins@oracle.com>,
 edk2-rfc-groups-io <rfc@edk2.groups.io>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 18:43:11 -0400
Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:

> On 8/16/19 7:24 AM, Igor Mammedov wrote:
> > for purpose of demo SMRAM (at 0x30000) is aliased at a0000 in system address space
> > for easy initialization of SMI entry point.
> > Here is resulting debug output showing that RAM at 0x30000 is not affected
> > by SMM and only RAM in SMM adderss space is modified:
> >
> > init smm
> > smm_relocate: before relocaten
> > smm_relocate: RAM codeentry 0
> > smm_relocate: RAM  cpu.i64.smm_base  0
^^^ reads using 0x30000 base in non-SMM mode

> > smm_relocate: SMRAM  codeentry f000c831eac88c
> > smm_relocate: SMRAM  cpu.i64.smm_base  0
^^^ reads from SMRAM temporarily aliased at 0xa0000 in non-SMM mode 

> > handle_smi cmd=0 smbase=0x00030000
^^^ reads using 0x30000 base in SMM mode

> > smm_relocate: after relocaten
> > smm_relocate: RAM codeentry 0
> > smm_relocate: RAM  cpu.i64.smm_base  0
^^^ normal RAM at 0x30000 base hasn't been modified after SMM relocation
    without us taking care of saving/restoring it (2nd patch removes it altogether)

> > smm_relocate: SMRAM  codeentry f000c831eac88c
> > smm_relocate: SMRAM  cpu.i64.smm_base  a0000
^^^ but SMRAM has changed base to what out handler told it to
    (note we are reading it form non-SMM context only because we
     have an alias at a0000 which it there only for demo purposes)
> 
> 
> I most likely don't understand how this is supposed to work but aren't
> we here successfully reading SMRAM from non-SMM context, something we
> are not supposed to be able to do?

We are aren't reading SMRAM at 0x30000 base directly,
"RAM" marked log lines are non-SMM context reads using as base
  BUILD_SMM_INIT_ADDR       0x30000
and as you see, it isn't showing anything from SMRAM

For mgmt/demo purposes SMRAM (which is at 0x30000 in SMM address space)
is also aliased at
  BUILD_SMM_ADDR            0xa0000
into non-SMM address space to allow us to initialize SMM entry point
(log entries are marked as "SMRAM").

Aliased SMRAM also allows us to check that relocation worked
(i.e. smm_base was relocated from default "handle_smi cmd=0 smbase=0x00030000"
to a new one "smm_relocate: SMRAM  cpu.i64.smm_base  a0000").


It's similar to what we do with TSEG where QEMU steals RAM from
normal address space and puts MMIO region 'tseg_blackhole' over it
so non-SMM context reads 0xFF from TSEG window, while SMM context
accesses RAM hidden below tseg_blackhole.

These patches show that we can have normal usable RAM at 0x30000
which doesn't overlap with SMRAM at the same address and each can
be made accessible only from its own mode (no-SMM and SMM).
Preventing non-SMM mode from injecting attack on SMRAM via CPU
that hasn't been initialized yet once firmware locked down SMRAM.


> 
> 
> -boris
> 


