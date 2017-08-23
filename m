Received: from eggs.gnu.org ([2001:4830:134:3::10]:44221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkR8N-00008t-0R
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkR8L-0004nb-W7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:35:31 -0400
Date: Wed, 23 Aug 2017 10:35:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170823103517.20792c71@nial.brq.redhat.com>
In-Reply-To: <9d8a8efa-8d32-57ea-d13f-65a7952448c3@redhat.com>
References: <20170822214343.31385-1-f4bug@amsat.org>
	<20170823014025-mutt-send-email-mst@kernel.org>
	<6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
	<887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
	<9d8a8efa-8d32-57ea-d13f-65a7952448c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10-rc4?] acpi: pcihp: fix
 use-after-free for machines previous pc-1.7 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On Wed, 23 Aug 2017 08:04:06 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 23.08.2017 07:40, Thomas Huth wrote:
> > On 23.08.2017 02:10, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >> On 08/22/2017 07:42 PM, Michael S. Tsirkin wrote: =20
> >>> On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daud=C3=A9=
 wrote: =20
> >>>> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new
> >>>> property
> >>>> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
> >>>> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API"
> >>>> added the
> >>>> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hotp=
lug'
> >>>> property.
> >>>>
> >>>> Check for use_acpi_pci_hotplug before calling
> >>>> acpi_pcihp_device_[un]plug_cb(). =20
> > [...] =20
> >>>> Reported-by: Thomas Huth <thuth@redhat.com>
> >>>> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =20
> >>>
> >>> Looks like this is a very old bug, isn't it?
> >>> Objections to merging this after the release? =20
> >>
> >> Yes, I'm also inclined to delay it so we can release 2.10, I tagged
> >> "2.10-rc4" since Thomas sent it as a bug within the 2.10 window so I'll
> >> let him decide if it is worth crying wolf :) It's very likely no-one b=
ut
> >> him used pre-pc-i440fx-1.7 the last 3 years, not even thinking about h=
ot
> >> plugging AHCI devices :D =20
> >=20
> > I'm fine if this gets included in 2.11 - it's quite unlikely that a user
> > tries hot-plug ahci on such an old machine type, I think. But we maybe
question is should be ahci device by hotpluggable at all?
