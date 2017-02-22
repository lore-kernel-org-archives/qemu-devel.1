Received: from eggs.gnu.org ([2001:4830:134:3::10]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgaby-0005xm-9G
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgabv-00036U-Mv
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:21:54 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-6-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <50c2c84a-1c89-a8ef-0fa3-696f75b925b1@twiddle.net>
Date: Thu, 23 Feb 2017 04:21:43 +1100
MIME-Version: 1.0
In-Reply-To: <1487763883-4877-6-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] target/ppc: update ca32 in
 arithmetic substract
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

On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
> +    if (sub) {
> +        tcg_gen_not_tl(t0, arg0);
> +        tcg_gen_xor_tl(t0, t0, arg1);

tcg_gen_eqv_tl.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
