Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361F1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100F7205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100F7205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUE9-00064w-CD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtUDX-0005aI-D0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:55:51 -0400
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:56352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtUDV-0003NV-AC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:55:51 -0400
Received: from player758.ha.ovh.net (unknown [10.108.42.66])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0F0DB171434
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 12:55:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id 14E10143A6F62;
 Thu,  9 Jul 2020 10:55:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00190e9e7ff-806e-4b4e-b438-b457ba3ef13f,B4CBA90B3A6AD114FE081C226458375F80ABDB80)
 smtp.auth=groug@kaod.org
Date: Thu, 9 Jul 2020 12:55:25 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200709125525.29d28d6a@bahia.lan>
In-Reply-To: <69e8f708-4fa7-6240-1484-febae0246ae6@redhat.com>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
 <20200708213900.GD780932@habkost.net>
 <714621e2-4585-e6ee-5812-f3a45aa09267@redhat.com>
 <20200709115413.722d4feb@bahia.lan>
 <69e8f708-4fa7-6240-1484-febae0246ae6@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17847483851808020771
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.173.157; envelope-from=groug@kaod.org;
 helo=11.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:28:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 12:18:06 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 7/9/20 11:54 AM, Greg Kurz wrote:
> > On Thu, 9 Jul 2020 07:11:09 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >> On 7/8/20 11:39 PM, Eduardo Habkost wrote:
> >>> On Wed, Jul 08, 2020 at 06:45:57PM +0200, Philippe Mathieu-Daud=C3=83=
=C2=A9 wrote:
> >>>> On 7/8/20 5:25 PM, Eduardo Habkost wrote:
> >>>>> On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
> >>>>>> On Wed, 8 Jul 2020 at 12:12, David Gibson <david@gibson.dropbear.i=
d.au> wrote:
> >>>>>>> On Wed, Jul 08, 2020 at 10:38:29AM +0200, Philippe Mathieu-Daud=
=C3=83=C6=92=C3=82=C2=A9 wrote:
> >>>>>>>> Class boolean field certainly sounds better, but I am not sure t=
his
> >>>>>>>> is a property of the machine. Rather the arch? So move the field
> >>>>>>>> to CPUClass? Maybe not, let's discuss :)
> >>>>>>>
> >>>>>>> It is absolutely a property of the machine.  e.g. I don't think we
> >>>>>>> want this for powernv.  pseries is a bit of a special case since =
it is
> >>>>>>> explicitly a paravirt platform.  But even for emulated hardware, =
the
> >>>>>>> board can absolutely strap things so that cpus do or don't start
> >>>>>>> immediately.
> >>>>>>
> >>>>>> It's a property of the individual CPU, I think. One common setup
> >>>>>> for Arm systems is that the primary CPU starts powered up but
> >>>>>> the secondaries all start powered down.
> >>>>>
> >>>>> Both statements can be true.  It can be a property of the
> >>>>> individual CPU (although I'm not convinced it has to), but it
> >>>>> still needs to be controlled by the machine.
> >>>>
> >>>> From what said Peter, I understand this is a property of the
> >>>> chipset. Chipsets are modelled unevenly.
> >>>>
> >>>> IIUC QEMU started with single-core CPUs.
> >>>> CPUState had same meaning for 'core' or 'cpu', 1-1 mapping.
> >>>>
> >>>> Then multicore CPUs could be easily modelled using multiple
> >>>> single-core CPUs, usually created in the machine code.
> >>>>
> >>>> Then we moved to SoC models, creating the cores in the SoC.
> >>>> Some SoCs have array of cores, eventually heterogeneous
> >>>> (see the ZynqMP). We have containers of CPUState.
> >>>>
> >>>> On an ARM-based SoC, you might have the first core started
> >>>> (as said Peter) or not.
> >>>>
> >>>> BCM2836 / BCM2837 and ZynqMP start will all ARM cores off.
> >>>> On the BCM chipsets, a DSP core will boot the ARM cores.
> >>>> On the ZynqMP, a MicroBlaze core boots them.
> >>>> As QEMU doesn't models heterogeneous architectures, we start
> >>>> modelling after the unmodelled cores booted us, so either one
> >>>> or all cores on.
> >>>>
> >>>> In this case, we narrowed down the 'start-powered-off' field
> >>>> to the SoC, which happens to be how ARM SoCs are modelled.
> >>>
> >>> I was not aware of the start-powered-off property.  If we make it
> >>> generic, we can just let spapr use it.
> >>>
> >>>>
> >>>>
> >>>> Chipsets providing a JTAG interface can have a SRST signal,
> >>>> the "system reset". When a JTAG probe is attached, it can
> >>>> keeps the whole chipset in a reset state. This is equivalent
> >>>> to QEMU '-S' mode (single step mode).
> >>>>
> >>>>
> >>>> I don't know about pseries hardware, but if this is 'explicit
> >>>> to paravirt platform', then I expect this to be the same with
> >>>> other accelerators/architectures.
> >>>>
> >>>> If paravirtualized -> cores start off by default. Let the
> >>>> hypervisor start them. So still a property of the CPUState
> >>>> depending on the accelerator used?
> >>>
> >>> I don't understand this part.  Why would this depend on the
> >>> accelerator?
> >>
> >> Because starting a virtualized machine with all cores powered-off
> >> with TCG accelerator should at least emit a warning? Or change
> >> the behavior and start them powered-on? This is machine-specific
> >> although.
> >>
> >=20
> > FYI, PAPR requires all vCPUs to be "stopped" by default. It is up to the
> > guest to start them explicitly through an RTAS call. The hypervisor is
> > only responsible to start a single vCPU (see spapr_cpu_set_entry_state()
> > called from spapr_machine_reset()) to be able to boot the guest.
> >=20
> > So I'm not sure to see how that would depend on the accelerator...
>=20
> $ qemu-system-ppc64 -M pseries-5.0,accel=3Dtcg -d in_asm
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=3Don
> ----------------
> IN:
> 0x00000100:  48003f00  b        0x4000
>=20
> ----------------
> IN:
> 0x00004000:  7c7f1b78  mr       r31, r3
> 0x00004004:  7d6000a6  mfmsr    r11
> 0x00004008:  3980a000  li       r12, 0xa000
> 0x0000400c:  798c83c6  sldi     r12, r12, 0x30
> 0x00004010:  7d6b6378  or       r11, r11, r12
> 0x00004014:  7d600164  mtmsrd   r11
> ...
>=20
> The vCPU doesn't seem stopped to me...
>=20
> Am I missing something?
>=20

Yeah this is the boot vCPU which is required to be started
by the platform as explained above, but if you had more
vCPUs the other ones would be stopped until the guest OS
asks us to start them.

