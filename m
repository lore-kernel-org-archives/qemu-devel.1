Received: from eggs.gnu.org ([2001:4830:134:3::10]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkOPO-0007d7-9Y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkOPN-0008Dh-Ee
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 01:40:54 -0400
References: <20170822214343.31385-1-f4bug@amsat.org>
	<20170823014025-mutt-send-email-mst@kernel.org>
	<6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <887ee497-5518-f6bc-56ec-2c2626cdf1f2@redhat.com>
Date: Wed, 23 Aug 2017 07:40:39 +0200
MIME-Version: 1.0
In-Reply-To: <6661274e-c797-1aac-14b9-43dcf4c2f336@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org

On 23.08.2017 02:10, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/22/2017 07:42 PM, Michael S. Tsirkin wrote:
>> On Tue, Aug 22, 2017 at 06:43:43PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> 9e047b982452 "piix4: add acpi pci hotplug support" introduced a new
>>> property
>>> 'use_acpi_pci_hotplug' for pc-1.7 and older machines.
>>> c24d5e0b91d1 "convert ACPI PCI hotplug to use hotplug-handler API"
>>> added the
>>> qbus hotplug handlers but forgot to check for the 'use_acpi_pci_hotpl=
ug'
>>> property.
>>>
>>> Check for use_acpi_pci_hotplug before calling
>>> acpi_pcihp_device_[un]plug_cb().
[...]
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Message-Id: <59a56959-ca12-ea75-33fa-ff07eba1b090@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Looks like this is a very old bug, isn't it?
>> Objections to merging this after the release?
>=20
> Yes, I'm also inclined to delay it so we can release 2.10, I tagged
> "2.10-rc4" since Thomas sent it as a bug within the 2.10 window so I'll
> let him decide if it is worth crying wolf :) It's very likely no-one bu=
t
> him used pre-pc-i440fx-1.7 the last 3 years, not even thinking about ho=
t
> plugging AHCI devices :D

I'm fine if this gets included in 2.11 - it's quite unlikely that a user
tries hot-plug ahci on such an old machine type, I think. But we maybe
should include this in the 2.10.1 stable release, so I'm putting
qemu-stable on CC now.

Anyway, your patch seems to fix the issue for me, thanks!

Tested-by: Thomas Huth <thuth@redhat.com>
