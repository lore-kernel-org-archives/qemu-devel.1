Received: from eggs.gnu.org ([2001:4830:134:3::10]:48092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eL97W-0006UO-5k
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eL97S-0001gs-A1
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:50:22 -0500
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:48450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eL97R-0001ey-TM
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:50:18 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 98FD4177431
	for <qemu-devel@nongnu.org>; Sat,  2 Dec 2017 15:50:16 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
	<20171128064034.GQ11775@umbus.fritz.box>
	<1512224666.2224.52.camel@kernel.crashing.org>
	<ed946d89-61a0-7ef7-29a1-105a64a8e3f2@kaod.org>
	<1512226099.2224.71.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a72d93f7-106f-aded-967a-70e1f3369516@kaod.org>
Date: Sat, 2 Dec 2017 15:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <1512226099.2224.71.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/02/2017 03:48 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2017-12-02 at 15:38 +0100, C=C3=A9dric Le Goater wrote:
>> Hmm, yes. So, the current design for sPAPR handles all sources=20
>> under the same XIVE object with a global memory region for all=20
>> the ESBs.=20
>>
>> The first RFC had a mechanism to register source objects into=20
>> the XIVE main one, allocating the IRQs per source and mapping=20
>> the ESBs in the overall region. A bit like OPAL does. I then=20
>> simplified for the sake of clarity and merged everything under=20
>> the same XIVE object.=20
>>
>> Shall I reintroduce multiples sources support ? and provide a=20
>> default one for IPIs and virtual devices of the machine.=20
>=20
> That or you need state bits ;-)

yeah. I started with state bits and thought I could hack the PQ=20
ones but that's wrong.=20

Thanks,

C.=20
