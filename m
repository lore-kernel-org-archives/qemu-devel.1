Received: from eggs.gnu.org ([2001:4830:134:3::10]:58086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw7X3-0001G6-7b
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw7X0-0003Ex-2h
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:33:01 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:60623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw7Wz-0003Ci-Rv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:32:57 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 605747BF37
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 15:32:56 +0200 (CEST)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<AA97BA94-C905-4D71-9D73-8064D3E309EA@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <718b56ea-2930-c85e-2c7f-b8b4287925a1@kaod.org>
Date: Thu, 6 Apr 2017 15:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <AA97BA94-C905-4D71-9D73-8064D3E309EA@gmail.com>
Content-Type: text/plain; charset=windows-1252
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
To: G 3 <programmingkidx@gmail.com>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, alex.bennee@linaro.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 04/06/2017 03:28 PM, G 3 wrote:
>=20
> On Apr 6, 2017, at 9:26 AM, C=E9dric Le Goater wrote:
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
>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked
>> good : the CPU usage of QEMU reached 760% on the host.
>=20
> What was your guest operating system?

The guest is an Ubuntu 16.04.2 and the host is an Ubuntu 17.04.

C.=20
