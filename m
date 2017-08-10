Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dfo7W-0000DT-Ed
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dfo7Q-0004kd-SI
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:07:30 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:20935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dfo7Q-0004ip-J2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 10:07:24 -0400
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<87bmoxcuvn.fsf@dusky.pond.sub.org>
	<61626c42-9c47-14e5-24b7-e6086d042a6b@huawei.com>
	<87shh3fn7d.fsf@dusky.pond.sub.org>
	<w511soml2kh.fsf@maestria.local.igalia.com>
	<34e45421-0b22-15b4-deb7-980f26e5ca23@huawei.com>
	<w51shh2jfi9.fsf@maestria.local.igalia.com>
	<87wp6e6qb7.fsf@dusky.pond.sub.org>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <dc14df7c-2f7c-300b-5f60-44411f3d6604@huawei.com>
Date: Thu, 10 Aug 2017 16:06:16 +0200
MIME-Version: 1.0
In-Reply-To: <87wp6e6qb7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, qemu-devel@nongnu.org

On 8/8/2017 5:18 PM, Markus Armbruster wrote:
> Alberto Garcia <berto@igalia.com> writes:
>
>> On Tue 08 Aug 2017 02:30:43 PM CEST, Pradeep Jagadeesh wrote:
>>> On 8/8/2017 1:30 PM, Alberto Garcia wrote:
>>>> On Mon 07 Aug 2017 04:48:38 PM CEST, Markus Armbruster wrote:
>>>>>>> Awkward question for a v7, but here goes anyway: why is IOThrottle
>>>>>>> worth its very own .json file?
>>>>>> I feel this is a common throttle structure that is used by block
>>>>>> devices as well as fsdev, so moved to a separate file.
>>>>> I'm not sure that's a good idea.  Kevin, Berto, what do you think?
>>>>
>>>> Mmm... I don't have a very strong opinion, but if there's no actual need
>>>> to move it to a separate file I'd prefer to leave it where it is.
>>> The segregation is the solid reason. Because throttling is a feature
>>> that is used by fsdev, block may many more in future. I do not see
>>> moving it back to block does it make any sense?
>>
>> It's not "moving it back", it's keeping it where it is. But I see no big
>> problem with moving it to a common file either.
>
> I'd rather not put every struct shared across subsystem boundaries in
> its own file.
>
> We can keep it right where it is for now.  Bonus: more readable diff.
> If we start sharing more throttle-related material than just a struct,
> we can reconsider.
>
> We could also move it to the existing file for common stuff:
> qapi/common.json.  Not a great fit, though.
So, the final conclusion is to move to common.json?

Regards,
Pradeep
>
