Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDTt-0005gR-4e
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDTq-0008FN-1R
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:52:09 -0500
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:52019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDTp-0008DP-Ri
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:52:05 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 309A3DBC6F
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:52:04 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-5-git-send-email-clg@kaod.org>
	<20170223021531.GS12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eeec3567-d024-a09a-8a58-304a27c0bb95@kaod.org>
Date: Fri, 24 Feb 2017 11:52:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170223021531.GS12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 04/22] ppc/xics: add an
 InterruptStatsProvider interface to ICS and ICP objects
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

On 02/23/2017 03:15 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:27PM +0100, C=E9dric Le Goater wrote:
>> This is, again, to reduce the use of the list of ICS objects. Let's
>> make each individual ICS and ICP object an InterruptStatsProvider and
>> remove this same interface from XICSState.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I'm a little hesitant about this, because it means that getting the
> interrupt stats information is now spread out over the qom tree,
> whereas previously there was a single location to get a good summary
> of the systems overall interrupt status.  The previous behaviour seems
> like it would be more convenient for debugging.
>=20
> That said, I see the structural advantages of this split.  Hmm.. still
> thinking..

This is true. Another argument in favour of what you are saying=20
is the order in which these are printed. See below. =20

What we could do after the cleanup is to make the machine an=20
InterruptStatsProvider to clarify things.=20

Thanks,

C.=20


(qemu) info pic=20
CPU 18 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 0 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 21 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 2 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 23 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 4 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 11 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 25 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 6 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 13 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 27 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 8 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 15 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 29 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 30 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 17 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 20 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 19 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 1 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
ICS 1000..13ff 0x10018f1ea40
  1000 MSI ff 00
  1001 MSI ff 00
  1002 MSI ff 00
  1003 MSI ff 00
  1004 LSI ff 00
  1005 LSI ff 00
  1006 LSI ff 00
  1007 LSI ff 00
  1008 MSI ff 00
  1009 MSI ff 00
  100a MSI ff 00
  100b MSI ff 00
  100c MSI ff 00
CPU 22 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 3 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 10 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 24 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 5 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 12 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 26 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 7 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 14 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 28 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 9 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 16 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
CPU 31 XIRR=3D00000000 ((nil)) PP=3Dff MFRR=3Dff
