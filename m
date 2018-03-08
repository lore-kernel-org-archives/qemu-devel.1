Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etqEm-0003FM-DS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etqEi-0006GB-Ct
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 02:45:16 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
References: <20180306130121.30243-1-berto@igalia.com>
	<cec0f674-b25a-9c7c-e12c-49513e0060d0@redhat.com>
Date: Thu, 08 Mar 2018 08:44:34 +0100
Message-ID: <w518tb3qae5.fsf@maestria.local.igalia.com>
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

On Wed 07 Mar 2018 06:54:51 PM CET, Max Reitz wrote:
>> v4: Mention that commit 1a63a907507fbbcfaee3f622907ec24 also
>>     contributes to solve the original bug (both commits need to
>>     reverted in order to reproduce this bug reliably).
>> 
>>     Rewrite the loop that writes data into the images to make it more
>>     readable.
>
> Thanks!  Applied to my block tree:
>
> https://github.com/XanClic/qemu/commits/block
>
> (Still took me a couple of attempts to get it to fail both commits
> reverted, though...)

Odd, I can reproduce it 100% of the cases. Were you maybe running the
tests on tmpfs ?

Anyway, thanks!

Berto
