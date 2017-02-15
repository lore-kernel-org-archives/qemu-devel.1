Received: from eggs.gnu.org ([2001:4830:134:3::10]:48407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce7pb-0001ul-VR
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ce7pb-0006x6-5S
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 17:13:47 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <44595100-389c-18ee-6355-2d1355577187@twiddle.net>
Date: Thu, 16 Feb 2017 09:13:31 +1100
MIME-Version: 1.0
In-Reply-To: <1487140636-19955-1-git-send-email-bharata@linux.vnet.ibm.com>
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
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, nikunj@linux.vnet.ibm.com, david@gibson.dropbear.id.au

On 02/15/2017 05:37 PM, Bharata B Rao wrote:
> + *
> + * TODO: When float128_muladd() becomes available, switch this
> + * implementation to use that instead of separate float128_mul()
> + * followed by float128_add().

Let's just do that, rather than add something that can't pass tests.

You should be able to copy float64_muladd and, for the most part, s/128/256/ 
and s/64/128/.  Other of the magic numbers, like the implicit bit and the 
exponent bias, you get from float128_mul.


r~
