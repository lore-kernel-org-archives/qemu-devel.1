Received: from eggs.gnu.org ([2001:4830:134:3::10]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYpxb-0002fh-RN
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gYpxV-0004Uc-FS
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:17:13 -0500
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:56214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gYpxV-0004Sg-4a
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:17:09 -0500
Received: from player786.ha.ovh.net (unknown [10.109.146.175])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7EAAA1C3376
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 11:17:06 +0100 (CET)
References: <20181211223823.13770-1-clg@kaod.org>
	<20181217052902.GD5597@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <862a7ab2-90b1-f7a8-1327-92687b3f4e4d@kaod.org>
Date: Mon, 17 Dec 2018 11:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181217052902.GD5597@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/12] ppc: support for the XIVE
 interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 12/17/18 6:29 AM, David Gibson wrote:
> On Tue, Dec 11, 2018 at 11:38:11PM +0100, C=E9dric Le Goater wrote:
>> Hello,
>>
>> Here is the version 8 of the QEMU models adding support for the XIVE
>> interrupt controller to the sPAPR machine, under TCG only. KVM support
>> will be proposed in an other patchset, along with the KVM XIVE device
>> patchset, so will PowerNV.
>>
>> The most important changes for sPAPR are the introduction of a 'ic-mod=
e'
>> machine option to select the interrupt mode of the machine and the fix
>> for CPU hotplug.
>=20
> I've applied 1-6, I have some minor comments on 7, still reviewing the
> remainder.
>=20
> We also need to fix that Windows build bug - I'm planning to fold /
> insert that fix into the series so as not to break bisection.

ok. I will keep the Windows build fixes as standalone patches.=20

There is another one the hcalls, but, may be, you can fold the fix in=20
the hcall patch directly. =20
=20
Thanks,

C.
