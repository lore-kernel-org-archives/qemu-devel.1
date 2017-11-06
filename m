Received: from eggs.gnu.org ([2001:4830:134:3::10]:58705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBgtl-0005iO-G9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBgth-0002hb-Is
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:53:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <ec0fbf5f-0c42-1787-c6ea-4a64dbc58295@redhat.com>
References: <cover.1509718618.git.berto@igalia.com>
	<fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
	<ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
	<w518tfnglio.fsf@maestria.local.igalia.com>
	<w5160argl1p.fsf@maestria.local.igalia.com>
	<ec0fbf5f-0c42-1787-c6ea-4a64dbc58295@redhat.com>
Date: Mon, 06 Nov 2017 13:52:19 +0100
Message-ID: <w51tvy7k1rw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/7] qcow2: Prevent
 allocating compressed clusters at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon 06 Nov 2017 01:36:01 PM CET, Max Reitz wrote:
>>>>> -        assert(offset);
>>>>
>>>> I don't think this assert() was meant as a protection against offset
>>>> being 0. :-)
>>>
>>> After the new check offset is now guaranteed to be 0, so what's the
>>> point of keeping the assert() ?
>> 
>> I meant "guaranteed _not_ to be 0" :-)
>
> That is the point of an assert.
>
> An assert should not guard against something that can occur. It should
> express that something will always be true (in this case that the
> offset is guaranteed not to be 0).

Right, and they're especially useful when it's not obvious that the
assertion is always true.

The reason why I removed the assertion in this case is that the code
that checks and guarantees that the offset is not null is immediately
before the assert() line.

But I'm not going to argue over something like this, I don't mind if you
prefer to keep it :-)

Berto
