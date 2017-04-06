Received: from eggs.gnu.org ([2001:4830:134:3::10]:56821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cw7Sc-0005cC-7A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cw7Sb-0000Fa-9A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:28:26 -0400
In-Reply-To: <6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <AA97BA94-C905-4D71-9D73-8064D3E309EA@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 6 Apr 2017 09:28:17 -0400
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


On Apr 6, 2017, at 9:26 AM, C=E9dric Le Goater wrote:

> Hello Nikunj,
>
> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>> The series enables Multi-Threaded TCG on PPC64
>>
>> Patch 01: Use atomic_cmpxchg in store conditional
>>       02: Handle first write to page during atomic operation
>>       03: Generate memory barriers for sync/isync and load/store =20
>> conditional
>>
>> Patches are based on ppc-for-2.10
>>
>> Tested using following:
>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic =20=

>> -machine pseries,usb=3Doff -m 2G  -smp 8,cores=3D8,threads=3D1 -accel =
=20
>> tcg,thread=3Dmulti  f23.img
>
> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked
> good : the CPU usage of QEMU reached 760% on the host.

What was your guest operating system?
