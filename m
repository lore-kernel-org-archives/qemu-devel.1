Received: from eggs.gnu.org ([209.51.188.92]:57475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk30p-0003A4-Br
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk30o-0001kE-C2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:26:55 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:45373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk30o-0001cI-6R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:26:54 -0500
Received: from player732.ha.ovh.net (unknown [10.109.146.211])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id D4ABC17AF85
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 09:26:50 +0100 (CET)
References: <20190117075327.22194-1-clg@kaod.org>
	<20190117075327.22194-5-clg@kaod.org>
	<20190117092054.355ff46e@bahia.lan>
	<bb422368-b2ea-9239-121b-1dbe78130d1f@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2e726e3f-048d-f9ce-4884-1cdebf7f0997@kaod.org>
Date: Thu, 17 Jan 2019 09:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <bb422368-b2ea-9239-121b-1dbe78130d1f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: remove the interrupt presenters
 from under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 1/17/19 9:23 AM, Thomas Huth wrote:
> On 2019-01-17 09:20, Greg Kurz wrote:
>> On Thu, 17 Jan 2019 08:53:27 +0100
>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>
>> The patch looks good, but I think it would be even better to apply thi=
s before
>> Thomas's -std=3Dc99 patchset. This would allow to get rid of the contr=
oversial
>> "ppc: Fix duplicated typedefs to be able to compile  with Clang in gnu=
99 mode"
>> patch :)
>=20
> Ok, I haven't started to send v3 of my PULL request yet, so I can try t=
o
> use these patches here instead...

Yes. that would be nice. Get rid of patch 4 then. And we need David's fee=
dback.

Thanks,

C.
