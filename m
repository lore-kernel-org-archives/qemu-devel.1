Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghK9-0005MN-H3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cghK8-0004Tk-NA
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cghK8-0004Te-HZ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 19:31:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id 5so2441912pgj.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 16:31:56 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
	<1487255413-14196-4-git-send-email-fred.konrad@greensocs.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a533d6a1-a284-a1fb-d0f2-0d3a9b3d0c72@twiddle.net>
Date: Thu, 23 Feb 2017 11:31:49 +1100
MIME-Version: 1.0
In-Reply-To: <1487255413-14196-4-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V1 3/7] cputlb: fix the way
 get_page_addr_code fills the tlb
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
> get_page_addr_code(..) does a cpu_ldub_code to fill the tlb:
> This can lead to some side effects if a device is mapped at this address.
>
> So this patch replaces the cpu_memory_ld by a tlb_fill.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  cputlb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
