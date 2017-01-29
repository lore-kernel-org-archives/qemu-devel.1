Received: from eggs.gnu.org ([2001:4830:134:3::10]:36845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cXo5w-0007Ce-95
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 06:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1cXo5v-00047l-G5
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 06:56:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Sun, 29 Jan 2017 12:56:23 +0100
From: msuchanek <msuchanek@suse.de>
In-Reply-To: <20170117095910.GC4265@stefanha-x1.localdomain>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<20170117095910.GC4265@stefanha-x1.localdomain>
Message-ID: <7586642a42833441c2bbe5ac3403e44b@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jailhouse <jailhouse-dev@googlegroups.com>, Wei Wang <wei.w.wang@intel.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Qemu-devel <qemu-devel-bounces+msuchanek=suse.de@nongnu.org>

On 2017-01-17 10:59, Stefan Hajnoczi wrote:
> On Mon, Jan 16, 2017 at 02:10:17PM +0100, Jan Kiszka wrote:
>> On 2017-01-16 13:41, Marc-Andr=C3=A9 Lureau wrote:
>> > On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
>> > <mailto:jan.kiszka@siemens.com>> wrote:
>> >     So, this is our proposal. Would be great to hear some opinions i=
f you
>> >     see value in adding support for such an "ivshmem 2.0" device to =
QEMU as
>> >     well and expand its ecosystem towards Linux upstream, maybe also=
 DPDK
>> >     again. If you see problems in the new design /wrt what QEMU prov=
ides so
>> >     far with its ivshmem device, let's discuss how to resolve them. =
Looking
>> >     forward to any feedback!
>> >
>> >
>> > My feeling is that ivshmem is not being actively developped in qemu,=
 but
>> > rather virtio-based solutions (vhost-pci for vm2vm).
>>=20
>> As pointed out, for us it's most important to keep the design simple -
>> even at the price of "reinventing" some drivers for upstream (at=20
>> least,
>> we do not need two sets of drivers because our interface is fully
>> symmetric). I don't see yet how vhost-pci could achieve the same, but
>> I'm open to learn more!
>=20
> The concept of symmetry is nice but only applies for communications
> channels like networking and serial.
>=20
> It doesn't apply for I/O that is fundamentally asymmetric like disk=20
> I/O.
>=20
> I just wanted to point this out because lack symmetry has also bothered
> me about virtio but it's actually impossible to achieve it for all
> device types.
>=20

What's asymetric about storage? IIRC both SCSI and Firewire which can be
used for storage are symmetric. All asymmetry only comes from usage
convention or less capable buses like IDE/SATA.

Thanks

Michal
