Received: from eggs.gnu.org ([2001:4830:134:3::10]:45665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUWGi-0006TA-Sk
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUWGd-00045m-SW
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:18:04 -0500
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:47866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cUWGd-00044D-LD
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:17:59 -0500
Received: from player758.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1730D3CCE3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:17:52 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-8-git-send-email-clg@kaod.org>
	<CAFEAcA_tLcVQj_kJh3iY7ZOEechPrk=9+Hj3_QcOE+pmPoWCYg@mail.gmail.com>
	<549b1cd1-602b-8b74-add6-0648f6426694@kaod.org>
	<CAFEAcA-YBm9WRELebX5P8MnRq86mQBonDLGcDxM0_mkLn4xuKA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <055228dc-a145-cbcf-06e4-7bc902f71f73@kaod.org>
Date: Fri, 20 Jan 2017 11:17:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-YBm9WRELebX5P8MnRq86mQBonDLGcDxM0_mkLn4xuKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/11] aspeed/smc: handle SPI flash
 Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcin Krzeminski <marcin.krzeminski@nokia.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 01/20/2017 11:13 AM, Peter Maydell wrote:
> On 19 January 2017 at 20:35, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> On 01/19/2017 08:26 PM, Peter Maydell wrote:
>>> On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>>> accesses to the flash content are no different than doing MMIOs. The
>>>> controller generates all the necessary commands to load (or store)
>>>> data in memory.
>>>>
>>>> However, accesses are restricted to the segment window assigned the
>>>> the flash module by the controller. This window is defined by the
>>>> Segment Address Register.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>>> ---
>>>>  hw/ssi/aspeed_smc.c         | 152 +++++++++++++++++++++++++++++++++=
+++++------
>>>>  include/hw/ssi/aspeed_smc.h |   2 +-
>>>>  2 files changed, 132 insertions(+), 22 deletions(-)
>>>
>>> This deleted the only call to aspeed_smc_is_usermode() but not
>>> its definition, which makes clang complain:
>>> /Users/pm215/src/qemu-for-merges/hw/ssi/aspeed_smc.c:409:20: error:
>>> unused function 'aspeed_smc_is_usermode' [-Werror,-Wunused-function]
>>>
>>> Presumably the function itself should be deleted?
>>
>> yes. This is correct. I will send a patch for it.
>=20
> I'll just edit the commit in my target-arm tree, that
> will be simplest.

ok. sure.=20

I do push a branch on github before sending for travis to test.
Should that error have been caught by travis ? Just asking, as
I might have missed it.

Thanks,

C.  =20
