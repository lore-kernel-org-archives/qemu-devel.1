Received: from eggs.gnu.org ([2001:4830:134:3::10]:56478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enqpq-0001kd-Ik
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1enqpp-0000Nq-Qq
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:10:46 -0500
References: <20180219145459.8143-1-berto@igalia.com>
	<0fb270ca-5aae-0db3-93c2-43ebd6162027@redhat.com>
	<w51371whm38.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a436f27-cc7b-4634-0a7b-3643d73b7f7b@redhat.com>
Date: Mon, 19 Feb 2018 13:10:33 -0600
MIME-Version: 1.0
In-Reply-To: <w51371whm38.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docs: document how to use the
 l2-cache-entry-size parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/19/2018 12:26 PM, Alberto Garcia wrote:

>>> + - The L2 cache entry size has the same restrictions as the cluster
>>> +   size (power of two, at least 512 bytes).
>>
>> Worth mentioning the upper limit of the cluster size?
> 
> I thought it would be unnecessary since the that's already mentioned
> several times in the text ("you can change the size [...] and make it
> smaller than the cluster size", "Using smaller cache entries"), and I
> think it's pretty obvious if you actually read that section.

Works for me, then


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
