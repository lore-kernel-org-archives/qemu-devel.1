Received: from eggs.gnu.org ([2001:4830:134:3::10]:32841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI833-0001ww-8Q
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI82z-0007DY-Vg
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:05:17 -0500
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:60447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI82z-00079A-JX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:05:13 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 76E92120D7F
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 08:05:04 +0100 (CET)
References: <20171123170524.3865-1-clg@kaod.org>
	<20171124000918.GF22454@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <91e790c1-186e-fecf-a2ae-c0ede1b17d7c@kaod.org>
Date: Fri, 24 Nov 2017 08:04:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171124000918.GF22454@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pcc: define the Power-saving mode Exit
 Cause Enable bits in PowerPCCPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/24/2017 01:09 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 06:05:24PM +0100, C=E9dric Le Goater wrote:
>> and use the value to define precisely the default value of the LPCR in
>> the helper routine cpu_ppc_set_papr()
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Applied to ppc-for-2.12.
>=20
> Sorry, I forgot if we needed this for 2.11 - if so, I can move it
> over.

The next patchset fixes reboot and CPU hotplug under TCG.=20

But we are 10 days before 2.11, TCG is clearly not the most=20
used accelerators for sPAPR, I am the only one complaining=20
about it because of XIVE. I Let you decide.

Sending the v4 of ""disable the decrementer interrupt when a=20
CPU is unplugged" now.

Thanks,

C.=20
