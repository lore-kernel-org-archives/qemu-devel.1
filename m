Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxcnZ-0000XO-7s
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cxcnV-0005uJ-7j
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:08:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cxcnU-0005u8-U5
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:08:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3AH3bkI121015
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 13:08:11 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29re420560-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 13:08:10 -0400
Received: from localhost
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 22:38:07 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <82645aee-06a5-6187-5548-6b2e0caec5d9@kaod.org>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
	<87d1ck2ovp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<82645aee-06a5-6187-5548-6b2e0caec5d9@kaod.org>
Date: Mon, 10 Apr 2017 22:37:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87a87o2ntc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On 04/10/2017 06:44 PM, Nikunj A Dadhania wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> On 04/07/2017 08:07 AM, C=C3=A9dric Le Goater wrote:
>>>> On 04/07/2017 07:24 AM, Nikunj A Dadhania wrote:
>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>
>>>> sure. pnv is still on 2.9, so I will rebase on 2.10, merge your=20
>>>> patches  and tell you.
>>>
>>> The system seems to be spinning in skiboot in cpu_idle/relax when=20
>>> starting the linux kernel. It finally boots, but it is rather long.
>>> David has merged enough to test if you want to give it a try.
>>=20
>> I have got your powernv-ipmi-2.9 + ppc64 mttcg patches, and testing
>> them. I too saw delay during boot, but wasn't aware that its caused by
>> mttcg. I will have a look.
>
> You can use David's branch directly now, there is enough support.

Sure

> I am not sure where that is exactly, the kernel is somewhere in
> early_setup(). It might be the secondary spinloop.

Lot of prints missing, i think I need to add a console.

[    2.303286014,5] INIT: Starting kernel at 0x20010000, fdt at 0x30354908 =
14865 bytes)
[   43.421998779,5] OPAL: Switch to little-endian OS
 -> smp_release_cpus()
spinning_secondaries =3D 3
 <- smp_release_cpus()
[    0.260526] nvram: Failed to find or create lnx,oops-log partition, err =
-28
[    0.264448] nvram: Failed to initialize oops partition!

Regards,
Nikunj
