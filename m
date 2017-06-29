Received: from eggs.gnu.org ([2001:4830:134:3::10]:60162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYcn-0000Q6-MF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQYcm-0001bE-R9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:32:45 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQYcm-0001aF-Ir
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:32:44 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w126so80765865wme.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 05:32:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6c9540fe-9acb-c1ab-9f19-b59682b8fd4c@kaod.org>
References: <20170628114717.22349-1-joel@jms.id.au>
	<6c9540fe-9acb-c1ab-9f19-b59682b8fd4c@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 13:32:22 +0100
Message-ID: <CAFEAcA9KJYgLL8aihcGhNxC47_h=6yAV193XgzFt7UJ7eEEdsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] aspeed: Register all watchdogs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 June 2017 at 12:57, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 06/28/2017 01:47 PM, Joel Stanley wrote:
>> The ast2400 contains two and the ast2500 contains three watchdogs.
>> Add this information to the AspeedSoCInfo and realise the correct number
>> of watchdogs for that each SoC type.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>

Thanks, applied to target-arm.next.

> Reviewed-and-tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

PS: toooling generally doesn't understand this sort of
ad-hoc tag, so it's probably better to use separate
Reviewed-by: and Tested-by: lines if you want to say both.

thanks
-- PMM
