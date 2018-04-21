Received: from eggs.gnu.org ([2001:4830:134:3::10]:41160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9oub-0004ys-JR
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9oua-0001SM-TO
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:34:29 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:40437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9oua-0001Rl-OE
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 05:34:28 -0400
Received: by mail-ot0-x22b.google.com with SMTP id h8-v6so12183912otj.7
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 02:34:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f80b3748-12d4-de8b-1661-e07a7d33b60a@kaod.org>
References: <20180420124835.7268-1-peter.maydell@linaro.org>
	<20180420124835.7268-3-peter.maydell@linaro.org>
	<f80b3748-12d4-de8b-1661-e07a7d33b60a@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Apr 2018 10:34:07 +0100
Message-ID: <CAFEAcA8g_qcXj7ErMNODexU4k2k56nYUSzoh3WX06mZTVRMLLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/aspeed: don't make 'boot_rom'
 region 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Rob Herring <robh@kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 21 April 2018 at 10:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/20/2018 02:48 PM, Peter Maydell wrote:
>> Currently we use memory_region_init_ram_nomigrate() to create
>> the "aspeed.boot_rom" memory region, and we don't manually
>> register it with vmstate_register_ram(). This currently
>> means that its contents are migrated but as a ram block
>> whose name is the empty string; in future it may mean they
>> are not migrated at all. Use memory_region_init_ram() instead.
>>
>> Note that this is a cross-version migration compatibility break
>> for the "palmetto-bmc", "ast2500-evb" and "romulus-bmc" machines.
>
> Migration does not work for these.

Well, at least we're not breaking anything :-)
Do you know why migration doesn't work?

thanks
-- PMM
