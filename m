Received: from eggs.gnu.org ([2001:4830:134:3::10]:59222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gUpud-00023U-Rn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gUpuY-0005zz-Qr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:25:39 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <6fa9dfc4-5ed2-2e1f-1ac2-bb8e095199b7@kaod.org>
Date: Thu, 6 Dec 2018 17:24:00 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <92F4D337-60D6-4E5D-B370-119696ECF792@euphon.net>
References: <154405861291.2740.13102898879826160714@bb8f5089e434>
	<6fa9dfc4-5ed2-2e1f-1ac2-bb8e095199b7@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 00/37] ppc: support for the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, famz@redhat.com, David Gibson <david@gibson.dropbear.id.au>



> On Dec 6, 2018, at 14:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
> Hello,
>=20
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> Checking PATCH 25/37: spapr/xive: add state synchronization with =
KVM...
>> Checking PATCH 26/37: spapr/xive: introduce a VM state change =
handler...
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #38: FILE: hw/intc/spapr_xive_kvm.c:341:
>> + static void kvmppc_xive_sync_all(sPAPRXive *xive, Error **errp)
>>                                             ^
>>=20
>> total: 1 errors, 0 warnings, 135 lines checked
>=20
> This looks like a false positive.

Right. Without looking at the checkpatch code, I suspect this is due to =
sPAPRXive starts with a lower case letter which is not standard.

Fam

>=20
> C.
>=20
