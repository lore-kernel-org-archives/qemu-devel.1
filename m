Received: from eggs.gnu.org ([2001:4830:134:3::10]:39036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTrX-0004uq-0H
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTrS-0000aw-Rq
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDTrS-0000RN-Gp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id e17-v6so26633908oig.12
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 05:26:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153995036671.15384.18371512606809407583.malone@gac.canonical.com>
References: <153921596093.13046.16485884973780639345.malonedeb@wampee.canonical.com>
	<153995036671.15384.18371512606809407583.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 13:26:14 +0100
Message-ID: <CAFEAcA8g4zYbTLQ5e1evX6D8pq7eoW=tU7FK3_iZJVxvr3uOdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1797262] Re: qemu arm no longer able to boot
 RPI Kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1797262 <1797262@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 12:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Isn't this likely due to the newer kernel accessing hardware we are not
> emulating properly?

Yes, it will be the missing cprman emulation. There was another
bug/thread on this recently.

thanks
-- PMM
