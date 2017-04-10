Received: from eggs.gnu.org ([2001:4830:134:3::10]:50908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxcfA-0007cB-AS
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxcf6-0002mw-E6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:59:36 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:49771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxcf6-0002lW-6l
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:59:32 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2DFE43285A
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 18:59:30 +0200 (CEST)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
	<87d1ck2ovp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <82645aee-06a5-6187-5548-6b2e0caec5d9@kaod.org>
Date: Mon, 10 Apr 2017 18:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <87d1ck2ovp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

On 04/10/2017 06:44 PM, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>> On 04/07/2017 08:07 AM, C=C3=A9dric Le Goater wrote:
>>> On 04/07/2017 07:24 AM, Nikunj A Dadhania wrote:
>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> Hello Nikunj,
>>>>>
>>>>> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>>>>>> The series enables Multi-Threaded TCG on PPC64
>>>>>>
>>>>>> Patch 01: Use atomic_cmpxchg in store conditional
>>>>>>       02: Handle first write to page during atomic operation
>>>>>>       03: Generate memory barriers for sync/isync and load/store c=
onditional
>>>>>>
>>>>>> Patches are based on ppc-for-2.10
>>>>>>
>>>>>> Tested using following:
>>>>>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic=
 -machine pseries,usb=3Doff -m 2G  -smp 8,cores=3D8,threads=3D1 -accel tc=
g,thread=3Dmulti  f23.img
>>>>>
>>>>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It loo=
ked=20
>>>>> good : the CPU usage of QEMU reached 760% on the host.
>>>>
>>>> Cool.
>>>>
>>>>>> Todo:
>>>>>> * Enable other machine types and PPC32.
>>>>>
>>>>> I am quite ignorant on the topic.
>>>>> Have you looked at what it would take to emulate support of the HW
>>>>> threads ?
>>>>
>>>> We would need to implement msgsndp (doorbell support for IPI between
>>>> threads of same core)
>>>
>>> ok. I get it. Thanks,
>>>
>>>>> and the PowerNV machine ?
>>>>
>>>> Haven't tried it, should work. Just give a shot, let me know if you =
see problems.
>>>
>>> sure. pnv is still on 2.9, so I will rebase on 2.10, merge your=20
>>> patches  and tell you.
>>
>> The system seems to be spinning in skiboot in cpu_idle/relax when=20
>> starting the linux kernel. It finally boots, but it is rather long.
>> David has merged enough to test if you want to give it a try.
>=20
> I have got your powernv-ipmi-2.9 + ppc64 mttcg patches, and testing
> them. I too saw delay during boot, but wasn't aware that its caused by
> mttcg. I will have a look.

You can use David's branch directly now, there is enough support.

I am not sure where that is exactly, the kernel is somewhere in
early_setup(). It might be the secondary spinloop.


thanks,=20

C.=20
