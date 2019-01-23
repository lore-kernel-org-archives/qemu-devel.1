Received: from eggs.gnu.org ([209.51.188.92]:43757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmQOC-0002zK-Jm
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:48:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmQ8q-00052z-WA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:33:04 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Wed, 23 Jan 2019 21:32:35 +0000
Message-ID: <20190123213227.17077-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v11 0/2] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay OS <aaron@os.amperecomputing.com>

Most of this patchset to implement the PMU has been merged already, but
the interrupt-on-overflow behavior had some additional review comments.
In addition to improving the overflow detection and bit-clearing logic,
I split the previous patch [1] into two to (hopefully) make it more
digestable.

There is also a separate bugfix for one of the the already-merged
patches which I already sent out separately as "target/arm: Don't clear
supported PMU events when initializing PMCEID1" [2].

[1] - https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02242.html
[2] - https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05996.html

Aaron Lindsay (2):
  target/arm: Send interrupts on PMU counter overflow
  target/arm: Add a timer to predict PMU counter overflow

 target/arm/cpu.c    |  12 ++++
 target/arm/cpu.h    |  10 ++++
 target/arm/helper.c | 133 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 143 insertions(+), 12 deletions(-)

--=20
2.20.1
