Received: from eggs.gnu.org ([2001:4830:134:3::10]:39959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnT9-0005bY-2C
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnRb-0000W3-2o
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:43:14 -0500
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130140154.11161-1-eblake@redhat.com>
	<04c922b4-7287-61e7-1afc-4e64f39c52a5@redhat.com>
	<87o9ni52ge.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88d1f830-f9a0-d408-1430-ba22d5897c32@redhat.com>
Date: Fri, 1 Dec 2017 08:22:08 -0600
MIME-Version: 1.0
In-Reply-To: <87o9ni52ge.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/3] checkpatch: Enforce proper do/while
 (0) style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 12/01/2017 01:31 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 11/30/2017 08:01 AM, Eric Blake wrote:
>>> while (0) is only idiomatic in a macro definition, where the caller
>>> will be supplying the trailing ';'.  Warn if the macro has a duplicate.
>>>

>>>
>>> +# 'while (0);' is odd; only macros should use while (0), without trailing ;
>>> +		if ($line =~ /while\s*\(0\);/) {
>>
>> Should this also check for uses of 'while (false);' ?
> 
> Do we think it's likely to occur?

Not as frequent, but it does appear in the code base.

> 
>> Interestingly enough, we have an instance of 'do/while (false);' in
>> tests/vhost-user-bridge.c that is NOT in a macro, but is used for the
>> convenience of being able to 'break;' out early rather than using a
>> goto.  Similarly for chardev/char-serial.c using 'while (0);' outside
>> of a macro.
> 
> That "cure" merely adds gratuitous cleverness to the "disease".
> 
>>               Those may be worth rewriting to use goto as separate
>> patches if we want to restrict ALL use of 'while \((0|false)\);'
> 
> I'd support that.
> 

Okay, I'll post a v2 along those lines.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
