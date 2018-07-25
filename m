Received: from eggs.gnu.org ([2001:4830:134:3::10]:40482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiGkc-0001l6-36
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiGkY-0001CZ-LX
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:10:33 -0400
Date: Wed, 25 Jul 2018 12:10:19 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180725101019.7lrwbgx5xquetjuw@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAKv+Gu_RHsed0KAH8njKB8UPvbUDeoTZ5sP76f_br6azisZzSQ@mail.gmail.com>
	<CAHmQWvCqKqQXnXxOUgi=kLTyE5BhV2NxqaKzvPp63HX02V=X2g@mail.gmail.com>
	<CAKv+Gu_eFjS_UvOuEKhbsWr34o3Jqd4h2duJ-gG1ofsFbwkGbQ@mail.gmail.com>
	<CAHmQWvC8_J4i32UZzdHqJ4w3EdEAHmWGdgqrvGwEA7uo0kvk9A@mail.gmail.com>
	<CAKv+Gu-B4o7dwZPOix2MkECJia6M6Q+zBMw8XVdw49kFYW6J+w@mail.gmail.com>
	<20180725094037.uzz4ycen4qja4q4a@kamzik.brq.redhat.com>
	<CAKv+Gu9VnKkXC8r9BpMPjXfjhsPVRaAmRaOYM8=hPyDCgXMQWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9VnKkXC8r9BpMPjXfjhsPVRaAmRaOYM8=hPyDCgXMQWQ@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 25, 2018 at 11:47:39AM +0200, Ard Biesheuvel wrote:
> On 25 July 2018 at 11:40, Andrew Jones <drjones@redhat.com> wrote:
> > On Wed, Jul 25, 2018 at 11:20:03AM +0200, Ard Biesheuvel wrote:
> >> On 25 July 2018 at 11:17, Hongbo Zhang <hongbo.zhang@linaro.org> wro=
te:
> >> > On 25 July 2018 at 17:13, Ard Biesheuvel <ard.biesheuvel@linaro.or=
g> wrote:
> >> >> On 25 July 2018 at 11:09, Hongbo Zhang <hongbo.zhang@linaro.org> =
wrote:
> >> >>> On 25 July 2018 at 17:01, Ard Biesheuvel <ard.biesheuvel@linaro.=
org> wrote:
> >> >>>> On 25 July 2018 at 10:48, Daniel P. Berrang=E9 <berrange@redhat=
.com> wrote:
> >> >>>>> On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
> >> >>>>>> For the Aarch64, there is one machine 'virt', it is primarily=
 meant to
> >> >>>>>> run on KVM and execute virtualization workloads, but we need =
an
> >> >>>>>> environment as faithful as possible to physical hardware, for=
 supporting
> >> >>>>>> firmware and OS development for pysical Aarch64 machines.
> >> >>>>>>
> >> >>>>>> This patch introduces new machine type 'Enterprise' with main=
 features:
> >> >>>>>
> >> >>>>> The 'enterprise' name is really awful - this is essentially a =
marketing
> >> >>>>> term completely devoid of any useful meaning.
> >> >>>>>
> >> >>>>> You had previously called this "sbsa" which IIUC was related t=
o a real
> >> >>>>> world hardware specification that it was based on. IOW, I thin=
k this old
> >> >>>>> name was preferrable to calling it "enterprise".
> >> >>>>>
> >> >>>>
> >> >>>> I couldn't agree more. However, IIUC this change was made at th=
e
> >> >>>> request of one of the reviewers, although I wasn't part of the
> >> >>>> discussion at that point, so I'm not sure who it was.
> >> >>>>
> >> >>>> Hongbo, could you please share a link to that discussion?
> >> >>>>
> >> >>>> Thanks,
> >> >>>> Ard.
> >> >>>>
> >> >>>
> >> >>> V1 discussion here:
> >> >>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg545775.htm=
l
> >> >>>
> >> >>
> >> >> So who asked for the sbsa -> enterprise change?
> >> >
> >> > Actually nobody, but it was argued that sbsa does not require ehci=
 and
> >> > ahci etc, then we should find a name fitting for this platform bet=
ter.
> >>
> >> That doesn't make sense to me. The SBSA describes a minimal
> >> configuration, it does not limit what peripherals may be attached to
> >> the core system.
> >>
> >
> > Hi Ard,
> >
> > I think that a machine model named 'sbsa' should provide all SBSA req=
uired
> > hardware, and nothing else, while providing a means to easily extend =
the
> > machine beyond that in any way the user likes. The user can easily ad=
d
> > devices with the command line and/or by using -readconfig to build a
> > "typical" machine. Note, it should even be possible to add, e.g. an A=
CHI
> > controller, to the memory map using the platform bus, if that's prefe=
rred
> > over PCIe.
> >
>=20
> The purpose of the SBSA machine is not to provide a minimal
> configuration. It is intended to exercise all the moving parts one
> might find in a server firmware/OS stack, including pieces that are
> not usually found on x86 machines, such as DRAM starting above 4 GB
> and SATA/USB controllers that are not PCIe based.

To me, this purpose actually requires that the base config be minimal.
How else can you have the flexibility to build a wide range of
configurations for testing?

>=20
> If we start layering the usual components on top, it is highly likely
> that checking the EHCI box gives you a PCI based USB2 controller,
> partially defeating the purpose of the exercise.
>

As I said, it should be possible to put these controllers on the system
bus, even if they're specified on the command line. This would be done
using the platform-bus framework. Naturally, providing platform-bus
support for devices/controllers that need it will take some machine-done
notifier code, etc., so this machine model patch series will get more
complex.

Thanks,
drew
