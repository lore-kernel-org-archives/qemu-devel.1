Received: from eggs.gnu.org ([2001:4830:134:3::10]:40121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY42F-0007Dh-KK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fY42B-00011p-LE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:34:35 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:39449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fY42B-000101-DI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:34:31 -0400
Received: from player694.ha.ovh.net (unknown [10.109.120.51])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 61DF0E90B3
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 08:34:29 +0200 (CEST)
References: <20180625091718.18544-1-clg@kaod.org>
	<20180626152733.5050d9e3@bahia.lan>
	<120947ab-6846-aded-b946-59908ca8c4ae@kaod.org>
	<20180627001415.GE14434@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <28412acb-112e-829d-3a12-267d06a2138e@kaod.org>
Date: Wed, 27 Jun 2018 08:34:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180627001415.GE14434@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/5] rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/27/2018 02:14 AM, David Gibson wrote:
> On Tue, Jun 26, 2018 at 06:37:12PM +0200, C=E9dric Le Goater wrote:
> 1;5202;0c> On 06/26/2018 03:27 PM, Greg Kurz wrote:
>>> On Mon, 25 Jun 2018 11:17:13 +0200
>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> Hello,
>>>>
>>>
>>> Hello,
>>>
>>> Sorry I didn't manage to look at this before it got merged :)
>>>
>>>> It makes the class hierarchy much cleaner and removes duplicated
>>>> code. As we are touching the location of the objects states, migrati=
on
>>>> compatibility was checked and the following tests were performed und=
er
>>>> KVM :
>>>>
>>>>   qemu-3.0 (pseries-3.0)   -> qemu-3.0  (pseries-3.0)   OK
>>>>   qemu-3.0 (pseries-2.12)  -> qemu-2.12 (pseries-2.12)  OK
>>>>   qemu-3.0 (pseries-2.11)  -> qemu-2.11 (pseries-2.11)  OK
>>>>   qemu-3.0 (pseries-2.10)  -> qemu-2.10 (pseries-2.10)  OK
>>>>   qemu-3.0 (pseries-2.9)   -> qemu-2.9  (pseries-2.9)   OK
>>>>   qemu-3.0 (pseries-2.8)   -> qemu-2.8  (pseries-2.8)   OK
>>>>   qemu-3.0 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>>
>>> What's the failure ?
>>
>> qemu-system-ppc64: error while loading state for instance 0x0 of devic=
e 'cpu'
>> qemu-system-ppc64: load of migration failed: Invalid argument
>>
>> and to be more precise :
>>
>>    qemu-3.0  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.12 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.11 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.10 (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.9  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.8  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   FAIL
>>    qemu-2.7  (pseries-2.7)   -> qemu-2.7  (pseries-2.7)   OK
>>
>>
>> So it has been a while.
>=20
> Yeah, IIRC that's a known problem.  If you try 2.7.1, I think it will w=
ork.

I was using a 2.7.1.

C.=20


>=20
>>
>> C.=20
>>
>>
>>>
>>>>
>>>> and back :
>>>>
>>>>   qemu-3.0 (pseries-3.0)  <-  qemu-3.0  (pseries-3.0)   OK
>>>>   qemu-3.0 (pseries-2.12) <-  qemu-2.12 (pseries-2.12)  OK
>>>>   qemu-3.0 (pseries-2.11) <-  qemu-2.11 (pseries-2.11)  OK
>>>>   qemu-3.0 (pseries-2.10) <-  qemu-2.10 (pseries-2.10)  OK
>>>>   qemu-3.0 (pseries-2.9)  <-  qemu-2.9  (pseries-2.9)   OK
>>>>   qemu-3.0 (pseries-2.8)  <-  qemu-2.8  (pseries-2.8)   OK
>>>>   qemu-3.0 (pseries-2.7)  <-  qemu-2.7  (pseries-2.7)   OK
>>>>
>>>> under TCG, same scenarios were run but up to 2.10 only, in which cas=
e
>>>> the migration fails for other reasons.
>>>>
>>>> I wouldn't mind some extra cross checking from someone else.
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>>
>>>> Changes since v2:
>>>>
>>>>  - split the patch in smaller units. The migration tests were not
>>>>    rerun because the code is very much the same. make check was run =
on
>>>>    each patch.
>>>>
>>>>
>>>> C=E9dric Le Goater (5):
>>>>   ppc/xics: introduce a parent_realize in ICSStateClass
>>>>   ppc/xics: move the instance_init handler under the ics-base class
>>>>   ppx/xics: introduce a parent_reset in ICSStateClass
>>>>   ppc/xics: move the vmstate structures under the ics-base class
>>>>   ppc/xics: rework the ICS classes inheritance tree
>>>>
>>>>  include/hw/ppc/xics.h |   4 +-
>>>>  hw/intc/xics.c        | 164 ++++++++++++++++++++++++++++-----------=
-----------
>>>>  hw/intc/xics_kvm.c    |  46 +++++++-------
>>>>  hw/ppc/spapr.c        |   2 +-
>>>>  4 files changed, 121 insertions(+), 95 deletions(-)
>>>>
>>>
>>
>=20
