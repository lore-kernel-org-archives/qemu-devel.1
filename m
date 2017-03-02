Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cjI2M-0003DO-Ky
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1cjI2L-0006iX-JQ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:08:18 -0500
MIME-Version: 1.0
In-Reply-To: <32926f1f-ec40-420f-210b-8f5991cc9d67@twiddle.net>
References: <1488381854-7275-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<20170302002933.GL12571@umbus.fritz.box>
	<32926f1f-ec40-420f-210b-8f5991cc9d67@twiddle.net>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Thu, 2 Mar 2017 09:38:14 +0530
Message-ID: <CALAZu3_e8AWbOpASxY9s97AyNd+CX=BYCMx3g4KrG2Ki6w1CZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] target/ppc: rewrite
 f[n]m[add, sub] using float64_muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, bharata@linux.vnet.ibm.com

On 02-Mar-2017 7:53 AM, "Richard Henderson" <rth@twiddle.net> wrote:

On 03/02/2017 11:29 AM, David Gibson wrote:

> On Wed, Mar 01, 2017 at 08:54:14PM +0530, Nikunj A Dadhania wrote:
>
>> Use the softfloat api for fused multiply-add. Also, generate VXISI using
>> a helper function by computing intermediate result.
>>
>
> Um.. I really need some information on why this is a good thing to
> do.  Is it a bugfix?  Enhancement? Simplification?
>

Looks like a bugfix to me.  Previously we were attempting the operation via
float128 as an intermediate type, which can result in double rounding
errors.

Was discussed here

https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02000.html

Nikunj
