Received: from eggs.gnu.org ([2001:4830:134:3::10]:45406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1yE-0003pg-MS
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch1yB-0005HL-ID
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:34:42 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
Date: Fri, 24 Feb 2017 09:34:32 +1100
MIME-Version: 1.0
In-Reply-To: <87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
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

On 02/23/2017 05:40 PM, Nikunj A Dadhania wrote:
> Richard Henderson <rth@twiddle.net> writes:
>> These functions are becoming quite large.  Are they performance critical enough
>> that they need to stay as inline code, or should they be moved to helpers and
>> share code with cpu_read/write_xer?
>
> Just to boot to login prompt, these are the numbers for gen_read/write_xer:
>
> helper_myprint - rd_count 231103, wr_count 68897
>
> And it keeps on incrementing, maybe scope of optimization here.

That's not very large considering the total number of instructions executed 
during a boot to prompt.

Thoughts, David?


r~
