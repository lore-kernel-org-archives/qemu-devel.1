Received: from eggs.gnu.org ([2001:4830:134:3::10]:38265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ch3x1-0005Mb-PJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ch3x1-0007hN-5j
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:41:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170223225358.GD17615@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
	<20170223225358.GD17615@umbus.fritz.box>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Fri, 24 Feb 2017 06:11:30 +0530
Message-ID: <CALAZu3_3TkjFbLUAraQRgG5Ytm0a08QLzQSdYLKF5EYPD-imxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 03/10] target/ppc: support
 for 32-bit carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 24 February 2017 at 04:23, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Feb 24, 2017 at 09:34:32AM +1100, Richard Henderson wrote:
>> On 02/23/2017 05:40 PM, Nikunj A Dadhania wrote:
>> > Richard Henderson <rth@twiddle.net> writes:
>> > > These functions are becoming quite large.  Are they performance critical enough
>> > > that they need to stay as inline code, or should they be moved to helpers and
>> > > share code with cpu_read/write_xer?
>> >
>> > Just to boot to login prompt, these are the numbers for gen_read/write_xer:
>> >
>> > helper_myprint - rd_count 231103, wr_count 68897
>> >
>> > And it keeps on incrementing, maybe scope of optimization here.
>>
>> That's not very large considering the total number of instructions executed
>> during a boot to prompt.
>>
>> Thoughts, David?
>
> Hm, I'm not clear if that's the number of executions, or the number of
> translations.

That is number of executions.

Regards
Nikunj
