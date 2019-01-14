Received: from eggs.gnu.org ([209.51.188.92]:51956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizZh-0006sq-HY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizZd-0006b9-R6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:34:30 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gizZX-0006Ld-0Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:34:25 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so17480290oib.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20181031025712.18602-1-famz@redhat.com>
	<4f6eb24d-fe13-cbf3-907e-6b3e566e33f4@comstyle.com>
	<20181114095807.GB22784@magic> <20190109135504.GA12179@redhat.com>
	<20190109135917.GP3998@redhat.com>
	<A3EA5405-A5EE-4E77-8C77-A67398756B96@euphon.net>
	<20190114101515.GA3686@redhat.com>
In-Reply-To: <20190114101515.GA3686@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 10:34:10 +0000
Message-ID: <CAFEAcA9GirJMSOp284KbX8tGaQ9CxHWCq=_nAhvdyFM6Q0fvYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>

On Mon, 14 Jan 2019 at 10:20, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> If you don't have SDL then there's no audio driver impl available for
> QEMU, so configure fails with:
>
>   ERROR: sdl not found or disabled, can not use sdl audio driver

Ideally we should fix configure/the audio driver selection
logic so that if SDL is not available or disabled then
'sdl' is removed from the set of possible audio devices
and not selected as the default for OpenBSD (and if necessary
fix things so we can build a QEMU with no audio drivers at all,
falling back to the null driver, ie no sound).

It would also be good to make the various BSD images have
SDL2 installed, for the compile coverage.

thanks
-- PMM
