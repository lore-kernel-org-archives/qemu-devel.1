Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA52AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F8921479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F8921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHTi-0007kQ-Rs
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hiHJH-0000Ts-Ot
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hiHJG-0005Sz-DR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hiHJF-0005Qb-Jv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:50:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7F1799DD9;
 Tue,  2 Jul 2019 11:50:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com
 [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E8D2E034;
 Tue,  2 Jul 2019 11:50:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0890516E05; Tue,  2 Jul 2019 13:50:38 +0200 (CEST)
Date: Tue, 2 Jul 2019 13:50:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190702115038.g5oidt4emilmynfe@sirius.home.kraxel.org>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zokyahg.fsf@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 11:50:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 12:52:27PM +0200, Sergio Lopez wrote:
> 
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> >   Hi,
> >
> >> > Can we get rid of the kernel command line hacking please?
> >> > The virtio-mmio devices should be discoverable somehow.
> >> >
> >> > Device tree (as suggested by paolo) would work.
> >> > Custom acpi device (simliar to fw_cfg) is another option.
> >> > I'd tend to pick acpi, I wouldn't be surprised if we'll
> >> > need acpi anyway at some point.
> >> >
> >> > Maybe even do both, then switch at runtime depending on -no-acpi
> >> > (simliar to arm/aarch64).
> >> 
> >> Microvm tries to do things in the cheapest possible way.
> >
> > But taking too many shortcuts tends to hurt in the long run.
> > It also cuts off useful use cases.
> 
> Sure, but the consideration about whether there are too many shortcuts,
> or just enough of them, is quite subjective. Microvm's code base is
> small enough to keep its quirks in check without a becoming a
> significant maintenance burden, and doesn't invalidate how other, more
> conventional machine types work.

Most projects starts small, but then tend to grow over time.
And likewise the maintenance burden tends to grow over time ...

> > Can look at the seabios side, but probably not before I'm back
> > from my summer vacation in august.  For seabios a simple & reliable
> > time source would be quite useful.  Direct kernel boot might be doable
> > without that, but as soon as any I/O (read from cloud image disk) is
> > involved a time source is needed.  Right now seabios uses the acpi
> > pm_timer.  tsc should work too if seabios can figure the frequency
> > without a calibration loop (invtsc should be enough).  Maybe seabios
> > needs kvmclock support ...
> 
> My main concern about supporting SeaBIOS, in addition to boot times, is
> having to support ACPI, which due to its complexity and size, is a clear
> candidate to be stripped out from a minimalistic QEMU build.

Not sure dropping apci will be much of a win.  I think the aml generator
hasn't any external dependencies (increasing load time due to shared
libs).  The guest interface is rather small too (only reading tables via
fw_cfg).  I'd also expect microvm doesn't need many tables due to the
small feature set (no numa, no pci, ...).

On the other hand acpi tables plus some minimal apci registers would
provide some useful features.  apci poweroff,  acpi power button,  apci
pm-timer.  You also could describe the virtio-mmio devices.

Having said that I think it should be possible to change seabios that
it'll work without acpi too.  It would still need some way to discover
virtio-mmio devices though if we want it load guest kernels from disk
images.

> > Is there any way to detect microvm from the guest?  pc/q35 can be
> > easily detected by looking at the pci host bridge.
> 
> One option would be using the fields MPC_OEM and MPC_PRODUCT_ID from the
> MP Table to give a hint to the guest.

Well, I mean for the firmware.  When booting with firmware all those
tables (mptable, e820, ...) should be created by the firmware not qemu.

It's not that critical though.  We probably want a separate seabios
build for microvm anyway, so a compile time option should work too.

> > Do you have boot time numbers for qboot vs. no-firmware boot?
> > Is the difference big enough that it makes sense to maintain both?
> 
> AFAIK, qboot can't boot a guest without both ACPI and PCI.

Should be fixable I guess ...

cheers,
  Gerd


