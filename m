Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgbhF-00046G-Hx
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgbhC-00052Y-DS
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:31:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgbhC-00052M-6n
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:31:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170118220146.489-1-marex@denx.de>
	<20170118220146.489-5-marex@denx.de>
	<87wpciohxy.fsf@dusky.pond.sub.org>
	<cdfa9353-eb52-997e-a534-db744d9f6a60@denx.de>
Date: Wed, 22 Feb 2017 19:31:17 +0100
In-Reply-To: <cdfa9353-eb52-997e-a534-db744d9f6a60@denx.de> (Marek Vasut's
	message of "Wed, 22 Feb 2017 16:18:29 +0100")
Message-ID: <87vas2gjre.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V5 4/7] nios2: Add IIC interrupt controller
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>, Richard Henderson <rth@twiddle.net>

Marek Vasut <marex@denx.de> writes:

> On 02/22/2017 07:31 AM, Markus Armbruster wrote:
>> I know this has been committed already, but here goes anyway:
>> 
>> Marek Vasut <marex@denx.de> writes:
>> 
>>> From: Chris Wulff <crwulff@gmail.com>
>>>
>>> Add the Altera Nios2 internal interrupt controller model.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Chris Wulff <crwulff@gmail.com>
>>> Cc: Jeff Da Silva <jdasilva@altera.com>
>>> Cc: Ley Foon Tan <lftan@altera.com>
>>> Cc: Sandra Loosemore <sandra@codesourcery.com>
>>> Cc: Yves Vandervennet <yvanderv@altera.com>
>>> Cc: Alexander Graf <agraf@suse.de>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Reviewed-by: Alexander Graf <agraf@suse.de>
>>> ---
>>> V3: Checkpatch cleanup
>>> V4: Rebase on top of qemu/master
>>> V5: Rebase on top of qemu/master
>>> ---
>>>  hw/intc/Makefile.objs |   1 +
>>>  hw/intc/nios2_iic.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 104 insertions(+)
>>>  create mode 100644 hw/intc/nios2_iic.c
>>>
>>> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
>>> index 2f44a2da26..8948106ac4 100644
>>> --- a/hw/intc/Makefile.objs
>>> +++ b/hw/intc/Makefile.objs
[...]
>>> +static Property altera_iic_properties[] = {
>>> +    DEFINE_PROP_PTR("cpu", AlteraIIC, cpu),
>> 
>> Could this be a QOM link instead?
>> 
>> We want to get rid of pointer properties.  Commit d2fe4ec converts one
>> to a link.
>
> By all means, yes. Can you send a patch ? I can help testing it.
> Otherwise I can cook one up, but it might take a few days.

I'm in a bit of a time squeeze right now, and I'd be grateful if you
could do it.  A few days sounds great to me.
