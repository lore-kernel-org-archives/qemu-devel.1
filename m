Received: from eggs.gnu.org ([2001:4830:134:3::10]:46358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1ci20G-00016H-Ty
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1ci20D-0006CA-Pb
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:48:56 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41347)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1ci20D-0006Bz-JY
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 11:48:53 -0500
References: <20170118220146.489-1-marex@denx.de>
	<20170118220146.489-5-marex@denx.de>
	<87wpciohxy.fsf@dusky.pond.sub.org>
	<cdfa9353-eb52-997e-a534-db744d9f6a60@denx.de>
	<87vas2gjre.fsf@dusky.pond.sub.org>
From: Marek Vasut <marex@denx.de>
Message-ID: <39fc436e-1f1c-b0d2-7b9d-220453b6139b@denx.de>
Date: Sun, 26 Feb 2017 17:46:56 +0100
MIME-Version: 1.0
In-Reply-To: <87vas2gjre.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>, Richard Henderson <rth@twiddle.net>

On 02/22/2017 07:31 PM, Markus Armbruster wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>> On 02/22/2017 07:31 AM, Markus Armbruster wrote:
>>> I know this has been committed already, but here goes anyway:
>>>
>>> Marek Vasut <marex@denx.de> writes:
>>>
>>>> From: Chris Wulff <crwulff@gmail.com>
>>>>
>>>> Add the Altera Nios2 internal interrupt controller model.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Chris Wulff <crwulff@gmail.com>
>>>> Cc: Jeff Da Silva <jdasilva@altera.com>
>>>> Cc: Ley Foon Tan <lftan@altera.com>
>>>> Cc: Sandra Loosemore <sandra@codesourcery.com>
>>>> Cc: Yves Vandervennet <yvanderv@altera.com>
>>>> Cc: Alexander Graf <agraf@suse.de>
>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>> Reviewed-by: Alexander Graf <agraf@suse.de>
>>>> ---
>>>> V3: Checkpatch cleanup
>>>> V4: Rebase on top of qemu/master
>>>> V5: Rebase on top of qemu/master
>>>> ---
>>>>  hw/intc/Makefile.objs |   1 +
>>>>  hw/intc/nios2_iic.c   | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 104 insertions(+)
>>>>  create mode 100644 hw/intc/nios2_iic.c
>>>>
>>>> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
>>>> index 2f44a2da26..8948106ac4 100644
>>>> --- a/hw/intc/Makefile.objs
>>>> +++ b/hw/intc/Makefile.objs
> [...]
>>>> +static Property altera_iic_properties[] = {
>>>> +    DEFINE_PROP_PTR("cpu", AlteraIIC, cpu),
>>>
>>> Could this be a QOM link instead?
>>>
>>> We want to get rid of pointer properties.  Commit d2fe4ec converts one
>>> to a link.
>>
>> By all means, yes. Can you send a patch ? I can help testing it.
>> Otherwise I can cook one up, but it might take a few days.
> 
> I'm in a bit of a time squeeze right now, and I'd be grateful if you
> could do it.  A few days sounds great to me.

Heh, tell me about this time squeeze ...

-- 
Best regards,
Marek Vasut
