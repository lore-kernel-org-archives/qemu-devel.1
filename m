Received: from eggs.gnu.org ([2001:4830:134:3::10]:44775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghJZ-0004s0-BD
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghJY-0004P7-KV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:21 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cghJY-0004P1-F3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:20 -0500
Received: by mail-pf0-x243.google.com with SMTP id 68so485080pfx.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 16:31:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
	<1487255413-14196-3-git-send-email-fred.konrad@greensocs.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9ba34902-ca60-62d4-c84c-9d6a9cc639ce@twiddle.net>
Date: Thu, 23 Feb 2017 11:31:14 +1100
MIME-Version: 1.0
In-Reply-To: <1487255413-14196-3-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 2/7] cputlb: move get_page_addr_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com, clg@kaod.org, pbonzini@redhat.com

On 02/17/2017 01:30 AM, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> This just moves the code before VICTIM_TLB_HIT macro definition
> so we can use it.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  cputlb.c | 72 ++++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
