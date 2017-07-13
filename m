Received: from eggs.gnu.org ([2001:4830:134:3::10]:43125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVa8t-0008AL-7X
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVa8o-0002sd-3y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:10:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48838
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dVa8n-0002sT-Tw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 05:10:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D98dvV087104
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:10:33 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3ry122-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:10:32 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 19:10:30 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <5fa5cb00-ee28-0ba4-2084-b0a43b8429f1@kaod.org>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
	<b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
	<878tjsbwj4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<5fa5cb00-ee28-0ba4-2084-b0a43b8429f1@kaod.org>
Date: Thu, 13 Jul 2017 14:40:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <8760ewbt38.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC] spapr: ignore interrupts
 during reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 07/13/2017 09:55 AM, Nikunj A Dadhania wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>>>> How about the following, we do not report work until MSR_EE is disabl=
ed:
>>>>
>>>> With this fix, I could test the XIVE<->XICS transitions at reboot=20
>>>> under TCG. However, the second boot is very slow for some reason.=20
>>>
>>> hmm, I am not sure this is related but I just got :=20
>>=20
>> Havent seen in my setup after around 10 reboot cycles, I was using 2
>> cores pseries setup. Lets give it some more testing. When did this
>> happen, during boot ?
>
> yes.=20
>
> I could not reproduce either :/ but I am keeping the patch. qemu runs
> with :
>
> -m 2G -M pseries -accel tcg,thread=3Dmulti -cpu POWER9 -smp cores=3D4,max=
cpus=3D8 -realtime mlock=3Doff -kernel ./vmlinux-4.12.0+ -initrd ./initrd.i=
mg-4.12.0+ -append 'console=3Dhvc0 dyndbg=3D"file arch/powerpc/sysdev/xive/=
* +p"' -nographic -nodefaults -serial mon:stdio -snapshot  -d guest_errors,=
unimp -no-shutdown
>

With 4 cores I am seeing hangs occasionally, although I havent seen a
crash. But seems to be similar problem that you had seen.

Regards,
Nikunj
