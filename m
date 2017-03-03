Received: from eggs.gnu.org ([2001:4830:134:3::10]:47754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjsfv-0000e5-E9
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cjsfs-0004zr-8L
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:15:35 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1488524289-5305-3-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <03c6d1af-266e-3bed-4475-683200d238e8@twiddle.net>
Date: Sat, 4 Mar 2017 06:15:25 +1100
MIME-Version: 1.0
In-Reply-To: <1488524289-5305-3-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: fmadd: add macro for
 updating flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 03/03/2017 05:58 PM, Nikunj A Dadhania wrote:
> +#define FPU_MADDSUB_UPDATE(name, tp)                                    \
> +static void name(CPUPPCState *env, float64 arg1,                        \
> +                 float64 arg2, float64 arg3,                            \
> +                 unsigned int madd_flags)                               \

Use ALL CAPS for macro arguments which you paste.
You forgot to use TP for arg{1,2,3}.


r~
