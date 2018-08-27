Received: from eggs.gnu.org ([2001:4830:134:3::10]:49376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fuIoa-0002nb-P5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aclindsa@gmail.com>) id 1fuIoa-000621-42
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:48:24 -0400
Date: Mon, 27 Aug 2018 10:48:17 -0400
From: Aaron Lindsay <aclindsa@gmail.com>
Message-ID: <20180827144809.GA3671@okra.localdomain>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-13-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-dBq8vTB8sqxJ7_FjeHrteS58J-+2i_iYFH6iH6GWXMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-dBq8vTB8sqxJ7_FjeHrteS58J-+2i_iYFH6iH6GWXMw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 12/13] target/arm: Mark PMINTENSET
 accesses as possibly doing IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Aaron Lindsay <aaron@amperecomputing.com>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <michael.spradling@amperecomputing.com>

On Jun 28 17:25, Peter Maydell wrote:
> Shouldn't PMINTENCLR and PMINTENCLR_EL1 also be ARM_CP_IO ?

Yes, that was an oversight - I've added a patch addressing this for v6.

-Aaron
