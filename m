Received: from eggs.gnu.org ([2001:4830:134:3::10]:43488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1euHnw-0003yJ-4M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1euHns-0000Ed-0T
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:11:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <08c5381a-cacf-6d0d-d804-4066a7d3018c@redhat.com>
References: <20180306130121.30243-1-berto@igalia.com>
	<cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
	<w518tb3qae5.fsf@maestria.local.igalia.com>
	<08c5381a-cacf-6d0d-d804-4066a7d3018c@redhat.com>
Date: Fri, 09 Mar 2018 14:10:41 +0100
Message-ID: <w518tb12y3y.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

On Fri 09 Mar 2018 01:54:31 PM CET, Max Reitz wrote:
> On 2018-03-08 08:44, Alberto Garcia wrote:
>> On Wed 07 Mar 2018 06:54:51 PM CET, Max Reitz wrote:
>>>> v4: Mention that commit 1a63a907507fbbcfaee3f622907ec24 also
>>>>     contributes to solve the original bug (both commits need to
>>>>     reverted in order to reproduce this bug reliably).
>>>>
>>>>     Rewrite the loop that writes data into the images to make it more
>>>>     readable.
>>>
>>> Thanks!  Applied to my block tree:
>>>
>>> https://github.com/XanClic/qemu/commits/block
>>>
>>> (Still took me a couple of attempts to get it to fail both commits
>>> reverted, though...)
>> 
>> Odd, I can reproduce it 100% of the cases. Were you maybe running the
>> tests on tmpfs ?
>
> ...yes? O:-)

Nothing wrong, I do it often, but I used an actual hard drive to
reproduce this bug.

Berto
