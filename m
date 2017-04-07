Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwN86-0008AC-OW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwN81-0002dY-Ps
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:12:18 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:59501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cwN81-0002d8-KF
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:12:13 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id A206435161
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 08:12:12 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-4-git-send-email-clg@kaod.org>
	<20170406020256.GA1991@umbus.fritz.box>
	<5e61337a-135c-9574-993f-de00fab26777@kaod.org>
	<1491515650.4166.127.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3f3b2b74-b8ac-5dae-7470-5742aeee8d27@kaod.org>
Date: Fri, 7 Apr 2017 08:12:08 +0200
MIME-Version: 1.0
In-Reply-To: <1491515650.4166.127.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/21] ppc/pnv: Add support for POWER8+ LPC
 Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/06/2017 11:54 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-06 at 14:44 +0200, C=C3=A9dric Le Goater wrote:
>> May be we could move that under the LPC object even if it is not
>> strictly
>> correct from a HW pov ?=20
>=20
> I'm not fan of this. It's really not part of the LPC controller and
> it's specific to a certain crop of P8 machines.

OK Let's keep it there then. no big deal.

Thanks,

C.
