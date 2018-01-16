Received: from eggs.gnu.org ([2001:4830:134:3::10]:40388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1ebONY-00069u-8z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1ebONU-00078y-Ao
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:22:04 -0500
Received: from mel.act-europe.fr ([194.98.77.210]:32792
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1ebONU-00078M-5F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:22:00 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<c8bc330c-d03e-4b2e-87dd-5c5b4d66499f@ilande.co.uk>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <c710275e-a7c6-8356-0de1-9869d1b1a245@adacore.com>
Date: Tue, 16 Jan 2018 11:21:58 +0100
MIME-Version: 1.0
In-Reply-To: <c8bc330c-d03e-4b2e-87dd-5c5b4d66499f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-devel@nongnu.org

On 15/01/2018 19:16, Mark Cave-Ayland wrote:
> On 11/01/18 11:48, Fabien Chouteau wrote:
>=20
>> On 10/01/2018 21:43, Jean-Christophe Dubois wrote:
>>> With the LEON3 IRQ controller IRQs can be acknoledged 2 ways:
>>> * Explicitely by software writing to the CLEAR_OFFSET register
>>> * Implicitely when the procesor is done running the trap handler atta=
ched
>>> =C2=A0=C2=A0 to the IRQ.
>>>
>>
>> Thanks Jean-Christophe,
>>
>> I tested the patch with our software and it works.
>>
>> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
>=20
> Thanks Fabien. Does that mean you would like me to take this patch for =
my qemu-sparc branch?
>=20

Yes please :)

Should I use Acked-by?
