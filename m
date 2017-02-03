Received: from eggs.gnu.org ([2001:4830:134:3::10]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdIt-0005bL-Pw
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdIt-0007C3-0Q
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:49:27 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdIs-0007Av-OZ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:49:26 -0500
Received: by mail-wm0-x234.google.com with SMTP id v77so26526067wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 04:49:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485452251-1593-1-git-send-email-clg@kaod.org>
References: <1485452251-1593-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 12:49:05 +0000
Message-ID: <CAFEAcA_41U=7UnFdeh-drFJXYFGc3VScPKzwE9qm2O91fKep_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Aspeed watchdog controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>

On 26 January 2017 at 17:37, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Hello,
>
> The Aspeed SoC includes a set of watchdog timers using 32-bit
> decrement counters. This patchset provides a model for this controller
> and adds the first watchdog to the Aspeed SoC model. A second watchdog
> exists and is used on real HW to boot from a second flash module
> containing a golden image of the firmware. This is not supported yet
> in qemu.
>
> The main benefit today of this model is to enables reboot/reset of a
> guest from U-Boot and Linux.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (2):
>   wdt: Add Aspeed watchdog device model
>   aspeed: add a watchdog controller



Applied to target-arm.next, thanks.

-- PMM
