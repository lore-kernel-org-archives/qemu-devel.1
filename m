Received: from eggs.gnu.org ([2001:4830:134:3::10]:59005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d89oc-0003lS-9b
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d89ob-0004R5-Gn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:24:54 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-3-f4bug@amsat.org>
	<2cd1e7a1-7f92-88a2-cf98-0dcea0a2f9b1@redhat.com>
	<f7e86a1d-f53e-5dfa-e8d2-5dd2e860879a@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66e1f05c-36d0-9d80-1b57-4b21e9387b2a@redhat.com>
Date: Tue, 9 May 2017 20:24:38 +0200
MIME-Version: 1.0
In-Reply-To: <f7e86a1d-f53e-5dfa-e8d2-5dd2e860879a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 02/11] hw/pci: define msi_nonbroken in
 pci-stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-arm@nongnu.org

 Hi Philippe,

On 09.05.2017 18:49, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 05/09/2017 02:19 AM, Thomas Huth wrote:
>> On 09.05.2017 01:39, Philippe Mathieu-Daud=C3=A9 wrote:
>>> This field is accessed in hw/intc/arm_gicv[23*].c
>>
>> default-configs/arm-softmmu.mak sets CONFIG_PCI, so this should not be
>> necessary, I think. Otherwise, you should extend your patch descriptio=
n,
>> to elaborate on what you're trying to do here.
>>
>>  Thomas
>=20
> Sure, I'm willing to add basic support for the TI Hercules MCU which is
> a big endian SoC (without PCI support).
>=20
> I'm using the following config:
>=20
> $ cat default-configs/armeb-softmmu.mak

$ cat default-configs/armeb-softmmu.mak
cat: default-configs/armeb-softmmu.mak: No such file or directory

... so you're planning for a new armeb config file here? That's the kind
of information that I was missing in the patch description.

[...]
> As I understand the 'msi_nonbroken' is a kludge (there is no intrinsic
> relationship between PCI/MSI and this particular interrupt controller).
> Since it is declared as extern in "hw/pci/msi.h" why not define it in
> pci-stub?

Sure, your patch is fine, IMHO it just lacks some rationale in its
description.

 Thomas
