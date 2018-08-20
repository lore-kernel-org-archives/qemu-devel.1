Received: from eggs.gnu.org ([2001:4830:134:3::10]:46303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frnbk-00027M-2D
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frnbV-0003JD-Ao
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 13:04:40 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
	<8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
	<7cd836ad-7270-fe65-d0bd-32b0423d07be@redhat.com>
	<c7675924-8cd7-3dc6-5d9f-a4c839f6bee3@virtuozzo.com>
	<cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37d9972a-77c5-647f-c103-b40281744a40@virtuozzo.com>
Date: Mon, 20 Aug 2018 20:04:07 +0300
MIME-Version: 1.0
In-Reply-To: <cc79c692-8f1b-1bb1-e926-89ee73327f31@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

20.08.2018 19:35, Max Reitz wrote:
> On 2018-08-20 17:13, Vladimir Sementsov-Ogievskiy wrote:
>> 20.08.2018 16:44, Max Reitz wrote:
>>> On 2018-08-20 12:20, Vladimir Sementsov-Ogievskiy wrote:
> [...]
>
>>>> My goal is to get graphviz representation of block graph with all the
>>>> parents for debugging. And I'm absolutely ok to do it with x-debug-.
>>>> Then we shouldn't care about enum for role type now. So, it the patch =
ok
>>>> for you with x-debug- prefix?
>>> Actually, no, because I'm not sure whether using points for the IDs is =
a
>>> good idea.=C2=A0 That may defeat ASLR, and that would be a problem even=
 with
>>> x-debug-.
>> Good point, agree.
>>
>>> So I'd prefer using e.g. a hash map to map pointers to freshly generate=
d
>>> IDs (just incrementing integers).
> (By the way, that would also improve the speed of checking whether a
> certain node needs to be added to the @nodes list still.)
>
>>> In any case, I'll take a further look at the patch later, but another
>>> thing that I've just seen is that using the opaque pointers to identify
>>> a parent is something that doesn't look like it's guaranteed to work.
>> Hm, isn't it a bug? Can you point to an example?
> Ah, no, it's OK.  Well, kind of.  It's OK in the sense that it is unique
> when set.  I didn't notice that you only use it for the non-node
> parents, sorry.

hm, no, I use opaque for all. So, it can be zero? In what case? In this=20
case, I cant get its parent?

>
> Still, it probably would be better to just use the BdrvChild object, as
> that should be unique as well, and it is obviously non-NULL.
> (BdrvChild.opaque may be NULL, even though it isn't in practice.)

but BdrvChild corresponds to edge in a graph, not to the node. I need=20
identificators for nodes..

>
> Max
>


--=20
Best regards,
Vladimir
