Received: from eggs.gnu.org ([2001:4830:134:3::10]:41948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNEj-0003wk-Ma
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNEg-0007cc-H9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:05:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCNEg-0007cH-Ag
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:05:30 -0500
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-7-f4bug@amsat.org>
	<20171108090900.GF12670@redhat.com>
	<20171108094421.ta2wumq36gux3m5s@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <470e67ec-fe1e-2692-c14c-5c843a9d3053@redhat.com>
Date: Wed, 8 Nov 2017 11:05:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171108094421.ta2wumq36gux3m5s@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/i386: deprecate the "isapc"
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 08.11.2017 10:44, Gerd Hoffmann wrote:
> On Wed, Nov 08, 2017 at 09:09:00AM +0000, Daniel P. Berrange wrote:
>> On Tue, Nov 07, 2017 at 11:28:28PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Deprecated since 2.9.0, guests should be able to use "pc" instead.
>>
>> Isn't isapc important to allow QEMU to old operating systems that
>> predate the PCI era.
>=20
> They should work fine.  The early pci chipsets like the piix4 have
> built-in backward compatibility.  The IDE controller can be driven by
> simply accessing the isa ide ports.  Likewise vga.  You can plug in ne2=
k
> (we have both isa and pci variants) for ethernet and sb16 (isa too) for
> sound.
>=20
> That should make guests which don't know anything about pci happy.
>=20
>> I do recall seeing some messages about specific
>> cases where you cannot use the 'pc' machine type and we suggested
>> used of 'isapc' instead, but can't remember the exact details..
>=20
> I'd like to see such use cases where isapc is actually required.

Just my 0.02 =E2=82=AC: I like the idea of keeping isapc. It's a way to r=
emind
the x86 folks that there are also architectures without PCI / APIC /
ACPI. And this helped to spot some bugs in some HMP commands in the past
already.

> Well, nobody maintains it.  Nobody tests it.

At least we've got the automatic boot-serial-test now that checks that
the machine is not completely broken.

 Thomas
