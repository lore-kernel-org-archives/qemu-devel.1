Received: from eggs.gnu.org ([2001:4830:134:3::10]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNlZ4-000698-IK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gNlZ0-0004Fg-Kg
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 16:22:10 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 16 Nov 2018 21:22:03 +0000
Message-ID: <20181116212154.GG23658@quinoa.localdomain>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
	<20181105185046.2802-13-aaron@os.amperecomputing.com>
In-Reply-To: <20181105185046.2802-13-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B650467DAD4ADA47A566F14838B0E284@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 12/12] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Nov 05 13:52, Aaron Lindsay wrote:
> Setup a QEMUTimer to get a callback when we expect counters to next
> overflow and trigger an interrupt at that time.

Peter,

It looks like there's probably going to be at least a v8 in this series
since you've made a few comments which require changes. But I don't
think this final patch has ever received any review comments from
anyone, and I suspect it's not because it's perfect...

Would you mind taking a look at this one during your review if you can
find time?

Thanks!

-Aaron
