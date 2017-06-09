Received: from eggs.gnu.org ([2001:4830:134:3::10]:51696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dJCkn-0006TP-UP
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dJCki-0004s7-W8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:46:38 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:34926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dJCki-0004rY-Qn
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:46:32 -0400
Received: from player787.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 50496DF065
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 07:46:31 +0200 (CEST)
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692936183.12119.5013623492394505174.stgit@bahia>
	<5022e1af-9b70-518a-ce61-cadc905e637f@kaod.org>
	<20170608163207.45ba5618@bahia.ttt.fr.ibm.com>
	<018ad85d-6b7f-53d9-e3dc-4a79fcc81767@kaod.org>
	<20170608174559.053df142@bahia.ttt.fr.ibm.com>
	<a5d61649-5e45-7e36-b5ac-06dbf14a71a3@kaod.org>
	<20170608190041.79e55b43@bahia.ttt.fr.ibm.com>
	<9fdf8493-625a-561f-ca07-e56a3bd797cf@kaod.org>
	<20170609021059.GD26521@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7986edb4-0fbb-2bac-d2d1-0de420149056@kaod.org>
Date: Fri, 9 Jun 2017 07:46:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170609021059.GD26521@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/09/2017 04:10 AM, David Gibson wrote:
> On Thu, Jun 08, 2017 at 07:26:35PM +0200, C=E9dric Le Goater wrote:
>> On 06/08/2017 07:00 PM, Greg Kurz wrote:
>>> On Thu, 8 Jun 2017 18:08:44 +0200
>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>>>>> FWIW, other people do that as well (see hw/i386/pc_q35.c for exam=
ple).   =20
>>>>>>
>>>>>> well, I don't see the benefits of changing a string constant by a=20
>>>>>> define.=20
>>>>>> =20
>>>>>
>>>>> Improved semantics,  especially since the "xics" string appears in=20
>>>>> many places with different meanings.  =20
>>>>
>>>> ah ? If so, we should do a cleanup up. The code seems consistent fro=
m=20
>>>> what I can see. xics is a general name for :
>>>>
>>>> 	'PowerPC interrupt controller (type 2)'=20
>>>>
>>>> and it is mostly used as a prefix. There are no "xics" object, only =
a=20
>>>
>>> I'm only talking about "xics" as a property name actually:
>>>
>>> $ git grep '"xics"'
>>> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xic=
s", &err);
>>> hw/intc/xics.c:    obj =3D object_property_get_link(OBJECT(dev), "xic=
s", &err);
>>> hw/ppc/pnv.c:    object_property_add_const_link(OBJECT(&chip->psi), "=
xics",
>>> hw/ppc/pnv.c:        object_property_add_const_link(OBJECT(pnv_core),=
 "xics",
>>> hw/ppc/pnv_core.c:    object_property_add_const_link(obj, "xics", OBJ=
ECT(xi), &error_abort);
>>> hw/ppc/pnv_core.c:    xi =3D object_property_get_link(OBJECT(dev), "x=
ics", &local_err);
>>> hw/ppc/pnv_psi.c:    obj =3D object_property_get_link(OBJECT(dev), "x=
ics", &err);
>>> hw/ppc/pnv_psi.c:    object_property_add_const_link(OBJECT(ics), "xic=
s", obj,  &error_abort);
>>> hw/ppc/spapr.c:    object_property_add_const_link(obj, "xics", OBJECT=
(spapr), &error_abort);
>>> hw/ppc/spapr_cpu_core.c:    object_property_add_const_link(obj, "xics=
", OBJECT(spapr), &error_abort);
>>>
>>> You have to read the code to know which ones are related.
>>
>> The "xics" property link always point to the same object :=20
>> the XICSFabric object which is the machine, spapr or pnv.=20
>>
>>> With this patch applied, it is mostly obvious, even for the newbie:
>>
>> ah. the goal is to know where in the code the link was set.=20
>> It can be even more complex with aliases.
>=20
> There doesn't seem to be a strong convention about whether to use raw
> property names or defines across qemu.  I'm not all that fussed either
> way.
>=20
> I do see one small advantage to use defines: if you make a typo, it
> will probably result in a compile time error, whereas with a bare
> string it won't show up until a runtime error.

ok. I can agree with that.

> In this case, I intend to take the macro patch, mostly just on the
> basis of avoiding further delays to rework the remaining patches.

But I don't think having two different defines is a good idea :=20

+#define ICP_PROP_XICS "xics"
+#define ICS_PROP_XICS "xics"

C.
