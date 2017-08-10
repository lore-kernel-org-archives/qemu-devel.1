Received: from eggs.gnu.org ([2001:4830:134:3::10]:58349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqP3-0006OR-M5
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfqOy-0004K1-5n
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfqOx-0004Js-W6
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:33:40 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
	<w51shh2jfi9.fsf@maestria.local.igalia.com>
	<87wp6e6qb7.fsf@dusky.pond.sub.org>
	<dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
	<66aac45f-6319-2eca-3703-aaab43557e00@redhat.com>
Date: Thu, 10 Aug 2017 18:25:21 +0200
In-Reply-To: <66aac45f-6319-2eca-3703-aaab43557e00@redhat.com> (Eric Blake's
	message of "Thu, 10 Aug 2017 10:14:36 -0500")
Message-ID: <87shgz8k5q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2017 09:06 AM, Pradeep Jagadeesh wrote:
>
>>>> It's not "moving it back", it's keeping it where it is. But I see no big
>>>> problem with moving it to a common file either.
>>>
>>> I'd rather not put every struct shared across subsystem boundaries in
>>> its own file.
>>>
>>> We can keep it right where it is for now.  Bonus: more readable diff.
>>> If we start sharing more throttle-related material than just a struct,
>>> we can reconsider.
>>>
>>> We could also move it to the existing file for common stuff:
>>> qapi/common.json.  Not a great fit, though.
>>
>> So, the final conclusion is to move to common.json?
>
> No.
>
> If more than one .json file would benefit by including the definition,
> then put it in a separate file that both .json include from.

This is the case.

Your opinion is incompatible with mine, stated above.

> But if only one .json file would be including a new file, then just
> inline the struct directly into that one original file (in this case,
> block-core.json) instead of creating a separate file (so no to needing
> iothrottle.json), or putting the code in yet a different file than the
> one that is using the struct (so no to putting it in common.json).

This is no longer the case.

Conclusion: no consensus, yet.
