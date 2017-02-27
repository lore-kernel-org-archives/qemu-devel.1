Received: from eggs.gnu.org ([2001:4830:134:3::10]:40090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciGz8-0004kH-BX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciGz5-0008Iy-4i
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:46 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:51995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciGz4-0008IO-VJ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:48:43 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9BAC4B3F2E
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:48:40 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-5-git-send-email-clg@kaod.org>
	<20170223021531.GS12577@umbus.fritz.box>
	<eeec3567-d024-a09a-8a58-304a27c0bb95@kaod.org>
	<20170226234354.GH17615@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c966bd96-e5c8-ec14-cc37-5bff014d196c@kaod.org>
Date: Mon, 27 Feb 2017 09:48:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170226234354.GH17615@umbus.fritz.box>
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

On 02/27/2017 12:43 AM, David Gibson wrote:
> On Fri, Feb 24, 2017 at 11:52:01AM +0100, C=E9dric Le Goater wrote:
>> On 02/23/2017 03:15 AM, David Gibson wrote:
>>> On Thu, Feb 16, 2017 at 02:47:27PM +0100, C=E9dric Le Goater wrote:
>>>> This is, again, to reduce the use of the list of ICS objects. Let's
>>>> make each individual ICS and ICP object an InterruptStatsProvider an=
d
>>>> remove this same interface from XICSState.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> I'm a little hesitant about this, because it means that getting the
>>> interrupt stats information is now spread out over the qom tree,
>>> whereas previously there was a single location to get a good summary
>>> of the systems overall interrupt status.  The previous behaviour seem=
s
>>> like it would be more convenient for debugging.
>>>
>>> That said, I see the structural advantages of this split.  Hmm.. stil=
l
>>> thinking..
>>
>> This is true. Another argument in favour of what you are saying=20
>> is the order in which these are printed. See below. =20
>>
>> What we could do after the cleanup is to make the machine an=20
>> InterruptStatsProvider to clarify things.
>=20
> Right.  So "info pic" does at least iterate through all the providers,
> but the semi-random order is pretty icky.  I think putting the stats
> provider on the machine would be a better idea - I guess it should be
> easy enough if the xics code provides a helper.

OK. This is on my TODO list for the next version of the patchset but as=20
a followup patch. I don't want to change too much the initial cleanups
as he took me a while to find a working path to redo XICS.=20

Thanks,

C.
