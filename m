Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eEEOZ-0000Hz-S9
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1eEEOV-0000Ly-SL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:03:23 -0500
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1506954812-6552-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuanjfop.fsf@maestria.local.igalia.com>
	<515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <4e53d327-2a37-03ef-3f7e-a3a3f6d33364@huawei.com>
Date: Mon, 13 Nov 2017 14:02:52 +0100
MIME-Version: 1.0
In-Reply-To: <515d6e61-2e1f-0661-e04a-526844deb9ce@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu block <qemu-block@nongnu.org>

On 10/13/2017 4:26 PM, Eric Blake wrote:
> [adding Markus, and block list]
>
> On 10/13/2017 09:16 AM, Alberto Garcia wrote:
>> On Mon 02 Oct 2017 04:33:28 PM CEST, Pradeep Jagadeesh wrote:
>>> This patch factors out code to use the ThrottleLimits
>>> structure.
>>
>>>  { 'struct': 'BlockIOThrottle',
>>> -  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
>>> -            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
>>> -            '*bps_max': 'int', '*bps_rd_max': 'int',
>>> -            '*bps_wr_max': 'int', '*iops_max': 'int',
>>> -            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
>>> -            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
>>> -            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>>> -            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>>> -            '*iops_size': 'int', '*group': 'str' } }
>>> +  'base': 'ThrottleLimits',
>>> +  'data': { '*device': 'str', '*id': 'str', '*group': 'str' } }
>>
>> So BlockIOThrottle used to have parameters named bps_rd and iops_wr, and
>> after this patch they become bps-read and iops-write. This breaks the
>> API completely, as you can see if you run e.g. iotest 129:
>>
>> AssertionError: failed path traversal for "return" in "{u'error': {u'class': u'GenericError', u'desc': u"Parameter 'iops_rd' is unexpected"}}"
>>
>> I just checked previous versions of the series and I see that Manos
>> already warned you of this in v11:
>>
>>    https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04698.html
>
> On the bright side, ThrottleLimits is marked 'since 2.11' (added in
> commit 432d889e), meaning it has not yet been released, so we CAN fix
> the naming in ThrottleLimits to be compatible with BlockIOThrottle if we
> want to share the type, as long as we get it done before the 2.11
> release.  It does mean tweaking Manos' code to use compatible names
> everywhere, but that may be a wise course of action (we tend to favor
> '-' in new API names unless there is a strong reason to use '_'; but
> sharing code for maximum back-compat would be a reason to use '_').

Could you please have a look at Manos reply and my reply also.

Please let me know what you think.

-Pradeep

>
