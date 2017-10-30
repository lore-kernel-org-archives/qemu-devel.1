Received: from eggs.gnu.org ([2001:4830:134:3::10]:55650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1e98Jr-00025F-0e
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1e98Jm-0006QS-42
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:33:27 -0400
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:37637)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1e98Jl-0006PL-U2
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:33:22 -0400
References: <cover.1508885974.git.pisa@cmp.felk.cvut.cz>
	<28f27d84714abd1e85144a5679eaa3147f4ca023.1508885974.git.pisa@cmp.felk.cvut.cz>
	<35454964-58da-e9d1-f960-c7cff8a9e054@adacore.com>
	<201710292343.11885.pisa@cmp.felk.cvut.cz>
	<5a436a93-9538-e61b-32ef-4e92b5aad499@adacore.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <1d51d638-6046-2f7a-890d-a9d1fd0889a7@denx.de>
Date: Mon, 30 Oct 2017 11:51:10 +0100
MIME-Version: 1.0
In-Reply-To: <5a436a93-9538-e61b-32ef-4e92b5aad499@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] CAN bus simple SJA1000 PCI card
 emulation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>

On 10/30/2017 10:19 AM, KONRAD Frederic wrote:

[...]

>> CAN bus MIOe-3680 PCI (dual SJA1000 channel) emulation added.
>> =C2=A0=C2=A0 hw/can/can_mioe3680_pci.c
>>
>> If you think that this is more logical even that the first
>> commits introduce something which cannot be tested/compiles
>> only into library, then I rearrange patchyes this way.
>=20
> I don't know all those PCI cards. But if the simple SJA1000
> doesn't exist in real life maybe better dropping it?
SJA1000 is the only sensible card to emulate IMO, at least initially,
it's the de-facto standard for CAN devices.

[...]
--=20
Best regards,
Marek Vasut
