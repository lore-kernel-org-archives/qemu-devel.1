Received: from eggs.gnu.org ([2001:4830:134:3::10]:47289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1ctyB2-0002gQ-Bm
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1ctyAz-0007sQ-6F
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:09:24 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:33064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1ctyAy-0007s2-SW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:09:21 -0400
Received: by mail-oi0-x22a.google.com with SMTP id b187so63580714oif.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 08:09:20 -0700 (PDT)
References: <1490970783-29231-1-git-send-email-minyard@acm.org>
	<8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <fca372b3-da5d-9132-1571-47fcce011cb1@mvista.com>
Date: Fri, 31 Mar 2017 10:09:18 -0500
MIME-Version: 1.0
In-Reply-To: <8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9? v4] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>

On 03/31/2017 10:04 AM, Eric Blake wrote:
> On 03/31/2017 09:33 AM, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Macro parameters should almost always have () around them when used.
>> llvm reported an error on this.
>>
>> Remove redundant parenthesis and put parenthesis around the entire
>> macros with assignments in case they are used in an expression.
>>
>> The macros were doing ((v) & 1) for a binary input, but that only works
>> if v == 0 or if v & 1.  Changed to !!(v) so they work for all values.
> s/&/==/
>

I originally wrote v == 1, but I realized that it worked with anything 
where the
bottom bit of v was set.  Thus, v & 1.

>> Remove some unused macros.
>>
>> Reported in https://bugs.launchpad.net/bugs/1651167
> Might also be worth adding that an audit of the code finds no semantic
> change, that this is just cleaning up the compiler warning.

Will do.

Thanks,

-corey
>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>
>> Changes since the last revision:
>>
>>    * Added the !!(v) change
>>
>>   hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>>   1 file changed, 12 insertions(+), 22 deletions(-)
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
