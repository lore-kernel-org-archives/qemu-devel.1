Received: from eggs.gnu.org ([2001:4830:134:3::10]:33035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1eEEmt-000338-37
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1eEEms-0000UN-8u
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:28:31 -0500
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <d67d5e55-95e1-8858-2005-7df5a3c94cba@kaod.org>
References: <20171108032427.11163-1-joel@jms.id.au>
	<d67d5e55-95e1-8858-2005-7df5a3c94cba@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 13 Nov 2017 23:58:05 +1030
Message-ID: <CACPK8Xc3gS0Og5Zbw2RE9RTjbn9xDkTB0cHGrEPUWMHe4FLV8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/aspeed: Unlock SCU when running
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>

On Thu, Nov 9, 2017 at 5:54 PM, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 11/08/2017 04:24 AM, Joel Stanley wrote:

>> --- a/hw/misc/aspeed_sdmc.c
>> +++ b/hw/misc/aspeed_sdmc.c
>> @@ -18,7 +18,6 @@
>>
>>  /* Protection Key Register */
>>  #define R_PROT            (0x00 / 4)
>> -#define   PROT_KEY_UNLOCK     0xFC600309
>
> why are you using the memory controller magic value ?

Oh. My bad. I think both ctags and myself became confused :)

>> --- a/include/hw/misc/aspeed_sdmc.h
>> +++ b/include/hw/misc/aspeed_sdmc.h
>> @@ -16,6 +16,8 @@
>>
>>  #define ASPEED_SDMC_NR_REGS (0x8 >> 2)
>>
>> +#define PROT_KEY_UNLOCK 0xFC600309
>
> Ditto. Should we be using the one from SCU ?
>
> Now that we are externalizing this value, adding a prefix would be
> preferable : ASPEED_SCU_ ?

I will grab the correct value from the SCU and rename it
ASPEED_SCU_PROT_KEY for v2.

Thanks for taking a look.

Cheers,

Joel
