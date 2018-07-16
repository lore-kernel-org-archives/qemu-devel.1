Received: from eggs.gnu.org ([2001:4830:134:3::10]:46279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fezVQ-0005G9-Hb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fezVP-0005DW-JP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:09:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fezVP-0005D6-DA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:09:19 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so73342265oib.10
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 02:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
References: <1531692369-1511-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 10:08:58 +0100
Message-ID: <CAFEAcA9W88G8rd4iMq7qsNd2C2fRiYJ32dVooZLyzY10__5piw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] hw: arm: Add basic support for cprman
 (clock subsystem)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>

On 15 July 2018 at 23:06, Guenter Roeck <linux@roeck-us.net> wrote:
> Add basic support for BCM283x CPRMAN. Provide support for reading and
> writing CPRMAN registers and initialize registers with sensible default
> values. During runtime retain any written values.
>
> Basic CPRMAN support is necessary and sufficient to boot Linux on raspi2
> and raspi3 systems.

I can boot Linux on raspi3 with current upstream's level
of cprman support:
https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry-pi-3-model/

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I don't seriously expect this patch to get accepted, but I thought
> it might be valuable enough for others to use it when playing with
> raspi2 and raspi3 emulations.

I'm not necessarily going to rule it out entirely, but I'm
definitely not very happy about having a model of hardware
that's very clearly "do something that Linux likes". I'd
really rather see hardware documentation here -- presumably
whoever is writing the Linux drivers has that?

thanks
-- PMM
