Received: from eggs.gnu.org ([2001:4830:134:3::10]:56814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digC3-0001p1-HB
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1digBy-0008Gq-JC
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 08:16:03 -0400
Date: Fri, 18 Aug 2017 14:15:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
Message-ID: <alpine.BSF.2.21.1708181410200.19483@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<20170818015321.GN5509@umbus.fritz.box>
	<194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-15?Q?Fran=E7ois_Revol?= <revol@free.fr>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 18 Aug 2017, Fran=E7ois Revol wrote:
> Le 18/08/2017 =E0 03:53, David Gibson a =E9crit :
>> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>>
>> You know I'm going to say it, right: needs a commit message.
>>
>> What's a "plb-pcix", and what's an example of a 440 SoCs which has it.
>
> IIRC that's the PCI(express) controller, which is not memory-mapped but
> inside the DCR address space, so accessed from the PLB.

This is the PCI(X) controller only, the PCIe(xpress) controller is=20
(partially) implemented in sam460ex.c=20
TYPE_PPC460EX_PCIE_HOST/"ppc460ex-pcie-host". The plb-pcix is the=20
compatible name the fdt refers to. I only know of the 460EX that has it=20
but probably other similar SoCs (like some 440 variants) also have this=20
kind of PCI controller (according to #defines in U-Boot source but don't=20
remember the details).

Regards,
BALATON Zoltan
