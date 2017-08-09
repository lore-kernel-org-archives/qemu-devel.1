Received: from eggs.gnu.org ([2001:4830:134:3::10]:38201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfQT2-0003EN-6u
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dfQSz-0000yp-1q
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:52:08 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809093612.oee2u5kdgyojheqm@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
	<20170808145620.wlb5rdutuseutclx@postretch>
	<w51mv7aje27.fsf@maestria.local.igalia.com>
	<20170809093612.oee2u5kdgyojheqm@postretch>
Date: Wed, 09 Aug 2017 14:36:20 +0200
Message-ID: <w51y3qslxyz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Wed 09 Aug 2017 11:36:12 AM CEST, Manos Pitsidianakis wrote:
> On Tue, Aug 08, 2017 at 05:04:48PM +0200, Alberto Garcia wrote:
>>On Tue 08 Aug 2017 04:56:20 PM CEST, Manos Pitsidianakis wrote:
>>>>> So basically if we have anonymous groups, we accept limits in the
>>>>> driver options but only without a group-name.
>>>>
>>>>In the commit message you do however have limits and a group name, is
>>>>that a mistake?
>>>>
>>>>    -drive driver=throttle,file.filename=foo.qcow2, \
>>>>           limits.iops-total=...,throttle-group=bar
>>>
>>> Sorry this wasn't clear, I'm actually proposing to remove limits from
>>> the throttle driver options and only create/config throttle groups via
>>> -object/object-add.
>>
>>Sorry I think it was me who misunderstood :-) Anyway in the new
>>command-line API I would be more inclined to have limits defined using
>>"-object throttle-group" and -drive would only reference the group id.
>>
>>I understand that this implies that it wouldn't be possible to create
>>anonymous groups (at least not from the command line), is that a
>>problem?
>
> We can accept anonymous groups if a user specifies limits but not a
> group name in the throttle driver. (The only case where limits would
> be acccepted)

Yeah but that's only if we have the limits.iops-total=... options in the
throttle driver. If we "remove limits from the throttle driver options
and only create/config throttle groups via -object/object-add" we cannot
do that.

> Not creating eponymous throttle groups via the throttle driver means
> we don't need throttle_groups anymore, since even anonymous ones don't
> need to be accounted for in a list.

I don't follow you here, how else do you get a group by its name?

Berto
