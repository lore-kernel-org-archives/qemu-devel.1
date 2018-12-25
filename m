Received: from eggs.gnu.org ([208.118.235.92]:56560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gbwMO-0001bB-0y
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 18:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gbwMN-0003vl-46
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 18:43:39 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36]:39223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gbwMN-0003vO-0R
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 18:43:39 -0500
Received: by mail-yb1-xb36.google.com with SMTP id n187so2190402yba.6
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 15:43:38 -0800 (PST)
MIME-Version: 1.0
From: Nick Renieris <makren67@gmail.com>
Date: Wed, 26 Dec 2018 01:43:11 +0200
Message-ID: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

What's the current status on AVX support for TCG? Is there anyone working o=
n it?
Is there interest for it?

Effort was put into making 'TCGv_vec', as elaborated in this talk:

"[2017] Vectoring in on QEMU's TCG Engine by Alex Benn=C3=A9e"
(https://www.youtube.com/watch?v=3DIYHTwnde0g8)

,yet there doesn't seem to be a front-end (except for VEX prefix
parsing) nor a backend for AVX, a pretty common x86 extension.

I'd appreciate any info on this,

Regards,
Nick Renieris.
