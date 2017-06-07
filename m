Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIc8D-00075g-3G
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIc8C-0001rm-79
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:40:21 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIc8C-0001rZ-0d
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:40:20 -0400
Received: by mail-wm0-x232.google.com with SMTP id x70so59422605wme.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:40:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496739230-32109-1-git-send-email-clg@kaod.org>
References: <1496739230-32109-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 15:39:58 +0100
Message-ID: <CAFEAcA9ipPsZm9Vvbie-V8tw=SQKGvPS4B60K1z8ZdtmReU+tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] aspeed: add a TMP421 device to the
 palmetto machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 09:53, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> This series fixes issues in the TMP421 model previously sent and adds
> such a device to the palmetto machine.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (2):
>   hw/misc: add a TMP42{1,2,3} device model
>   aspeed: add a temp sensor device on I2C bus 3
>
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/aspeed.c                 |   9 +
>  hw/misc/Makefile.objs           |   1 +
>  hw/misc/tmp421.c                | 402 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 hw/misc/tmp421.c



Applied to target-arm.next, thanks.

-- PMM
