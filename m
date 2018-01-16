Received: from eggs.gnu.org ([2001:4830:134:3::10]:43585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1ebOWi-0000yS-Dw
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1ebOWb-0005EE-U1
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:31:32 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<548464fa8211307b397a5f50122abd3d@tribudubois.net>
	<ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
	<04ce75e9cdb6e001830c720196208e7f@tribudubois.net>
	<44e1abb6-88e7-95a0-ff27-fed969eb3a9c@adacore.com>
	<fb38cb0996586b500ef8b75877d16e7e@tribudubois.net>
	<8b247357a2e52d16d287db87b5d0957a@tribudubois.net>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <6b7fb1bd-c972-41d4-88c4-6be086b42345@adacore.com>
Date: Tue, 16 Jan 2018 11:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <8b247357a2e52d16d287db87b5d0957a@tribudubois.net>
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
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org

On 15/01/2018 18:27, Jean-Christophe Dubois wrote:
> Le 2018-01-15 14:45, Jean-Christophe Dubois a =C3=A9crit :
>>
>> Note: For now I am not so much interested in the AMBA discovery as the
>> type of software platform I am thinking about is embedded where the
>> hardware is well known ahead of time. This discovery capability would
>> make sense for more generic OS like linux or such. We cannot require
>> all embedded OS to implement the AMBA discovery process.
>=20
> For the configurability of Qemu, I was thinking of using something simi=
lar to the Qemu provided by Xilinx (http://www.wiki.xilinx.com/QEMU). Bas=
ically, you provide a DTB file as a Qemu command line argument and Qemu w=
ill build the various devices (including addresses and interrupts) based =
on the content of this file. Then when running an OS, it can provide the =
DTB file (for example to Linux) that match exactly the emulated platform.
>=20
> This should allow to build "any" variation of the platform and to add d=
evices as you need them. This makes sense for Xilinx (their customer are =
building custom platforms) and it would also make sense for LEON as the C=
PU core is usually integrated inside a custom SOC/FPGA.
>=20

Makes sense, another intermediate solution is to add an argument to the
function leon3_generic_hw_init(), A struct that specifies the address of
the peripherals. That way it will be easy to add more machine definition
without bringing more maintenance burden.
