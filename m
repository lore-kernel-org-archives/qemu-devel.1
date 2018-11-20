Received: from eggs.gnu.org ([2001:4830:134:3::10]:42349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9Ua-0004lQ-Gn
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9UU-0003sG-UX
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gP9UR-0003qI-95
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:07:08 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-6-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27cfb4e6-b4db-10de-02c7-691f011d5f99@redhat.com>
Date: Tue, 20 Nov 2018 11:06:55 -0600
MIME-Version: 1.0
In-Reply-To: <20181120092542.13102-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/9] test-string-input-visitor: Add more
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

On 11/20/18 3:25 AM, David Hildenbrand wrote:
> Test that very big/small values are not accepted and that ranges with
> only one element work. Also test that ranges are ascending and cannot
> have more than 65536 elements.
> 
> Rename expect4 to expect5, as we will be moving that to a separate ulist
> test after the rework.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   tests/test-string-input-visitor.c | 41 +++++++++++++++++++++++++++++--
>   1 file changed, 39 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
