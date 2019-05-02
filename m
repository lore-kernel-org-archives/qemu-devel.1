Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CACC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB49920B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB49920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDan-0006tn-OB
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:25:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDZc-0005yS-Ou
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDZb-0008Iq-FN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hMDZW-00084A-Ui; Thu, 02 May 2019 11:24:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC33130917AA;
	Thu,  2 May 2019 15:24:29 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61CF517A67;
	Thu,  2 May 2019 15:24:24 +0000 (UTC)
Date: Thu, 2 May 2019 17:24:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20190502172418.2b7d6d84@Igors-MacBook-Pro>
In-Reply-To: <CAKv+Gu9yw6s=N+LkKmQ+0d5ZQBJ+5tE0_cKtZAYHh_cTXnjyCQ@mail.gmail.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<CAKv+Gu_guvAydmCZDeVnj0NR_WyTHeCmwh4tK9WKUBY6cy-4Pg@mail.gmail.com>
	<5FC3163CFD30C246ABAA99954A238FA83F137685@lhreml524-mbs.china.huawei.com>
	<CAKv+Gu9yw6s=N+LkKmQ+0d5ZQBJ+5tE0_cKtZAYHh_cTXnjyCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 02 May 2019 15:24:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
 Device Support
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>,
	Auger Eric <eric.auger@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Linuxarm <linuxarm@huawei.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	qemu-arm <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502152418.lR0zao2Vzlx4O5IP4kZpJer9TuR-Nzo1lLMpzrmZdqM@z>

On Thu, 2 May 2019 09:22:35 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On Wed, 1 May 2019 at 13:25, Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> > Hi Ard,
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> > > Sent: 01 May 2019 12:10
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: QEMU Developers <qemu-devel@nongnu.org>; qemu-arm
> > > <qemu-arm@nongnu.org>; Auger Eric <eric.auger@redhat.com>; Igor
> > > Mammedov <imammedo@redhat.com>; Peter Maydell
> > > <peter.maydell@linaro.org>; shannon.zhaosl@gmail.com;
> > > sameo@linux.intel.com; sebastien.boeuf@intel.com; xuwei (O)
> > > <xuwei5@huawei.com>; Laszlo Ersek <lersek@redhat.com>; Linuxarm
> > > <linuxarm@huawei.com>
> > > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
> > >
> > > On Tue, 9 Apr 2019 at 12:31, Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > > From: Samuel Ortiz <sameo@linux.intel.com>
> > > >
> > > > The ACPI Generic Event Device (GED) is a hardware-reduced specific
> > > > device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> > > > including the hotplug ones.This patch generates the AML code that
> > > > defines GEDs.
> > > >
> > > > Platforms need to specify their own GedEvent array to describe what
> > > > kind of events they want to support through GED.  Also this uses a
> > > > a single interrupt for the  GED device, relying on IO memory region
> > > > to communicate the type of device affected by the interrupt. This
> > > > way, we can support up to 32 events with a unique interrupt.
> > > >
> > > > This supports only memory hotplug for now.
> > > >
> > > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > >
> > > Apologies if this question has been raised before, but do we really
> > > need a separate device for this? We already handle the power button
> > > via _AEI/_Exx on the GPIO device, and I think we should be able to add
> > > additional events using that interface, rather than have two event
> > > signalling methods/devices on the same platform.
> >
> > Right. The initial RFC was based on GPIO device[1] and later Igor commented
> > here[2] that,
> >
> > " ARM boards were first to use ACPI hw-reduced profile so they picked up
> > available back then GPIO based way to deliver hotplug event, later spec
> > introduced Generic Event Device for that means to use with hw-reduced
> > profile, which NEMU implemented[1], so I'd use that rather than ad-hoc
> > GPIO mapping. I'd guess it will more compatible with various contemporary
> > guests and we could reuse the same code for both x86/arm virt boards) "
> >
> 
> On mach-virt, we already use the GPIO controller for the ACPI event
> involving the power button, so by aligning with virt-x86, we end up in
> the opposite situation for mach-virt.
> 
> The problem with the GED device is that it only supports GSI
> interrupts, while the GPIO device supports arbitrary interrupts (such
> as GPIO signalled ones). This means that mach-virt will be stuck with
> having two different methods of signalling ACPI events, unless we
> rewire the power button not to use a GPIO interrupt but use a GSI
> directly.

we can rewire power button then.


> In general, I think the ACPI event delivery mechanism doesn't really
> have to be aligned: the ACPI event is ultimately converted into a AML
> notification to the right device, and how we end up there can remain
> platform specific.

Reasoning for using GED is to reduce code duplication with x86
and not creating zoo of different approached (if it could be avoided).

