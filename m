Received: from eggs.gnu.org ([2001:4830:134:3::10]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eeiqp-0000ja-A0
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eeiqo-0005Up-GO
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:50:03 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:51814
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1eeiqo-0005U3-99
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:50:02 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<a2112b45-6e33-9d91-aa4a-ce424f8ffeb1@ilande.co.uk>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <482985c4-5888-744f-2eb8-43a2fc048c8d@adacore.com>
Date: Thu, 25 Jan 2018 15:50:00 +0100
MIME-Version: 1.0
In-Reply-To: <a2112b45-6e33-9d91-aa4a-ce424f8ffeb1@ilande.co.uk>
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

On 24/01/2018 20:51, Mark Cave-Ayland wrote:
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
> Thanks. I've applied this (with some minor touch-ups to the commit mess=
age) to my qemu-sparc branch.
>=20

Thanks you Mark!
