Received: from eggs.gnu.org ([2001:4830:134:3::10]:46922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjqvP-0008F6-Mf
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjqvK-0005ar-Pg
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:23:27 -0500
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:41618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cjqvK-0005aR-Iv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:23:22 -0500
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B0FC7504A8
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 18:23:20 +0100 (CET)
References: <1488548254-456-1-git-send-email-clg@kaod.org>
	<39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
	<f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
	<b4b5780b-4604-9577-f42a-8821c4cb18d4@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c8ea232a-3511-f42a-6643-18a66a3d8e9c@kaod.org>
Date: Fri, 3 Mar 2017 18:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <b4b5780b-4604-9577-f42a-8821c4cb18d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/03/2017 05:54 PM, Thomas Huth wrote:
> On 03.03.2017 15:49, C=C3=A9dric Le Goater wrote:
>> On 03/03/2017 03:13 PM, Thomas Huth wrote:
>>> On 03.03.2017 14:37, C=C3=A9dric Le Goater wrote:
>>>> Also use an 'Object *' under the sPAPR machine to hold the RTC
>>>> object.
>>>
>>> The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a goo=
d
>>> idea! But what's the advantage of using Object* instead of DeviceStat=
e*
>>> in sPAPRMachineState ?
>>
>> it makes spapr_rtc_create() a little simpler. =20
>>
>> We could go even further and use a sPAPRRTCState under sPAPRMachineSta=
te=20
>> that we  would initialize with object_initialize().=20
>=20
> I think a sPAPRRTCState* would make more sense here - if you just see a=
n
> Object* and are not familiar with the code, you wonder what this pointe=
r
> is all about (and you then have to cast it to something different if yo=
u
> want to do anything with it) ... so IMHO either a DeviceState* or
> sPAPRRTCState* is the better choice here.

I think having a non-pointer is a better for the object lifecycle=20
but I don't have a strong opinion on that. We will see what Dave=20
prefers.

Thanks,

C.=20
