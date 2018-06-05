Received: from eggs.gnu.org ([2001:4830:134:3::10]:41043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQ76o-00065Y-8M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQ76k-0008B0-8N
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:14:26 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:47514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQ76k-000877-18
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:14:22 -0400
Received: from player795.ha.ovh.net (unknown [10.109.120.110])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 90B03181DF
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 10:14:20 +0200 (CEST)
References: <20180604172039.19427-1-clg@kaod.org>
	<20180604231033.GB5140@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <aa50ba9e-03b0-5493-b41f-c72848390b9a@kaod.org>
Date: Tue, 5 Jun 2018 10:14:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180604231033.GB5140@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] target/ppc: extend eieio for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Ellerman <mpe@ellerman.id.au>

On 06/05/2018 01:10 AM, David Gibson wrote:
> On Mon, Jun 04, 2018 at 07:20:39PM +0200, C=E9dric Le Goater wrote:
>> POWER9 introduced a new variant of the eieio instruction using bit 6
>> as a hint to tell the CPU it is a store-forwarding barrier.
>>
>> The usage of this eieio extension was recently added in Linux 4.17
>> which activated the "support for a store forwarding barrier at kernel
>> entry/exit".
>>
>> This loosen the QEMU eieio instruction mask to boot newer kernel but I
>> think we should be adding a new *eieio* instruction specific to POWER9
>> instead. I just don't know how to define an instruction variant with
>> the same op code for an ISA version. Any idea ?
>=20
> I think you're right that this should be done slightly differently.
> I think you can do that by adding a new instruction mask bit; say
> PPC2_MEM_EIEIO2 or whatever.  You leave the existing GEN_HANDLER as
> is, add another GEN_HANDLER_E with the new mask dependent on the new
> bit, then make sure POWER9 has the new bit set, but not the old one.

Unfortunately this doesn't work :/ QEMU considers the opcode is already
defined. May be we could test bit6 in gen_eieio ?=20
=20

C.=20
