Received: from eggs.gnu.org ([2001:4830:134:3::10]:33158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTArM-0005sg-9S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTArH-000506-C7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:14:20 -0500
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:42634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTArH-0004zs-5J
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:14:15 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id C5F286CD5E
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 18:14:13 +0100 (CET)
References: <1480434248-27138-1-git-send-email-clg@kaod.org>
	<1480434248-27138-28-git-send-email-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16bf90e2-8538-ac01-bd62-1333f80854ee@kaod.org>
Date: Mon, 16 Jan 2017 18:14:04 +0100
MIME-Version: 1.0
In-Reply-To: <1480434248-27138-28-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 27/30] wdt: Add Aspeed watchdog
 device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Marcin Krzeminski <marcin.krzeminski@nokia.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Joel Stanley <joel@jms.id.au>

On 11/29/2016 04:44 PM, C=C3=A9dric Le Goater wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> The Aspeed SoC includes a set of watchdog timers using 32-bit
> decrement counters, which can be based either on the APB clock or
> a 1 MHz clock.
>=20
> The watchdog timer is designed to prevent system deadlock and, in
> general, it should be restarted before timeout. When a timeout occurs,
> different types of signals can be generated, ARM reset, SOC reset,
> System reset, CPU Interrupt, external signal or boot from alternate
> block. The current model only performs the system reset function as
> this is used by U-Boot and Linux.
>=20

Shall I resend the 3/4 patches related to the watchdog in a separate
patchset ?=20

Thanks,

C.=20
