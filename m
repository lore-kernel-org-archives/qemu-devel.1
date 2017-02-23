Received: from eggs.gnu.org ([2001:4830:134:3::10]:50446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgtQN-0006VL-BS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgtQK-0006sl-2O
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:27:11 -0500
Received: from greensocs.com ([193.104.36.180]:60694)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cgtQJ-0006sO-PO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:27:08 -0500
References: <1487255413-14196-1-git-send-email-fred.konrad@greensocs.com>
	<1487255413-14196-4-git-send-email-fred.konrad@greensocs.com>
	<a533d6a1-a284-a1fb-d0f2-0d3a9b3d0c72@twiddle.net>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <e7f4c366-fb45-dc1b-a406-0369c889502f@greensocs.com>
Date: Thu, 23 Feb 2017 14:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <a533d6a1-a284-a1fb-d0f2-0d3a9b3d0c72@twiddle.net>
Content-Type: text/plain; charset=windows-1252
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com, clg@kaod.org, pbonzini@redhat.com

On 02/23/2017 01:31 AM, Richard Henderson wrote:
> On 02/17/2017 01:30 AM, fred.konrad@greensocs.com wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> get_page_addr_code(..) does a cpu_ldub_code to fill the tlb:
>> This can lead to some side effects if a device is mapped at this address.
>>
>> So this patch replaces the cpu_memory_ld by a tlb_fill.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>> ---
>>  cputlb.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> 
> 
> r~

Thanks!
Fred
