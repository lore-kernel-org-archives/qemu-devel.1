Received: from eggs.gnu.org ([2001:4830:134:3::10]:40651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cTR4E-0002vR-RZ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1cTR4B-0003um-Mw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:32:42 -0500
Received: from thoth.sbs.de ([192.35.17.2]:38078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1cTR4B-0003pu-Ba
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:32:39 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<20170117095910.GC4265@stefanha-x1.localdomain>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c5cb997-2f1e-8c31-62a2-08d4a8805840@siemens.com>
Date: Tue, 17 Jan 2017 11:32:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170117095910.GC4265@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>, Wei Wang <wei.w.wang@intel.com>, Markus Armbruster <armbru@redhat.com>

On 2017-01-17 10:59, Stefan Hajnoczi wrote:
> On Mon, Jan 16, 2017 at 02:10:17PM +0100, Jan Kiszka wrote:
>> On 2017-01-16 13:41, Marc-Andr=E9 Lureau wrote:
>>> On Mon, Jan 16, 2017 at 12:37 PM Jan Kiszka <jan.kiszka@siemens.com
>>> <mailto:jan.kiszka@siemens.com>> wrote:
>>>     So, this is our proposal. Would be great to hear some opinions if=
 you
>>>     see value in adding support for such an "ivshmem 2.0" device to Q=
EMU as
>>>     well and expand its ecosystem towards Linux upstream, maybe also =
DPDK
>>>     again. If you see problems in the new design /wrt what QEMU provi=
des so
>>>     far with its ivshmem device, let's discuss how to resolve them. L=
ooking
>>>     forward to any feedback!
>>>
>>>
>>> My feeling is that ivshmem is not being actively developped in qemu, =
but
>>> rather virtio-based solutions (vhost-pci for vm2vm).
>>
>> As pointed out, for us it's most important to keep the design simple -
>> even at the price of "reinventing" some drivers for upstream (at least=
,
>> we do not need two sets of drivers because our interface is fully
>> symmetric). I don't see yet how vhost-pci could achieve the same, but
>> I'm open to learn more!
>=20
> The concept of symmetry is nice but only applies for communications
> channels like networking and serial.
>=20
> It doesn't apply for I/O that is fundamentally asymmetric like disk I/O.
>=20
> I just wanted to point this out because lack symmetry has also bothered
> me about virtio but it's actually impossible to achieve it for all
> device types.

That's true. Not sure what all is planned for vhost-pci. Our scope is
limited (though mass storage proxying could be interesting at some
point), plus there is the option to do X-over-network.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
