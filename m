Received: from eggs.gnu.org ([2001:4830:134:3::10]:50506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiHaW-0007ly-3M
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fiHaT-0005sJ-3j
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 07:04:12 -0400
Date: Wed, 25 Jul 2018 13:03:58 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180725110358.cvpeh367kzj33sa2@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAKv+Gu_RHsed0KAH8njKB8UPvbUDeoTZ5sP76f_br6azisZzSQ@mail.gmail.com>
	<CAHmQWvCqKqQXnXxOUgi=kLTyE5BhV2NxqaKzvPp63HX02V=X2g@mail.gmail.com>
	<CAKv+Gu_eFjS_UvOuEKhbsWr34o3Jqd4h2duJ-gG1ofsFbwkGbQ@mail.gmail.com>
	<CAHmQWvC8_J4i32UZzdHqJ4w3EdEAHmWGdgqrvGwEA7uo0kvk9A@mail.gmail.com>
	<CAKv+Gu-B4o7dwZPOix2MkECJia6M6Q+zBMw8XVdw49kFYW6J+w@mail.gmail.com>
	<20180725094037.uzz4ycen4qja4q4a@kamzik.brq.redhat.com>
	<CAHmQWvBZLpmjozVU=y4Fz_vr_+tMW_nmtidKDzApHSccRSgZxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHmQWvBZLpmjozVU=y4Fz_vr_+tMW_nmtidKDzApHSccRSgZxw@mail.gmail.com>
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
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 25, 2018 at 06:33:01PM +0800, Hongbo Zhang wrote:
> On 25 July 2018 at 17:40, Andrew Jones <drjones@redhat.com> wrote:
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
> Even command line or readconfig can add AHCI on platform bus, I think
> it can only create such devices, but no DT or ACPI nodes, which are
> mandatory.

You have to write the code for that, similar to what this patch does,
but plus the machine-done notifier support to do it at platform-bus
attach time.

Thanks,
drew
