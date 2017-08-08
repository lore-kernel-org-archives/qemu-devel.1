Received: from eggs.gnu.org ([2001:4830:134:3::10]:59750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df5Zy-0000dI-7b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df5Zu-0000NY-9O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:33:54 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1df5Zt-0000MH-S1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:33:50 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
Date: Tue, 08 Aug 2017 16:33:34 +0200
Message-ID: <w51shh2jfi9.fsf@maestria.local.igalia.com>
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
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Tue 08 Aug 2017 02:30:43 PM CEST, Pradeep Jagadeesh wrote:
> On 8/8/2017 1:30 PM, Alberto Garcia wrote:
>> On Mon 07 Aug 2017 04:48:38 PM CEST, Markus Armbruster wrote:
>>>>> Awkward question for a v7, but here goes anyway: why is IOThrottle
>>>>> worth its very own .json file?
>>>> I feel this is a common throttle structure that is used by block
>>>> devices as well as fsdev, so moved to a separate file.
>>> I'm not sure that's a good idea.  Kevin, Berto, what do you think?
>>
>> Mmm... I don't have a very strong opinion, but if there's no actual need
>> to move it to a separate file I'd prefer to leave it where it is.
> The segregation is the solid reason. Because throttling is a feature 
> that is used by fsdev, block may many more in future. I do not see 
> moving it back to block does it make any sense?

It's not "moving it back", it's keeping it where it is. But I see no big
problem with moving it to a common file either.

Berto
