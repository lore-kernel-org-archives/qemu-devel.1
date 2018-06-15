Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTm55-0006my-Ab
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTm54-0006I5-AT
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:35:47 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTm54-0006GS-5I
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:35:46 -0400
Received: by mail-ot0-x241.google.com with SMTP id 101-v6so10476835oth.4
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:35:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180613114836.9265-1-joel@jms.id.au>
References: <20180613114836.9265-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:35:25 +0100
Message-ID: <CAFEAcA9zpvd2Ztmc9pAiSkv3g1m3H=udqtek2gv0oA+2dvFZtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 13 June 2018 at 12:48, Joel Stanley <joel@jms.id.au> wrote:
> The ASPEED SoCs contain a single register that returns random data when
> read. This models that register so that guests can use it.
>
> The random number data register has a corresponding control register,
> however it returns data regardless of the state of the enabled bit, so
> the model follows this behaviour.
>
> When the qcrypto call fails we exit as the guest uses the random number
> device to feed it's entropy pool, which is used for cryptographic
> purposes.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---



Applied to target-arm.next, thanks.

-- PMM
