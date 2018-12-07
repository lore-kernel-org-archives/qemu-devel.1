Received: from eggs.gnu.org ([2001:4830:134:3::10]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJNC-0002tW-4Y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJNA-0001N4-9s
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:53:05 -0500
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-5-kwolf@redhat.com>
	<87in05wkev.fsf@dusky.pond.sub.org>
	<20181207144519.GF5119@linux.fritz.box>
	<5c0dd2fb-fbe6-41da-77ff-def0f2f3e830@redhat.com>
	<20181207164209.GH5119@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77a60e02-c5e5-4f30-46fd-3eca4604f038@redhat.com>
Date: Fri, 7 Dec 2018 10:52:58 -0600
MIME-Version: 1.0
In-Reply-To: <20181207164209.GH5119@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/5] iotests: Add VMDK tests for
 blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 12/7/18 10:42 AM, Kevin Wolf wrote:
> Am 07.12.2018 um 16:40 hat Eric Blake geschrieben:
>> On 12/7/18 8:45 AM, Kevin Wolf wrote:
>>> Am 07.12.2018 um 14:12 hat Markus Armbruster geschrieben:
>>>> git-am complains
>>>>
>>>>       Applying: iotests: Add VMDK tests for blockdev-create
>>>>       .git/rebase-apply/patch:281: trailing whitespace.
>>>>                   format:
>>>>       .git/rebase-apply/patch:308: trailing whitespace.
>>>>                   format:
>>>>       .git/rebase-apply/patch:335: trailing whitespace.
>>>>                   format:
>>>>       .git/rebase-apply/patch:600: new blank line at EOF.
>>>>       +
>>>>       warning: 4 lines add whitespace errors.
>>>
>>> This is in the reference output, so trailing whitespace/blank lines are
>>> actually correct.
>>
>> Ah, but doesn't ./check already ignore differences in trailing whitespace
>> present in the actual running that is not present in the *.out files,
>> precisely so we don't have to check in trailing whitespace reference
>> outputs?
> 
> It does ignore whitespace changes, so even if we remove that whitespace,
> the test won't fail. But I don't think that's a good reason to check in
> inaccurate reference output.
> 
> There are a few test cases that have a reference output like this and
> it's always annoying: When I later add a new subtest, I add the new test
> code, review the ./check output and if it looks good, I do something
> like 'cp 237.out.bad 237.out'. At that point, I'll have to manually
> revert completely unrelated whitespace changes again.

Is it worth teaching iotests.img_info_log() to strip trailing 
whitespace?  Or even to teach qemu-img itself to quit generating 
trailing whitespace?

> 
> Some 'git am' warnings feel like the lesser evil to me.

True, and a comment in the commit message about intentionally triggering 
a known checkpatch flag goes a long ways to document why you want the 
trailing whitespace (assuming we don't instead decide to tackle a root 
cause of having the whitespace in the first place).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
