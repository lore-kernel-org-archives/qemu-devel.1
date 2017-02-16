Received: from eggs.gnu.org ([2001:4830:134:3::10]:39571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceT3U-0003Mw-V2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceT3U-0002tr-Ap
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:53:33 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com>
	<44595100-389c-18ee-6355-2d1355577187@twiddle.net>
	<20170216024126.GA17196@in.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b2492a5c-51c5-834c-4d99-c055d78d1f67@twiddle.net>
Date: Fri, 17 Feb 2017 07:53:20 +1100
MIME-Version: 1.0
In-Reply-To: <20170216024126.GA17196@in.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-ppc: Add quad precision muladd
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au

On 02/16/2017 01:41 PM, Bharata B Rao wrote:
> For some reason float128_mul implements
> multipliction via multiplication and addition (mul128To256 & add128). There
> is no equivalent to this in float64_muladd.

Yes, I don't understand that myself.  It really appears to be a bug.


r~
