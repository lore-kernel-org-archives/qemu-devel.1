Received: from eggs.gnu.org ([2001:4830:134:3::10]:58104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fxYVC-0006w5-CG
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fxYVB-0006dy-00
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:09:50 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fxYVA-0006dX-JE
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:09:48 -0400
Received: by mail-yb1-xb44.google.com with SMTP id m123-v6so2733880ybm.0
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 07:09:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180905120248.unyh6q4msvyx4f43@kamzik.brq.redhat.com>
References: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
	<20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
	<CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
	<CAHmQWvBDjMeBpe9Puv+oRii3JrVULW_+AYJL9WV1tXT7F7ALfg@mail.gmail.com>
	<20180905120248.unyh6q4msvyx4f43@kamzik.brq.redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 5 Sep 2018 22:09:46 +0800
Message-ID: <CAHmQWvAD2Zaz94AxoAScBT8jL8WZqiTMdiuzKPxrZ_3Uvk5ihg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 5 September 2018 at 20:02, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Sep 05, 2018 at 06:08:57PM +0800, Hongbo Zhang wrote:
>> On 30 August 2018 at 21:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 30 August 2018 at 12:02, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> >> On Thu, Aug 30, 2018 at 09:39:33AM +0100, Peter Maydell wrote:
>> >>> On 30 August 2018 at 09:31, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> >>> > On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
>> >>> >> @Ard, @Leif, is there any possibility to remove all the DT nodes?
>> >>> >> On real hardware, how does UEFI find the memory size and CPU number?
>> >>> >
>> >>> > Usually by asking some form of SCP/PMU.
>> >>> > So until we have rock-solid multi-cpu-instance (making terms up here,
>> >>> > there may be a proper name already?) support upstream, we need to take
>> >>> > shortcuts.
>> >>>
>> >>> I would expect that you'd want a "faked-on-the-QEMU end" SCP
>> >>> communications endpoint to start with anyway. We have one of
>> >>> those for vexpress, for instance.
>> >>
>> >> Ah, I wasn't aware we did!
>> >>
>> >> In that case - sure, that is probably the more sensible solution.
>> >> Does it emulate SCMI?
>> >>
>> >
>> > The purpose of the SBSA/SBBR qemu machine is prototyping the
>> > interactions between rich firmware and the OS for things like RAS,
>> > secure variable storage for UEFI or capsule update.
>> >
>> > How exactly the firmware figures out how many CPUs and how much memory
>> > we are running with is out of scope for this, and so I don't think
>> > there is a need to build something from scratch here: DT will do just
>> > fine, given that both EDK2 and ARM-TF have working DT code for these
>> > things.
>>
>> Ard, we need to clarify which DT nodes should be kept in SBSA-ref QEMU.
>> I've researched and tested, there are 3 kinds of DT nodes in the
>> current 'virt' machine:
>>
>> a) CPU DT node, because it is dynamic according to input parameters,
>> and we don't want to get it by other way, so we agreed to keep it.
>
> I have a patch series on the list[*] (which I need to refresh) that
> would also add a generated cpu-map node. I think the SBSA-ref machine
> may be interested in testing more complex cpu topologies, but that won't
> be easy to do with ACPI boot guests unless the topology is hard coded.
> How will sbsa-ref know when it should use a hard coded cpu topology vs.
> a dynamic number of cpus in a flat topology?
>
If I understand you question correctly: for the cpu topology, firmware
always get CPU DT from QEMU (which is generated dynamically form
command parameter), so it is always dynamic, not hard coded in this
case.
(and then firmware may translate this DT and insert it into a whole
ACPI to load OS, it is up to the firmware developer)

And I even considered, do we really need dynamic CPU nodes for such
platform? memory size has to be dynamic, but it isn't in DT.

> [*] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01170.html
>
>> b) GIC, UART, Timer (and RTC?) nodes, these nodes are now used by
>> UEFI, if removed, UEFI needs a rework to not rely on them any longer.
>
> Will sbsa-ref support GICv2? If so, then timer and pmu DT nodes will
> need to have their irqflags fields modified depending on the number of
> configured CPUs.
>
No, I removed the GICv2 in next patch.

>> c) All the other devices nodes, such as GPIO, PCIE etc, currently the
>> UEFI doesn't need them, so UEFI can boot with them removed.
>>
>> How about b) and c)?
>> my idea is to keep a) only, remove b) and thus a UEFI modification
>> accordingly is to be done, c) can be removed freely.
>
> So UEFI would learn to augment static DTBs with QEMU generated
> DT nodes and/or other auxiliary info from QEMU passed to it
> through the "guest DT" (which is now looking more like a guest
> firmware configuration description)? Is it worth it? Why not
> just require the entire DTB to be provided by the user on the
> QEMU command line and completely ignore QEMU parameters like
> '-smp'?
>
UEFI loads OS by ACPI, not DT for this machine.
But UEFI has to handle DT too, becuase there is DT passing info from
ARMTF to UEFI, and this dynamic CPU DT as well.
I think every thing UEFI gets from DT should translated into ACPI,
again,it is my understaning now, it is up to firmware developers.

"entire DTB provided by the user on the QEMU command line", you mean
firmware can use it to load OS? it is not fine, some featurs such as
RAS, may still need ACPI, so ACPI is to be used to load OS on this
sbsa-ref machine.

> Thanks,
> drew
