Received: from eggs.gnu.org ([208.118.235.92]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1gfBuy-0004Nv-Px
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1gfBuv-0008Pa-Lo
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:56:48 -0500
Date: Fri, 4 Jan 2019 01:56:41 +0300
From: Antony Pavlov <antonynpavlov@gmail.com>
Message-Id: <20190104015641.e6d525f098c5e272694faa62@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] barebox on Canon A1100
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Barebox List <barebox@lists.infradead.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hi Sascha!

I have some good news and some bad news.

First the good news.

Barebox was used for Day 18 of QEMU 2018 advent (https://www.qemu-advent-ca=
lendar.org/2018/).

Here is a quote:

  > This is an image for QEMU's emulated Canon A1100 Arm machine:
  > Play 2048 in the Barebox firmware environment.

The bad news.

Current master branch barebox for Canon A1100 does not work under qemu,
barebox v2017.02.0 was used for qemu advent.

Thomas Huth reported the problem in the qemu-devel mailing
list two months ago. Please see https://www.mail-archive.com/qemu-devel@non=
gnu.org/msg571887.html
for details.

The commit a43e2bbc468a71 breaks barebox for Canon A1100:

  > commit a43e2bbc468a71fb8825e8acafb7fac7ad7c6dad
  > Author: Sascha Hauer <s.hauer@pengutronix.de>
  > Date:   Wed Mar 7 10:04:07 2018 +0100
  >
  >    ARM: return positive offset in get_runtime_offset()

Any suggestion?

--=20
Best regards,
=A0 Antony Pavlov
