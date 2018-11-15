Received: from eggs.gnu.org ([2001:4830:134:3::10]:50452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNLCm-0008UJ-HR
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNLCi-0002qt-Vt
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:13:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNLCh-0002ff-Df
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:13:20 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-6-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63f61f03-3580-4a27-56a7-54bef6d471a0@redhat.com>
Date: Thu, 15 Nov 2018 11:13:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181115140501.7872-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/9] test-string-input-visitor: add more
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 8:04 AM, David Hildenbrand wrote:
> Test that very big/small values are not accepted and that ranges with
> only one element work.
> 
> Rename expect4 to expect5, as we will be moving that to a separate ulist
> test after the rework.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   tests/test-string-input-visitor.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 

I don't see a test for a range that wraps around (such as UINT_MAX-0); 
that's worth testing (whether it happens to work or is rejected as 
invalid).  Do we require ranges to be ascending, or does 6-5 result in 
the sequence 5, 6?  I also recall that our range code imposes a limit on 
the maximum elements present in a single range, in order to prevent 
denial-of-service attacks where a caller could request 0-INT_MAX to 
exhaust resources enumerating everything in the range; does our 
testsuite cover those limits?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
