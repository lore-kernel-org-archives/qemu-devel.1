Received: from eggs.gnu.org ([2001:4830:134:3::10]:47163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkVXS-00050Q-6d
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkVXR-0005Zk-Aq
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:17:42 -0400
Date: Wed, 23 Aug 2017 16:17:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170823161718-mutt-send-email-mst@kernel.org>
References: <20170822214343.31385-1-f4bug@amsat.org>
	<20170823014025-mutt-send-email-mst@kernel.org>
	<6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
	<887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

On Wed, Aug 23, 2017 at 07:40:39AM +0200, Thomas Huth wrote:
> On 23.08.2017 02:10, Philippe Mathieu-Daud=E9 wrote:
> > On 08/22/2017 07:42 PM, Michael S. Tsirkin wrote:
> >> On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daud=E9 w=
rote:
> >>> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new
> >>> property
> >>> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
> >>> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API"
> >>> added the
> >>> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hot=
plug'
> >>> property.
> >>>
> >>> Check for use_acpi_pci_hotplug before calling
> >>> acpi_pcihp_device_[un]plug_cb().
> [...]
> >>> Reported-by: Thomas Huth <thuth@redhat.com>
> >>> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
> >>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >>
> >> Looks like this is a very old bug, isn't it?
> >> Objections to merging this after the release?
> >=20
> > Yes, I'm also inclined to delay it so we can release 2.10, I tagged
> > "2.10-rc4" since Thomas sent it as a bug within the 2.10 window so I'=
ll
> > let him decide if it is worth crying wolf :) It's very likely no-one =
but
> > him used pre-pc-i440fx-1.7 the last 3 years, not even thinking about =
hot
> > plugging AHCI devices :D
>=20
> I'm fine if this gets included in 2.11 - it's quite unlikely that a use=
r
> tries hot-plug ahci on such an old machine type, I think. But we maybe
> should include this in the 2.10.1 stable release, so I'm putting
> qemu-stable on CC now.
>=20
> Anyway, your patch seems to fix the issue for me, thanks!
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>

ok, pls remember to repost or ping after the release.
