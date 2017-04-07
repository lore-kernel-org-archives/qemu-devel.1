Received: from eggs.gnu.org ([2001:4830:134:3::10]:35535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwN4B-0005C7-Fz
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwN46-0000g5-Gb
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:08:15 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cwN46-0000fY-AZ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:08:10 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9714D3517E
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 08:08:07 +0200 (CEST)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
Date: Fri, 7 Apr 2017 08:07:57 +0200
MIME-Version: 1.0
In-Reply-To: <87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: programmingkidx@gmail.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 04/07/2017 07:24 AM, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>> Hello Nikunj,
>>
>> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>>> The series enables Multi-Threaded TCG on PPC64
>>>
>>> Patch 01: Use atomic_cmpxchg in store conditional
>>>       02: Handle first write to page during atomic operation
>>>       03: Generate memory barriers for sync/isync and load/store cond=
itional
>>>
>>> Patches are based on ppc-for-2.10
>>>
>>> Tested using following:
>>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -m=
achine pseries,usb=3Doff -m 2G  -smp 8,cores=3D8,threads=3D1 -accel tcg,t=
hread=3Dmulti  f23.img
>>
>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked=
=20
>> good : the CPU usage of QEMU reached 760% on the host.
>=20
> Cool.
>=20
>>> Todo:
>>> * Enable other machine types and PPC32.
>>
>> I am quite ignorant on the topic.
>> Have you looked at what it would take to emulate support of the HW
>> threads ?
>=20
> We would need to implement msgsndp (doorbell support for IPI between
> threads of same core)

ok. I get it. Thanks,

>> and the PowerNV machine ?
>=20
> Haven't tried it, should work. Just give a shot, let me know if you see=
 problems.

sure. pnv is still on 2.9, so I will rebase on 2.10, merge your=20
patches  and tell you.

Thanks,

C.=20
