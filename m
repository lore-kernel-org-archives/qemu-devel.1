Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSNBe-0004Km-Bj
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSN5h-0002u3-Ow
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:14:55 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8fdd816-90a1-29d7-cdab-0efe3e9abeda@redhat.com>
Date: Thu, 29 Nov 2018 08:14:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181129101801.6421-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH v2 0/2] mirror
 dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-stable@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 11/29/18 4:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> v2: add fix:)
> 
> We've faced the following mirror bug:
> 
> Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.

How long has the bug been present?  Based on patch 1 mentioning commit 
2e1990b26e5 (in 3.0), I'm guessing that this bug is not a regression 
specific to 3.1?  If so, then maybe we're better off deferring this to 
4.0 just relying on qemu-stable (already cc'd); on the other hand, if it 
is an easy-to-trigger deadlock on something the user is likely to do, 
can we justify it being severe enough to warrant -rc4?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
