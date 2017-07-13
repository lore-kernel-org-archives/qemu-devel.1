Received: from eggs.gnu.org ([2001:4830:134:3::10]:50237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVYvd-00026k-8K
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVYvY-0007hX-SG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:52:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dVYvY-0007gf-J2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:52:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D7mvcj021027
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:52:46 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3pcmur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:52:46 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 17:52:44 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
Date: Thu, 13 Jul 2017 13:22:29 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87bmoobwoy.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On 07/13/2017 06:38 AM, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>>=20
>>>
>>> Ok, but we definitely should be able to fix this without new
>>> variables.  If we can quiesce the secondary CPUs for the first boot,
>>> we should be able to duplicate that for subsequent boots.
>>=20
>> How about the following, we do not report work until MSR_EE is disabled:
>
> With this fix, I could test the XIVE<->XICS transitions at reboot=20
> under TCG.

> However, the second boot is very slow for some reason.=20

This is not related with current patch. Its slow otherwise as well.

>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>


Regards
Nikunj
