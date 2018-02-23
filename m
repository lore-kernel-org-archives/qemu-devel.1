Received: from eggs.gnu.org ([2001:4830:134:3::10]:33704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epElf-0002zB-8s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epElc-0000ge-29
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:56:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1epElb-0000fN-Sh
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:56:07 -0500
References: <1519372288-20791-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<c5009934-13c3-6e86-2618-9935837d3b8d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12b54434-c992-d882-9ce7-0f658d067a7c@redhat.com>
Date: Fri, 23 Feb 2018 08:55:56 -0600
MIME-Version: 1.0
In-Reply-To: <c5009934-13c3-6e86-2618-9935837d3b8d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/uri.c: add brackets to `if`
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

On 02/23/2018 03:34 AM, Thomas Huth wrote:
> On 23.02.2018 08:51, Su Hang wrote:
>> Add brackets that wrap `if`, `else`, `while` that hold single
>> statements.
>>
>> In order to do this, I write a simple python regex script.

Without documenting the script, no one else can reproduce this; but it's 
no different than if they had manually made changes instead of trying to 
script it, so I'm not sure this sentence adds much in its current form.

>>
>> Since then, all complaints rised by checkpatch.pl has been suppressed.

s/rised/raised/
s/Since then,/With that/
s/has/have/

>>
>> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
>> ---
>>   util/uri.c | 462 ++++++++++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 291 insertions(+), 171 deletions(-)
>>

>>       cur = *str;
>> -    if (!ISA_ALPHA(cur))
>> +    if (!ISA_ALPHA(cur)) {
>>           return 2;
>> +    }
>>       cur++;
>> -    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) ||
>> -           (*cur == '+') || (*cur == '-') || (*cur == '.'))
>> +    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur == '+') || (*cur == '-') ||
>> +           (*cur == '.'))
>>           cur++;
> 
> You've changed the while statement, but checkpatch.pl apparently does not
> complain about missing curly braces here ... that's strange, I thought we'd
> also wanted to enforce curly braces for while loops.

Maybe because it gets lost since the condition expanded over more than 
one line?  But yes, now that we've noticed it manually, it should be 
fixed.  While at it, you can avoid the redundant ():

while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || *cur == '+' || *cur == '-' ||
        *cur == '.') {


>> -        while ((*tmp++ = *segp++) != 0)
>> +        while ((*tmp++ = *segp++) != 0) {
>>               ;
>> +        }
> 
> A bikeshed-painting-friday question for everybody on qemu-devel:
> Should there be a single semicolon inside curly braces in this case, or not?
> 

Checkpatch doesn't complain, but lone ';' statements are rare.  I'd omit 
it, and use just:

while (cond) {
}


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
