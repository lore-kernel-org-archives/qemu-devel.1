Received: from eggs.gnu.org ([2001:4830:134:3::10]:44405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxnY-0004us-R1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxnY-0007cI-4P
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:15:32 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-12-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8e4a0e60-c44a-5591-9b91-b77bd1e1b2c1@twiddle.net>
Date: Mon, 5 Dec 2016 10:15:28 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-12-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/13] target-ppc: implement xsnegqp
 instruction
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

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> +    case OP_NEG:                                                  \
> +        tcg_gen_xor_i64(xbh, xbh, sgm);                           \
> +        tcg_gen_xori_i64(xbl, xbl, 0);                            \
> +        break;                                                    \

No point in the xori.


r~
