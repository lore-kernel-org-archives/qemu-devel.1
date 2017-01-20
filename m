Received: from eggs.gnu.org ([2001:4830:134:3::10]:44734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWCI-0004Pp-1N
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUWCH-00023b-25
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:13:30 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:36123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUWCG-00022Y-Rg
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 05:13:28 -0500
Received: by mail-vk0-x22d.google.com with SMTP id t8so48470180vke.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 02:13:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <549b1cd1-602b-8b74-add6-0648f6426694@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-8-git-send-email-clg@kaod.org>
	<CAFEAcA_tLcVQj_kJh3iY7ZOEechPrk=9+Hj3_QcOE+pmPoWCYg@mail.gmail.com>
	<549b1cd1-602b-8b74-add6-0648f6426694@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 10:13:07 +0000
Message-ID: <CAFEAcA-YBm9WRELebX5P8MnRq86mQBonDLGcDxM0_mkLn4xuKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <marcin.krzeminski@nokia.com>

On 19 January 2017 at 20:35, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 01/19/2017 08:26 PM, Peter Maydell wrote:
>> On 9 January 2017 at 16:24, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>> The Aspeed SMC controllers have a mode (Command mode) in which
>>> accesses to the flash content are no different than doing MMIOs. The
>>> controller generates all the necessary commands to load (or store)
>>> data in memory.
>>>
>>> However, accesses are restricted to the segment window assigned the
>>> the flash module by the controller. This window is defined by the
>>> Segment Address Register.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>  hw/ssi/aspeed_smc.c         | 152 ++++++++++++++++++++++++++++++++++++=
++------
>>>  include/hw/ssi/aspeed_smc.h |   2 +-
>>>  2 files changed, 132 insertions(+), 22 deletions(-)
>>
>> This deleted the only call to aspeed_smc_is_usermode() but not
>> its definition, which makes clang complain:
>> /Users/pm215/src/qemu-for-merges/hw/ssi/aspeed_smc.c:409:20: error:
>> unused function 'aspeed_smc_is_usermode' [-Werror,-Wunused-function]
>>
>> Presumably the function itself should be deleted?
>
> yes. This is correct. I will send a patch for it.

I'll just edit the commit in my target-arm tree, that
will be simplest.

thanks
-- PMM
