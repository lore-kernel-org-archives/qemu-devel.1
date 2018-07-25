Received: from eggs.gnu.org ([2001:4830:134:3::10]:40979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fiIo3-0007Jk-W1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fiIo0-0003nF-VT
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:22:15 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-4-lbloch@janustech.com>
	<20180725082611.GA4879@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32a32b18-0c7c-63cd-3b1d-429717b23a85@redhat.com>
Date: Wed, 25 Jul 2018 07:22:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180725082611.GA4879@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Leonid Bloch <lbloch@janustech.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/25/2018 03:26 AM, Kevin Wolf wrote:

>> @@ -2840,6 +2845,7 @@
>>               '*overlap-check': 'Qcow2OverlapChecks',
>>               '*cache-size': 'int',
>>               '*l2-cache-size': 'int',
>> +            '*l2-cache-full': 'bool',
>>               '*l2-cache-entry-size': 'int',
>>               '*refcount-cache-size': 'int',
>>               '*cache-clean-interval': 'int',
> 
> Only looking at the external interface for now, I wonder whether it
> would be nicer not to have two mutually exclusive options, but to make
> l2-cache-size an alternate that can take either an int like before
> (meaning the number of bytes) or a string/enum (with the only accepted
> value "full" for now).

That does sound interesting.

> 
> Another interesting question is whether 'full' shouldn't keep meaning
> full throughout the lifetime of the BlockDriverState, i.e. should it
> keep adapting to the new size when the image size changes?

Do we even resize the cache now for image size changes? If we use an 
enum, we could have two different values depending on whether the chosen 
cache size remains fixed or also tries to resize when the image grows.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
