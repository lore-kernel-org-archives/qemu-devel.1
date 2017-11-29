Received: from eggs.gnu.org ([2001:4830:134:3::10]:38922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJzLa-0001vZ-Bb
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJzLW-0005kl-IO
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:12:06 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJzLW-0005k3-CT
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:12:02 -0500
Received: by mail-oi0-x22b.google.com with SMTP id t81so1998983oih.13
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 02:12:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <17d7270b-9016-face-5fba-c6e321e92d88@kaod.org>
References: <20171019151249.13663-1-clg@kaod.org>
	<17d7270b-9016-face-5fba-c6e321e92d88@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 10:11:41 +0000
Message-ID: <CAFEAcA-_7DVpck4wKsLSvpMdAZTKCFK+j3Q1F5OvAo2TT+5ZWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/8] aspeed: add a witherspoon-bmc
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 29 November 2017 at 09:58, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 10/19/2017 05:12 PM, C=C3=A9dric Le Goater wrote:
>>  - introduce a dummy ROM device to catch invalid writes
>>  - removed 'ignore_memory_transaction_failures' on all Aspeed machines
>
> So that was a bad idea because old firwmares run load/store loops
> beyond the address space to guess how much RAM the SoC has.
>
> I am wondering if it is possible to model the same behavior with
> a MMIO region (of a correct size depending on the max ram size of
> the SoC) and mapped beyond the RAM region to catch such accesses
> and keep 'ignore_memory_transaction_failures' to false.

Yeah, if the hardware genuinely ignores accesses to a particular
region of the address space then you can model this with an
appropriate background memory region. You just need to figure
out what range of the address space it should apply to...

thanks
-- PMM
