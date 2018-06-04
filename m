Received: from eggs.gnu.org ([2001:4830:134:3::10]:55544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPy9r-0004su-K9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fPy9q-0005TA-Sn
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 18:40:59 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
	<3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df356e6b-8559-1a79-17cf-47bdfeb8612d@redhat.com>
Date: Mon, 4 Jun 2018 17:40:49 -0500
MIME-Version: 1.0
In-Reply-To: <3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 06/04/2018 05:34 AM, Thomas Huth wrote:
> On 04.06.2018 09:18, Markus Armbruster wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>
>>> Add helper functions to query the block drivers actually supported by
>>> QEMU using "-drive format=?".  This allows to skip certain tests that
>>> require drivers not built in or whitelisted in QEMU.
>>>

>>> +    supported_formats=$($QEMU_PROG $QEMU_OPTIONS -drive format=\? 2>&1 | \
>>
>> Use of '?' to get help is deprecated.  Please use 'format=help', and
>> update your commit message accordingly.
> 
> Is it? Where did we document that?

Hmm, we haven't documented it yet, but it's been that way since commit 
c8057f95, in Aug 2012, when we added 'help' as the preferred synonym, 
and have tried to avoid mention of '?' in new documentation (as it 
requires additional shell quoting).  I'm guessing we'll probably see a 
patch from you to start an official deprecation window?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
