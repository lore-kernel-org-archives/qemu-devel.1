Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYRs-00053P-S6
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgYRo-0002kD-Fq
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:40:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fgYRo-0002k9-A9
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:40:04 -0400
References: <1532012617-16777-1-git-send-email-walling@linux.ibm.com>
	<87sh4f191h.fsf@dusky.pond.sub.org>
	<2dca7714-195f-1532-a907-4e43bfd9355e@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1051e1f-f3c8-d43d-feb7-10cc27b8edc0@redhat.com>
Date: Fri, 20 Jul 2018 11:40:02 -0500
MIME-Version: 1.0
In-Reply-To: <2dca7714-195f-1532-a907-4e43bfd9355e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: print message when using 'help'
 with an unknown command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>

On 07/19/2018 11:39 AM, Collin Walling wrote:
> On 07/19/2018 12:31 PM, Markus Armbruster wrote:
>> You neglected to cc: maintainers.  Cc'ing them increases the odds your
>> patch will be noticed and picked up.  You can use
>> scripts/get_maintainer.pl to find maintainers.  You don't have to do
>> anything for this patch; it got noticed anyway.
>>
>> David, this is yours :)
> 
> Very true. Was a minor fix that I thought I'd just toss it out there and
> let anyone view it if they had the time. Will be more aware of who to CC
> next time around.

Or automate it: 
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer 
suggests:

git config sendemail.cccmd 'scripts/get_maintainer.pl --nogit-fallback'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
