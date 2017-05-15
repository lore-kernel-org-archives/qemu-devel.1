Received: from eggs.gnu.org ([2001:4830:134:3::10]:54793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAIYi-00050y-Rh
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAIYf-0001K5-Jm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:09:20 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:41972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAIYf-0001Jf-DB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:09:17 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D0E55F5F06
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:09:15 +0200 (CEST)
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <adcf8e71-65c0-2952-6d01-cdaddb81d0f9@kaod.org>
Date: Mon, 15 May 2017 18:09:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170515151602.61dc381d@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 05/15/2017 03:16 PM, Greg Kurz wrote:
> On Mon, 15 May 2017 14:22:32 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 05/15/2017 01:40 PM, Greg Kurz wrote:
>>> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
>>> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
>>> is an improvement since we no longer allocate ICP objects that will
>>> never be used. But it has the side-effect of breaking migration of
>>> older machine types from older QEMU versions.
>>>
>>> This patch introduces a compat flag in the sPAPR machine class so
>>> that all pseries machine up to 2.9 go on with the previous behavior
>>> of pre-allocating ICP objects. =20
>>
>> I think this is a quite elegant way to a handle the migration=20
>> regression. Thanks for taking care of it.
>>
>> Have you tried to simply reparent the ICPs objects to OBJECT(spapr)=20
>> instead of the OBJECT(cpu)  ?=20
>>
>=20
> Do you mean to reparent unconditionally to OBJECT(spapr) for all
> machine versions ?=20

only in the case of smc->must_pre_allocate_icps

> I'm not sure this would be beneficial, but I might be missing=20
> something...

I think that we would not need to allocate the legacy_icps array.=20
Parenting the icp object to the spapr machine should be enough.=20
I might be wrong. my expertise on the migration stream is very=20
basic.

C.
=20
