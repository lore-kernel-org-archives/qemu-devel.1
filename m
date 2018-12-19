Received: from eggs.gnu.org ([2001:4830:134:3::10]:44135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZfY2-0002gU-It
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZfXz-0000jU-AJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZfXz-0000iy-1a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 12:22:15 -0500
References: <20181218225714.284495-1-eblake@redhat.com>
	<5e8486d1-5782-0fcd-a028-05efea867de1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53bec9bf-17dd-22f7-7f68-79b3809f6bd4@redhat.com>
Date: Wed, 19 Dec 2018 11:22:12 -0600
MIME-Version: 1.0
In-Reply-To: <5e8486d1-5782-0fcd-a028-05efea867de1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] nbd-client: drop extra error noise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 12/19/18 6:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.12.2018 1:57, Eric Blake wrote:
>> This is a counter-proposal to Vladimir's initial post for
>> reducing the noise in iotest 083.  The difference is that
>> I dropped error_get_hint, since I couldn't find any useful
>> hint to be traced during transmission phase in the first place,
>> and instead added a trace message for the one place where we
>> do set hints during handshaking phase.
> 
> OK, agree with the idea.

Thanks. I'll queue this one through my NBD tree and send a pull request 
soon (although depending on timing, Peter might not apply it until 
January...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
