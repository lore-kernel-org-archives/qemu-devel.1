Received: from eggs.gnu.org ([2001:4830:134:3::10]:34459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiGOW-0003Y0-D6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiGOT-0004eF-EZ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:47:44 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:33546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiGOT-0004cy-8C
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:47:41 -0400
Received: by mail-io0-x243.google.com with SMTP id z20-v6so5822683iol.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:47:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725094037.uzz4ycen4qja4q4a@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAKv+Gu_RHsed0KAH8njKB8UPvbUDeoTZ5sP76f_br6azisZzSQ@mail.gmail.com>
	<CAHmQWvCqKqQXnXxOUgi=kLTyE5BhV2NxqaKzvPp63HX02V=X2g@mail.gmail.com>
	<CAKv+Gu_eFjS_UvOuEKhbsWr34o3Jqd4h2duJ-gG1ofsFbwkGbQ@mail.gmail.com>
	<CAHmQWvC8_J4i32UZzdHqJ4w3EdEAHmWGdgqrvGwEA7uo0kvk9A@mail.gmail.com>
	<CAKv+Gu-B4o7dwZPOix2MkECJia6M6Q+zBMw8XVdw49kFYW6J+w@mail.gmail.com>
	<20180725094037.uzz4ycen4qja4q4a@kamzik.brq.redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Jul 2018 11:47:39 +0200
Message-ID: <CAKv+Gu9VnKkXC8r9BpMPjXfjhsPVRaAmRaOYM8=hPyDCgXMQWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 25 July 2018 at 11:40, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Jul 25, 2018 at 11:20:03AM +0200, Ard Biesheuvel wrote:
>> On 25 July 2018 at 11:17, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> > On 25 July 2018 at 17:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> w=
rote:
>> >> On 25 July 2018 at 11:09, Hongbo Zhang <hongbo.zhang@linaro.org> wrot=
e:
>> >>> On 25 July 2018 at 17:01, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
>> >>>> On 25 July 2018 at 10:48, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>> >>>>> On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
>> >>>>>> For the Aarch64, there is one machine 'virt', it is primarily mea=
nt to
>> >>>>>> run on KVM and execute virtualization workloads, but we need an
>> >>>>>> environment as faithful as possible to physical hardware, for sup=
porting
>> >>>>>> firmware and OS development for pysical Aarch64 machines.
>> >>>>>>
>> >>>>>> This patch introduces new machine type 'Enterprise' with main fea=
tures:
>> >>>>>
>> >>>>> The 'enterprise' name is really awful - this is essentially a mark=
eting
>> >>>>> term completely devoid of any useful meaning.
>> >>>>>
>> >>>>> You had previously called this "sbsa" which IIUC was related to a =
real
>> >>>>> world hardware specification that it was based on. IOW, I think th=
is old
>> >>>>> name was preferrable to calling it "enterprise".
>> >>>>>
>> >>>>
>> >>>> I couldn't agree more. However, IIUC this change was made at the
>> >>>> request of one of the reviewers, although I wasn't part of the
>> >>>> discussion at that point, so I'm not sure who it was.
>> >>>>
>> >>>> Hongbo, could you please share a link to that discussion?
>> >>>>
>> >>>> Thanks,
>> >>>> Ard.
>> >>>>
>> >>>
>> >>> V1 discussion here:
>> >>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg545775.html
>> >>>
>> >>
>> >> So who asked for the sbsa -> enterprise change?
>> >
>> > Actually nobody, but it was argued that sbsa does not require ehci and
>> > ahci etc, then we should find a name fitting for this platform better.
>>
>> That doesn't make sense to me. The SBSA describes a minimal
>> configuration, it does not limit what peripherals may be attached to
>> the core system.
>>
>
> Hi Ard,
>
> I think that a machine model named 'sbsa' should provide all SBSA require=
d
> hardware, and nothing else, while providing a means to easily extend the
> machine beyond that in any way the user likes. The user can easily add
> devices with the command line and/or by using -readconfig to build a
> "typical" machine. Note, it should even be possible to add, e.g. an ACHI
> controller, to the memory map using the platform bus, if that's preferred
> over PCIe.
>

The purpose of the SBSA machine is not to provide a minimal
configuration. It is intended to exercise all the moving parts one
might find in a server firmware/OS stack, including pieces that are
not usually found on x86 machines, such as DRAM starting above 4 GB
and SATA/USB controllers that are not PCIe based.

If we start layering the usual components on top, it is highly likely
that checking the EHCI box gives you a PCI based USB2 controller,
partially defeating the purpose of the exercise.

--=20
Ard.
