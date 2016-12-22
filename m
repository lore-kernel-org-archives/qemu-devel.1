Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK7Tm-00020G-JE
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cK7Ti-0006sv-Ds
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:48:34 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cK7Ti-0006sX-7m
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:48:30 -0500
Received: by mail-pf0-x242.google.com with SMTP id i88so12712876pfk.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 09:48:30 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
	<1482417047-15588-1-git-send-email-minyard@acm.org>
	<b9a532a5-2527-0e6e-6c16-c4d23b62b8ef@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <2eff4756-3a2a-f9b9-4e16-af1c4e9340d7@acm.org>
Date: Thu, 22 Dec 2016 11:48:25 -0600
MIME-Version: 1.0
In-Reply-To: <b9a532a5-2527-0e6e-6c16-c4d23b62b8ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ipmi: Add parenthesis around some macro
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

On 12/22/2016 09:01 AM, Eric Blake wrote:
> On 12/22/2016 08:30 AM, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Macro parameters should almost always have () around them when used.
>> llvm reported an error on this.
>>
>> Reported in https://bugs.launchpad.net/bugs/1651167
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   hw/ipmi/isa_ipmi_bt.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
>> index f036617..8a97314 100644
>> --- a/hw/ipmi/isa_ipmi_bt.c
>> +++ b/hw/ipmi/isa_ipmi_bt.c
>> @@ -40,37 +40,37 @@
>>   #define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
>>   #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
>>   #define IPMI_BT_SET_CLR_WR(d, v)   (d) = (((d) & ~IPMI_BT_CLR_WR_MASK) | \
> Still under-parenthesized, if the result of IPMI_BT_SET_CLR_WR() is used
> in any larger expression;

I wasn't thinking about this being used in a larger expression, but it 
should be protected,
I suppose.  I'll re-submit with that fixed and the extra () removed.

Thanks,

-corey

>> -                                       (((v & 1) << IPMI_BT_CLR_WR_BIT)))
>> +                                       ((((v) & 1) << IPMI_BT_CLR_WR_BIT)))
> and at the same time, you (still) have a redundant set on the second line.
>
> Better would be:
>
> ((d) = (((d) & ~IPMI_BD_CLR_WR_MASK) | \
>          (((v) & 1) << IPMI_BT_CLR_WR_BIT)))
>
>>   
>>   #define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
>>   #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
>>   #define IPMI_BT_SET_CLR_RD(d, v)   (d) = (((d) & ~IPMI_BT_CLR_RD_MASK) | \
>> -                                       (((v & 1) << IPMI_BT_CLR_RD_BIT)))
>> +                                       ((((v) & 1) << IPMI_BT_CLR_RD_BIT)))
> and again, throughout the patch.
>
>
