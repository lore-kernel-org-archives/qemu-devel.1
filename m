Received: from eggs.gnu.org ([208.118.235.92]:47675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eR0EJ-0000Qs-RD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eR0Du-0008Gf-TT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:33:35 -0500
References: <20171216224842.EE8C17456B3@zero.eik.bme.hu>
	<20171218040946.GS7753@umbus.fritz.box>
	<alpine.BSF.2.21.1712181329050.96474@zero.eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Message-ID: <730aec0f-3f10-55ea-eb26-e5740c2fbfe2@redhat.com>
Date: Mon, 18 Dec 2017 13:33:07 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1712181329050.96474@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org



On 12/18/2017 07:30 AM, BALATON Zoltan wrote:
> On Mon, 18 Dec 2017, David Gibson wrote:
>> On Sat, Dec 16, 2017 at 11:42:39PM +0100, BALATON Zoltan wrote:
>>> This is a common generic PCI SATA controller that is also used in PCs
>>> but more importantly guests running on the Sam460ex board prefer this
>>> card and have a driver for it (unlike for other SATA controllers
>>> already emulated).
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> I don't know enough about IDE to give this any more than a quick check
>> for anything obviously bogus looking.=C2=A0 So,
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> John, can you take this through your tree, or should I take it through
>> the ppc tree?
>=20
> I think he said before it can go via ppc tree:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg04480.html
>=20

Yep, I tend to use Acked-by to indicate that it's okay for you to stage.
I'll give it another look-over in a minute, but I'm fine with adding the
model in general, even if it's not quite complete just yet.

(More musings: we really ought to have a way to indicate to QEMU
programmatically which devices we think are supported, which are
experimental, and which are rudimentary.)

--js
