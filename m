Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWMle-0004Zz-Ch
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fWMlZ-0005U3-Mf
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:10:26 -0400
References: <152967373830.876.17089841294743780259@d39dc562802a>
	<5df62baa-268b-2624-e9d7-42c521546d04@de.ibm.com>
	<20180622154708.37167025.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a237bbc8-deb5-643f-a81b-b5752f628863@redhat.com>
Date: Fri, 22 Jun 2018 09:10:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180622154708.37167025.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, famz@redhat.com, david@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, qemu-s390x@nongnu.org, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rth@twiddle.net

On 06/22/2018 08:47 AM, Cornelia Huck wrote:

>>> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
>>> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>       *length = end - offset;
>>>                 ~~~~^~~~~~~~
>>> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>>>       uint64_t begin = offset, end;
>>>                                ^~~
>>> cc1: all warnings being treated as errors
>>
>> This seems unrelated to the patch?
>>
> 
> Yes, the last few patches all failed with this error.

And fixed now, with commit 45eb6fb

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
