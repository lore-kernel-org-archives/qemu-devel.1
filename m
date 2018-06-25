Received: from eggs.gnu.org ([2001:4830:134:3::10]:44010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fXJXc-0003RS-50
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 00:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fXJXb-0000lF-Db
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 00:55:52 -0400
References: <20180619093124.24011-1-luc.michel@greensocs.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
Date: Mon, 25 Jun 2018 06:55:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180619093124.24011-1-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, mark.burton@greensocs.com

On 2018-06-19 11:31, luc.michel@greensocs.com wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
> 
> This patch series add support for the virtualization extensions in the
> ARM GICv2 interrupt controller.
> 
> The first two commits do some refactoring to prepare for the
> implementation. Commits 3 and 4 are the actual implementation. The last
> commit updates the ZynqMP implementation to support virtualization.

Is it enabled for the virt machine as well? Seems we are missing some
mapping of GICV and GICH there.

And what is the recommended way to get the ZynqMP model running? I've a
kernel that works on a ZCU102, but just passing it via -kernel to the
QEMU model seems insufficient.

Jan
