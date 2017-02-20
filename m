Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu8p-0000xw-Cn
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfu8l-0003ew-Bd
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:00:59 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-10-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5dc4d32e-cc1f-82c2-9215-49c428035b0b@twiddle.net>
Date: Tue, 21 Feb 2017 07:00:47 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-10-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/10] target/ppc: add ov32 flag in
 divide operations
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

On 02/20/2017 09:12 PM, Nikunj A Dadhania wrote:
> Add helper_div_compute_ov() in the int_helper for updating the overflow
> flags.
>
> For Divide Word:
> SO, OV, and OV32 bits reflects overflow of the 32-bit result
>
> For Divide DoubleWord:
> SO, OV, and OV32 bits reflects overflow of the 64-bit result
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/int_helper.c | 49 ++++++++++++++++---------------------------------
>  target/ppc/translate.c  |  6 ++++--
>  2 files changed, 20 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
