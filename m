Received: from eggs.gnu.org ([2001:4830:134:3::10]:55345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUXHL-0002va-JC
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cUXHG-0002lI-MB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:22:47 -0500
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:48193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cUXHG-0002iP-GE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 06:22:42 -0500
Received: from player758.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 987953A05E
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 12:22:40 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-8-git-send-email-clg@kaod.org>
	<CAFEAcA_tLcVQj_kJh3iY7ZOEechPrk=9+Hj3_QcOE+pmPoWCYg@mail.gmail.com>
	<549b1cd1-602b-8b74-add6-0648f6426694@kaod.org>
	<CAFEAcA-YBm9WRELebX5P8MnRq86mQBonDLGcDxM0_mkLn4xuKA@mail.gmail.com>
	<055228dc-a145-cbcf-06e4-7bc902f71f73@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <644c3b24-5139-5971-46a3-6764c3da6c76@kaod.org>
Date: Fri, 20 Jan 2017 12:22:36 +0100
MIME-Version: 1.0
In-Reply-To: <055228dc-a145-cbcf-06e4-7bc902f71f73@kaod.org>
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

On 01/20/2017 11:17 AM, C=C3=A9dric Le Goater wrote:
> On 01/20/2017 11:13 AM, Peter Maydell wrote:
>> On 19 January 2017 at 20:35, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>> On 01/19/2017 08:26 PM, Peter Maydell wrote:
>>>> On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>>>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>>>> accesses to the flash content are no different than doing MMIOs. Th=
e
>>>>> controller generates all the necessary commands to load (or store)
>>>>> data in memory.
>>>>>
>>>>> However, accesses are restricted to the segment window assigned the
>>>>> the flash module by the controller. This window is defined by the
>>>>> Segment Address Register.
>>>>>
>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>>>> ---
>>>>>  hw/ssi/aspeed_smc.c         | 152 ++++++++++++++++++++++++++++++++=
++++++------
>>>>>  include/hw/ssi/aspeed_smc.h |   2 +-
>>>>>  2 files changed, 132 insertions(+), 22 deletions(-)
>>>>
>>>> This deleted the only call to aspeed_smc_is_usermode() but not
>>>> its definition, which makes clang complain:
>>>> /Users/pm215/src/qemu-for-merges/hw/ssi/aspeed_smc.c:409:20: error:
>>>> unused function 'aspeed_smc_is_usermode' [-Werror,-Wunused-function]
>>>>
>>>> Presumably the function itself should be deleted?
>>>
>>> yes. This is correct. I will send a patch for it.
>>
>> I'll just edit the commit in my target-arm tree, that
>> will be simplest.
>=20
> ok. sure.=20
>=20
> I do push a branch on github before sending for travis to test.
> Should that error have been caught by travis ? Just asking, as
> I might have missed it.

So I did miss it. I will take a closer look at the logs next time.

Thanks,

C.
