Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSLV8-0004WG-Dl
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 06:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eSLV4-0006LG-FC
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 06:28:30 -0500
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:60453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eSLV4-0006Jl-7V
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 06:28:26 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9DA1592295
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 12:28:23 +0100 (CET)
References: <20171221165456.8609-1-clg@kaod.org>
	<20171222003906.GA26042@umbus.fritz.box>
	<edb67b7f-7592-d21c-901a-1d4671903d65@kaod.org>
	<20171222100911.GC26042@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0833b855-99e3-0a19-58ae-2c6dec4be374@kaod.org>
Date: Fri, 22 Dec 2017 12:28:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171222100911.GC26042@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/ppc: more use of the PPC_*() macros
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

On 12/22/2017 11:09 AM, David Gibson wrote:
> On Fri, Dec 22, 2017 at 08:01:41AM +0100, C=E9dric Le Goater wrote:
>> On 12/22/2017 01:39 AM, David Gibson wrote:
>>> On Thu, Dec 21, 2017 at 05:54:56PM +0100, C=E9dric Le Goater wrote:
>>>> Also introduce utilities to manipulate bitmasks (originaly from OPAL=
)
>>>> which be will be used in the model of the XIVE interrupt controller.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Applied to ppc-for-2.12, thanks.  Unfortunately getting my tree pulle=
d
>>> is held up because something is breaking on arm.
>>
>> yes. I saw. I gave it a try on ppc64,pp64el,x86-64 hosts and didn't=20
>> see anything wrong. I also have a raspberrypi3. Would that be a good=20
>> candidate ?
>=20
> No idea.  I tried on a RasPi 1 and a couple of other arms I borrowed.
> Haven't managed to reproduce.  I'm now suspecting it's something to do
> with the distro/library versions on Peter Maydell's system rather than
> anything particularly to do with ARM.
>=20

I cannot reproduce either on a rpi3 running raspian 8.=20

C.
