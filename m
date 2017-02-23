Received: from eggs.gnu.org ([2001:4830:134:3::10]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghJT-0004q7-Kh
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghJO-0004Nv-VR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:15 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cghJO-0004Mp-Oj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:10 -0500
Received: by mail-pg0-x243.google.com with SMTP id 5so2439730pgj.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 16:31:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
	<1487255413-14196-2-git-send-email-fred.konrad@greensocs.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <42260ce3-beee-a0f6-a5de-e81fc3ba6120@twiddle.net>
Date: Thu, 23 Feb 2017 11:31:00 +1100
MIME-Version: 1.0
In-Reply-To: <1487255413-14196-2-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 1/7] cputlb: cleanup get_page_addr_code
 to use VICTIM_TLB_HIT
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
> This replaces env1 and page_index variables by env and index
> so we can use VICTIM_TLB_HIT macro later.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  cputlb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
