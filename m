Received: from eggs.gnu.org ([2001:4830:134:3::10]:41890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGNn-0000km-5T
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjGNk-0006ub-26
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 21:22:19 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170302002933.GL12571@umbus.fritz.box>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <32926f1f-ec40-420f-210b-8f5991cc9d67@twiddle.net>
Date: Thu, 2 Mar 2017 13:22:05 +1100
MIME-Version: 1.0
In-Reply-To: <20170302002933.GL12571@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target/ppc: rewrite f[n]m[add,
 sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 03/02/2017 11:29 AM, David Gibson wrote:
> On Wed, Mar 01, 2017 at 08:54:14PM +0530, Nikunj A Dadhania wrote:
>> Use the softfloat api for fused multiply-add. Also, generate VXISI using
>> a helper function by computing intermediate result.
>
> Um.. I really need some information on why this is a good thing to
> do.  Is it a bugfix?  Enhancement? Simplification?

Looks like a bugfix to me.  Previously we were attempting the operation via 
float128 as an intermediate type, which can result in double rounding errors.


r~
