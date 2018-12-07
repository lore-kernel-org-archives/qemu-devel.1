Received: from eggs.gnu.org ([2001:4830:134:3::10]:59533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIEl-0007xV-Gn
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVIEi-0004MW-9D
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:40:19 -0500
References: <20181207115343.6747-1-kwolf@redhat.com>
	<20181207115343.6747-5-kwolf@redhat.com>
	<87in05wkev.fsf@dusky.pond.sub.org>
	<20181207144519.GF5119@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c0dd2fb-fbe6-41da-77ff-def0f2f3e830@redhat.com>
Date: Fri, 7 Dec 2018 09:40:02 -0600
MIME-Version: 1.0
In-Reply-To: <20181207144519.GF5119@linux.fritz.box>
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
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

On 12/7/18 8:45 AM, Kevin Wolf wrote:
> Am 07.12.2018 um 14:12 hat Markus Armbruster geschrieben:
>> git-am complains
>>
>>      Applying: iotests: Add VMDK tests for blockdev-create
>>      .git/rebase-apply/patch:281: trailing whitespace.
>>                  format:
>>      .git/rebase-apply/patch:308: trailing whitespace.
>>                  format:
>>      .git/rebase-apply/patch:335: trailing whitespace.
>>                  format:
>>      .git/rebase-apply/patch:600: new blank line at EOF.
>>      +
>>      warning: 4 lines add whitespace errors.
> 
> This is in the reference output, so trailing whitespace/blank lines are
> actually correct.

Ah, but doesn't ./check already ignore differences in trailing 
whitespace present in the actual running that is not present in the 
*.out files, precisely so we don't have to check in trailing whitespace 
reference outputs?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
