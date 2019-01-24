Received: from eggs.gnu.org ([209.51.188.92]:46078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmhnz-0003dw-Ea
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gmhny-0005fr-4Y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:24:39 -0500
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Date: Thu, 24 Jan 2019 16:24:10 +0000
Message-ID: <20190124162401.5111-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v12 0/2] More fully implement ARM PMUv3
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

Most of this patchset implementing the PMU has been merged already, but
the interrupt-on-overflow behavior had some additional review comments.
This most recent version fixes a type promotion issue and adds Richard's
Reviewed-by's.

Aaron Lindsay (2):
  target/arm: Send interrupts on PMU counter overflow
  target/arm: Add a timer to predict PMU counter overflow

 target/arm/cpu.c    |  12 ++++
 target/arm/cpu.h    |  10 ++++
 target/arm/helper.c | 133 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 143 insertions(+), 12 deletions(-)

--=20
2.20.1
