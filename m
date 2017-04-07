Received: from eggs.gnu.org ([2001:4830:134:3::10]:56174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMNo-0005gF-Uz
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cwMNk-0004LH-Vw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:24:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cwMNk-0004Jk-N3
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 01:24:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v375NcHc128917
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 01:24:23 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29p2h5nkub-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 01:24:22 -0400
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 7 Apr 2017 10:54:19 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
Date: Fri, 07 Apr 2017 10:54:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: programmingkidx@gmail.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello Nikunj,
>
> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>> The series enables Multi-Threaded TCG on PPC64
>>=20
>> Patch 01: Use atomic_cmpxchg in store conditional
>>       02: Handle first write to page during atomic operation
>>       03: Generate memory barriers for sync/isync and load/store conditi=
onal
>>=20
>> Patches are based on ppc-for-2.10
>>=20
>> Tested using following:
>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -mach=
ine pseries,usb=3Doff -m 2G  -smp 8,cores=3D8,threads=3D1 -accel tcg,thread=
=3Dmulti  f23.img
>
> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked=20
> good : the CPU usage of QEMU reached 760% on the host.

Cool.

>> Todo:
>> * Enable other machine types and PPC32.
>
> I am quite ignorant on the topic.
> Have you looked at what it would take to emulate support of the HW
> threads ?

We would need to implement msgsndp (doorbell support for IPI between
threads of same core)

> and the PowerNV machine ?

Haven't tried it, should work. Just give a shot, let me know if you see pro=
blems.

Regards
Nikunj
