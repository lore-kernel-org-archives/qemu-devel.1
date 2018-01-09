Received: from eggs.gnu.org ([2001:4830:134:3::10]:56274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwa8-00023m-H3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwa7-0000Tn-OQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:16:56 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:36946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYwa7-0000TB-JV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:16:55 -0500
Received: by mail-oi0-x22c.google.com with SMTP id e144so5438490oib.4
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:16:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:16:34 +0000
Message-ID: <CAFEAcA9ME7MpBySJ1XFZ+fSb9JrT1mKL9Ns3uVviuOpbteHA6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] Reset SD cards attached to
 legacy-API controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 9 January 2018 at 16:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> I didn't test migrating a card (but have a "sdcard migration qtest"
> entry in my TODO).

I usually test not by actually migrating but using 'savevm foo' in
the monitor to save a snapshot and then -loadvm foo on the command
line to resume it.

thanks
-- PMM
