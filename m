Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5663C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00B820673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hM05rltD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2jg-0006P7-Rd
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hL2i2-0005IW-Ly
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hL2i0-0002Ir-Vf
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:36:26 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:52236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hL2hw-0002EQ-Tk; Mon, 29 Apr 2019 05:36:21 -0400
Received: from [172.16.11.119] (unknown [172.16.11.119])
	by beetle.greensocs.com (Postfix) with ESMTPSA id A34CE96EF5;
	Mon, 29 Apr 2019 09:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1556530576;
	h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=6gAS3z2legQvPM0Yx3NPLWicOne8yXXV0O4yESMftqk=;
	b=hM05rltDUjzrC0e0WxHJ1P1lx+drlmkzCBaJ51fgv/HgS3XN6m6Mg0CuvnlZvy4qoqAxOD
	LQTBy4DhZGCkoX6lY3N8M3xcjjqNGu359hmox2I5AyNiW5sn1QfDt+TIL469dRkDT6bOej
	dlBb+HmdvaOcXVHXjHZq5oZpydILMbE=
To: qemu-devel@nongnu.org
References: <cover.1553510737.git.damien.hedde@greensocs.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <bf7dcbc7-5dc6-6269-87e9-44f027946cd9@greensocs.com>
Date: Mon, 29 Apr 2019 11:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <cover.1553510737.git.damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1556530576;
	h=from:from:sender:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=6gAS3z2legQvPM0Yx3NPLWicOne8yXXV0O4yESMftqk=;
	b=EjC8WjUJiBTRf35LXOH9eUPAOnPf9r3zIykBENsv+dZCSRwQ4VzIjTM+Be/EnEdTEFqd38
	/CgSOyQbTq+nSfuojQwWW3KgPzx0xon3NXt836RdeXrkOD8kjLpYMRGsSnQAff5pV7PwtL
	thXeOWt1xEGZm/4iwAvWCkXzcQz0OKk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1556530576; a=rsa-sha256; cv=none;
	b=FfJhbFlGwBKMmww58HVHRrT1QW6JeXqgi/jECpSK1xUk/+umU8IGpX+xoexr0R9qWcyYWu
	WlhZSn+guSqMf5gMHM48D3ooLvBp77ybhJ91pQHHTgNLZT0XIK677200hR47aad7V5H331
	JTB33DJra6KZeOr493wDmjrwZvMCeCk=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [RFC 00/17] multi-phase reset mechanism
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	mark.burton@greensocs.com, qemu-arm@nongnu.org,
	alistair.francis@wdc.com, pbonzini@redhat.com,
	marcandre.lureau@redhat.com, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429093614.DTUaO5tj4q-f6xLn8a98GNgXLZTk4Bqd42NGpahYzp8@z>

Hi All,

Any comment about this ?

Thanks,
Damien

On 3/25/19 12:01 PM, Damien Hedde wrote:
> Hi all,
> 
> This series is a proposal to implement the multi-phase reset we've discussed
> here (https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00310.html) and
> more recently there
> (https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00081.html).
> 
> To summarize, we need a multi-phase reset to allow for a more complex
> initialization of a platform. In particular we need to "propagate" a clock
> tree, but we have to ensure that every device is initialized first.
> 
> To solve this problem, the following 3-phases reset mechanism is proposed (I've
> removed the 4th given our last discussion).
> 
> #DESCRIPTION
> 
> INIT PHASE: Reset the object internal state, put a resetting flag and do the
>     same for the reset subtree. No side effect on other devices to guarantee
>     that, in a reset domain, everything get initialized first. This corresponds
>     mostly to what is currently done in the device/bus reset method.
> 
> HOLD PHASE: This phase allows to control a reset with a I/O. When a I/O control
>     a reset procedure based on the I/O level (not edge), we may need to assert
>     the reset, wait some time, and finally de-assert the reset. The consequence
>     is that such a device can stay in a "resetting state" and may need to show
>     this state to other devices through its outputs. For example, a clock
>     controller will typically shutdown its clocks when it is in resetting state.
> 
> EXIT PHASE (previously named 'release'): This phase sets outputs to state after
>      reset. For a clock controller it starts the clocks. It also clears the
>      "resetting" flag. A device should not react to inputs until this flag has
>      been cleared. During this phase, outputs are propagated in the reset domain
>      (and outside the reset domain).
> 
> To implement this, this series add a Resettable interface containing 3 methods:
> one for each phase. The init phase's method takes a boolean argument allowing to
> distinguish cold and warm resets.
> 
> In this series, Device and Bus implement the interface. A vmstate description
> subsection is added to allow migration of reset related state for device.
> 3 methods (one per phase) are also added in Device's class. They correspond to
> the local part (see the code example below) of the reset. They avoid device
> specialization to have to handle the sub-domain part and "resetting" state.
> 
> Functions to add gpio control over the reset are added. It is possible to add
> an active low/high reset pin to control the warm reset and an active low/high
> power gating pin to control the cold reset.
> 
> The bus/device reset tree is converted to this 3-phases mechanism. I also
> added a new ResetDomain object which is just a Resettable container. It is
> used to have a global "system reset domain" to handle main 3-phases reset and
> replace the current single-phase-reset handler mechanism.
> 
> As an example, in the xilinx_zynq machine, I've converted the slcr (the resets
> and clocks controller device) and the uart peripheral to this 3-phases reset
> mechanism. Gpio are added between the devices to transmit reset control from
> the slcr to the uarts.
> 
> All changes have been made so that existing reset behavior is not modified.
> 
> #INTERFACE CHOICE
> 
> To be honest, I have some doubt about the interface. I've kept it minimal and
> the consequence is implementation is complex (and kind of duplicated in every
> base implementation like Device or Bus). One of the problem is the `resetting`
> flag, which in practical must be a counter to handle reset "reentrance".
> Indeed nothing forbids to reset some device that is already held in "resetting"
> state by some other means. As an example, in the zynq machine, there can be 
> a global/system reset while an uart is reset by the slcr. It it also possible
> to cold and warm resets triggered concurrently.
> 
> The Resettable methods implementation have to looks this (methods are called
> with iothread locked):
> ```
> void init_phase(Device *dev, bool cold)
> {
>     /* call sub-resettable init phases */
> 
>     dev->resetting += 1;
>     /* do local init phase (eg: state reset) */
> }
> void hold_phase(Device *dev)
> {
>     /* call sub-resettable hold phases */
> 
>     /* do local hold phase (eg: set some I/O level) */
> }
> void exit_phase(Device *dev)
> {
>     /* call sub-resettable exit phases (independently of resetting value since,
>        every resettable have its own resetting counter) */
>    
>     dev->resetting -= 1;
>     if (dev->resetting == 0) {
>         /* do local exit phase (eg: set some I/O level) only if the device is
>            really leaving the resetting state */
>     }
> }
> ```
> Since I don't think specialization should care about sub-resettable and the
> resetting counter, I've added the local init/hold/exit phases as DeviceClass
> methods.
> Otherwise, I see two other solutions:
> + keep the interface as it is
> + add some state knowledge in the interface (with some kind of get_state method)
>   so that resetting counter and some kind of sub-resettable list are handled in
>   the common code in the interface. The 3 methods will then handle only the local
>   actions.
> + have 6 methods in the interface, one for the local actions, one for the
>   sub-resettable so that sub-resettable is not handled in the common code. And we
>   need also a get_resetting method to access/update the counter.
> 
> #DEVICE RESET CHOICE
> 
> The Device is a special case, it has 2 reset entry point: `qdev_reset_all` and
> `device_reset`. The latter doing a device reset only, while the former also
> reset all buses hierarchy under the device.
> 
> I choose the put the sub-buses into the device reset domain, so that the
> behavior of the resettable interface on Device is the same as qdev_reset_all.
> I don't know if `device_reset` has some real meaning (resetting only the
> Device). It is not often used and I think every time it is used there is no
> sub-buses so the behavior is the same for both functions.
> 
> If I am mistaken about putting buses into device reset domain, it is possible
> to make a special bus-hierarchy-reset-domain for every Device/Bus that differs
> from the Resettable interface on Device/Bus.
> 
> # SYSBUS SUPPORT
> 
> Regarding the sysbus support Edgar mentioned in the prevous discussion: In this
> series, there is no support in sysbus base class for disabling memory regions.
> Having each sysbus device specialization, in every memory region handler, to
> check if `resetting` is set or not is not user-friendly. But for we can't 
> modify memory region `enabled` flags since devices may already set/unset them.
> Maybe we could have some kind of super-switch to disable all memory regions in
> a sysbus device but I don't know how this could be done.
> 
> The series is organised as follow:
> Patches 1 and 2 adds Resettable interface and ResetDomain object.
> Patches 3 to 7 converts Device and Bus to Resettable.
> Patches 8 to 12 handles the global system reset domain
> Patches 13 to 17 do the zynq implementation (patch 13 is an already-reviewed
> patch from the clock api patch series)
> 
> Thank you for your feedback,
> Damien
> 
> Damien Hedde (17):
>   Create Resettable QOM interface
>   Create the ResetDomain QOM object
>   make Device and Bus Resettable
>   Add local reset methods in Device class
>   add vmstate description for device reset state
>   Add function to control reset with gpio inputs
>   convert qdev/bus_reset_all to Resettable
>   Add a global ResetDomain object for system emulation
>   global ResetDomain support for legacy reset handlers
>   Delete the system ResetDomain at the end of emulation
>   Put orphan buses in system reset domain
>   Put default sysbus in system reset domain
>   hw/misc/zynq_slcr: use standard register definition
>   convert cadence_uart to 3-phases reset
>   Convert zynq's slcr to 3-phases reset
>   Add uart reset support in zynq_slcr
>   Connect the uart reset gpios in the zynq platform
> 
>  hw/arm/xilinx_zynq.c           |  14 +-
>  hw/char/cadence_uart.c         |  48 ++-
>  hw/core/Makefile.objs          |   3 +
>  hw/core/bus.c                  |  64 +++-
>  hw/core/qdev-vmstate.c         |  27 ++
>  hw/core/qdev.c                 | 166 ++++++++++-
>  hw/core/reset-domain.c         | 121 ++++++++
>  hw/core/reset.c                | 149 +++++++++-
>  hw/core/resettable.c           |  69 +++++
>  hw/misc/zynq_slcr.c            | 515 ++++++++++++++++++---------------
>  include/hw/char/cadence_uart.h |  10 +-
>  include/hw/qdev-core.h         |  97 +++++++
>  include/hw/reset-domain.h      |  49 ++++
>  include/hw/resettable.h        |  83 ++++++
>  include/sysemu/reset.h         |  47 +++
>  vl.c                           |   3 +-
>  16 files changed, 1195 insertions(+), 270 deletions(-)
>  create mode 100644 hw/core/qdev-vmstate.c
>  create mode 100644 hw/core/reset-domain.c
>  create mode 100644 hw/core/resettable.c
>  create mode 100644 include/hw/reset-domain.h
>  create mode 100644 include/hw/resettable.h
> 

