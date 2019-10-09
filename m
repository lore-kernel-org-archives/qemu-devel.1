Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB62C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992BF20B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992BF20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJV1-0006QI-Ct
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIJCq-0003UH-GC
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIJCo-00082F-VC
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIJCo-00081e-2p
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1EF0E3018761;
 Wed,  9 Oct 2019 21:09:09 +0000 (UTC)
Received: from localhost (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78DC55C22F;
 Wed,  9 Oct 2019 21:09:03 +0000 (UTC)
Date: Wed, 9 Oct 2019 18:09:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
Message-ID: <20191009210901.GB4084@habkost.net>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <4d47793c-7dfe-a8b6-8704-aca493689577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d47793c-7dfe-a8b6-8704-aca493689577@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 09 Oct 2019 21:09:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 08:58:30PM +0200, Laszlo Ersek wrote:
> Eduardo, Igor,
> 
> On 10/08/19 12:52, Laszlo Ersek wrote:
> > FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firmware,
> > due to historical reasons. That value is not useful to edk2, however. For
> > supporting VCPU hotplug, edk2 needs:
> > 
> > - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
> > 
> > - and the maximum foreseen CPU count (tracked in
> >   "MachineState.smp.max_cpus", but not currently exposed).
> > 
> > Add a new fw-cfg file to expose "max_cpus".
> > 
> > While at it, expose the rest of the topology too (die / core / thread
> > counts), because I expect that the VCPU hotplug feature for OVMF will
> > ultimately need those too, and the data size is not large.
> 
> In fact, it seems like OVMF will have to synthesize the new
> (hot-plugged) VCPU's *APIC-ID* from the following information sources:
> 
> - the topology information described above (die / core / thread counts), and
> 
> - the "modern" CPU hotplug interface (docs/specs/acpi_cpu_hotplug.txt).
> 
> Now, if I understand correctly, the "CPU selector" ([0x0-0x3]) specifies
> a CPU *index*. Therefore, in the hotplug SMI handler (running on one of
> the pre-existent CPUs), OVMF will have to translate the new CPU's
> selector (the new CPU's *index*) to its *APIC-ID*, based on the topology
> information (numbers of dies / cores / threads).

I thought we had already fixed all our guest interfaces to make
CPU indexes never visible to guests.  If it is still visible
somewhere, it's a bug we need to fix.

-- 
Eduardo

