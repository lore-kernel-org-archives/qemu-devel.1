Received: from eggs.gnu.org ([2001:4830:134:3::10]:57107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTrgY-0000L9-IR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTrgS-0006To-3Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 12:07:06 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
	<28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
	<9082a92e-45cf-9e31-4ce0-4e4711799b57@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fafd60c0-51ef-7b2b-5da4-0934f986a0b7@redhat.com>
Date: Mon, 3 Dec 2018 11:06:37 -0600
MIME-Version: 1.0
In-Reply-To: <9082a92e-45cf-9e31-4ce0-4e4711799b57@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jcody@redhat.com" <jcody@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Denis Plotnikov <dplotnikov@virtuozzo.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 12/3/18 8:26 AM, Max Reitz wrote:

>>> So because apparently there is going to be an rc4 anyway (like basically
>>> always...), I'd really like to bring this fix into it, unless there are
>>> any objections from anyone (though all of you are more than welcome to
>>> explicitly agree, too :-)).

I agree with fixing this in -rc4.

>>>
>>> Do you have any plans for the iotest?  Right now, I'd rather just take
>>> patch 1 as-is and add the test later, but then again, adding a patch for
>>> rc4 without a test is not so nice either, I suppose.

...


>>
>> May be it should be a kind of parameter, with default to your variant, something
>> like ./check --big-disk-allocations-allowed :).
> 
> As I said, we would need to add a new group (e.g. "big-disk-allocation")
> and then probably disable that group in check by default.  You could run
> those tests with ./check -g big-disk-allocation.
> 
>> But let's commit at least the test with your additions.
> 
> I mean, we can also add both tests.  But I should say that your version
> did not fail on tmpfs before this fix, and I usually run tests on tmpfs,
> so...  It wouldn't be very indicative of the issue for me.

My take - patch 1 for fixing the bug, plus Max's patch 3 for quickly 
testing the bug for 3.1. Vladimir's patch 2 should defer to 4.0, if we 
want it at all, since we're still debating about whether we need it (and 
even how we would spell it in iotests to run or not run it under 
particular setups).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
