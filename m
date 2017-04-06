Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cw7ld-0005yI-LM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cw7lc-0001VH-QP
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:48:05 -0400
In-Reply-To: <718b56ea-2930-c85e-2c7f-b8b4287925a1@kaod.org>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<AA97BA94-C905-4D71-9D73-8064D3E309EA@gmail.com>
	<718b56ea-2930-c85e-2c7f-b8b4287925a1@kaod.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <9A190410-18FD-40B1-B5E0-C7E9D98591E0@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 6 Apr 2017 09:47:55 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, alex.bennee@linaro.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


On Apr 6, 2017, at 9:32 AM, C=E9dric Le Goater wrote:

> On 04/06/2017 03:28 PM, G 3 wrote:
>>
>> On Apr 6, 2017, at 9:26 AM, C=E9dric Le Goater wrote:
>>
>>> Hello Nikunj,
>>>
>>> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>>>> The series enables Multi-Threaded TCG on PPC64
>>>>
>>>> Patch 01: Use atomic_cmpxchg in store conditional
>>>>       02: Handle first write to page during atomic operation
>>>>       03: Generate memory barriers for sync/isync and load/store =20=

>>>> conditional
>>>>
>>>> Patches are based on ppc-for-2.10
>>>>
>>>> Tested using following:
>>>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -=20
>>>> nographic -machine pseries,usb=3Doff -m 2G  -smp =20
>>>> 8,cores=3D8,threads=3D1 -accel tcg,thread=3Dmulti  f23.img
>>>
>>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It =20
>>> looked
>>> good : the CPU usage of QEMU reached 760% on the host.
>>
>> What was your guest operating system?
>
> The guest is an Ubuntu 16.04.2 and the host is an Ubuntu 17.04.
>
> C.

Thank you for the information.

What you could do is run QEMU in emulation mode (non-kvm mode) and =20
time how long it takes Ubuntu to boot up with one emulated core vs =20
how long it takes to boot up on say 4 emulated cores. This would be a =20=

good start:

Boot up times:

one core:

two cores:

four cores:

eight cores:
