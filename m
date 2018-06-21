Received: from eggs.gnu.org ([2001:4830:134:3::10]:57232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW0Z2-0003pr-2B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fW0Z1-0007yr-7L
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:27:56 -0400
References: <20180621124937.166549-1-eblake@redhat.com>
	<f1365a2f-d63a-bbd2-32b5-d1e6e4fc1888@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aaf9f5e4-8c52-5409-fe81-c86054dd9ba0@redhat.com>
Date: Thu, 21 Jun 2018 09:27:50 -0500
MIME-Version: 1.0
In-Reply-To: <f1365a2f-d63a-bbd2-32b5-d1e6e4fc1888@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Reject 0-length block status
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/21/2018 07:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> 21.06.2018 15:49, Eric Blake wrote:
>> The NBD spec says that behavior is unspecified if the client
>> requests 0 length for block status; but since the structured
>> reply is documenting as returning a non-zero length, it's
>> easier to just diagnose this with an EINVAL error than to
>> figure out what to return.
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; added to my NBD queue.  Doing this makes it easier to add the 
assertion necessary to shut up gcc warning about an uninitialized 
variable in the other patches ready to pull.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
