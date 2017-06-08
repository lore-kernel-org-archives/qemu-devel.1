Received: from eggs.gnu.org ([2001:4830:134:3::10]:40067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIymo-0001fG-Lv
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dIymk-0000T2-QT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:51:46 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:51808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dIymk-0000Sa-Jr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:51:42 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 56BEA71064
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:51:40 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
Date: Thu, 8 Jun 2017 16:51:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/6] xics: introduce macros for ICP/ICS
 link properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/08/2017 04:32 PM, Greg Kurz wrote:
> On Thu, 8 Jun 2017 16:04:21 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 06/08/2017 03:42 PM, Greg Kurz wrote:
>>> These properties are part of the XICS API. They deserve to appear
>>> explicitely in the XICS header file. =20
>>
>> I don't see the benefits.
>>
>=20
> The links need to be set with the appropriate name otherwise XICS bails=
 out.
> When David asked to rename the "cs" prop to "cpu",=20

yes. that is better.

> I forgot to patch pnv accordingly in the first place. :)
>=20
> FWIW, other people do that as well (see hw/i386/pc_q35.c for example).

well, I don't see the benefits of changing a string constant by a=20
define.=20

Cheers,=20

C.
