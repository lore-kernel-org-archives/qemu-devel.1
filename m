Received: from eggs.gnu.org ([2001:4830:134:3::10]:50345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoX3r-0001vk-0s
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoX3m-0001sP-6K
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:16:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <2b8ce231-8e6a-bb83-91e2-7d7a44c9588f@redhat.com>
References: <20180221140849.16068-1-berto@igalia.com>
	<2b8ce231-8e6a-bb83-91e2-7d7a44c9588f@redhat.com>
Date: Wed, 21 Feb 2018 17:15:55 +0100
Message-ID: <w51h8qajp38.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 21 Feb 2018 05:10:30 PM CET, Eric Blake wrote:
>>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>>   
>> -    Bit  0 -  x:    Host cluster offset. This is usually _not_ aligned to a
>> -                    cluster boundary!
>> +    Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
>> +                    cluster or sector boundary!
>
>
> This breaks the nice alignment of the ':' character that the rest of the 
> section preserves.  You could also have done:
>
> Compressed Clusters Descriptor (x = 61 - (cluster_bits - 8)):
>     Bit  0 -  x:  ...
>        x+1 - 61:  ...
>
> to preserve the alignment, by shifting the adjustment into the 
> calculation of x.  But I'm fine with either approach.

Yeah I actually saw the same problem, in the end I chose this one
because the numbers match the implementation:

    s->csize_shift = (62 - (s->cluster_bits - 8));

Thanks for reviewing!

Berto
