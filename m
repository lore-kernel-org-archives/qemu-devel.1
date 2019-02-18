Received: from eggs.gnu.org ([209.51.188.92]:55889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gvd2y-0000zx-VI
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gvd2y-00054c-CU
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:09:00 -0500
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:48665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gvd2y-0004sA-5t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 02:09:00 -0500
Received: from player714.ha.ovh.net (unknown [10.109.143.72])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 578D5158E8B
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 08:08:43 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023081228.1011724.12474992370439652538.stgit@bahia.lan>
	<4690ad87-f634-4f3b-a39c-ee61bfc64e75@kaod.org>
	<20190215141824.3549d285@bahia.lan>
	<2237cc20-ffcd-4a9b-944a-392520127432@kaod.org>
	<20190217233711.GF2765@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6472757-5a18-258b-de5f-a7471b4e675c@kaod.org>
Date: Mon, 18 Feb 2019 08:08:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190217233711.GF2765@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/10] xics: Drop the KVM ICP class
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

On 2/18/19 12:37 AM, David Gibson wrote:
> On Fri, Feb 15, 2019 at 02:35:03PM +0100, C=E9dric Le Goater wrote:
>> On 2/15/19 2:18 PM, Greg Kurz wrote:
>>> On Fri, 15 Feb 2019 13:55:53 +0100
>>> C=E9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> On 2/15/19 12:40 PM, Greg Kurz wrote:
>>>>> The KVM ICP class isn't used anymore. Drop it. =20
>>>>
>>>> Isn't migration complaining ?  If not,
>>>>
>>>
>>> Hm.. no, but why would migration complain ?
>>
>> You are changing the type name of the object being transferred:
>>
>> "icp-kcm" -> "icp"
>=20
> It's a little more complex than that.  The way migration works, the
> state associated with the base class is transferred under the name
> "icp" and the state associated with the derived class is transferred
> under the name "icp-kvm".
>=20
>> Isn't that an issue ?
>=20
> It would be.. except that there is no extra state in the derived
> class, which is why we got away with this not-very-good solution at
> all in the first place.

Ah good. Another reason to get rid of the sub-class.

C.
 =20
