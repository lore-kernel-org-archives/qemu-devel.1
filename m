Received: from eggs.gnu.org ([2001:4830:134:3::10]:40964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNIu2-00065O-Jr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNItx-000550-VO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:45:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNItq-0004Xo-Kk
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:45:44 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-5-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b6bd73e-9e17-2edc-f59b-3af9f89459de@redhat.com>
Date: Thu, 15 Nov 2018 08:45:36 -0600
MIME-Version: 1.0
In-Reply-To: <20181115140501.7872-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/9] qapi: use qemu_strtod_finite() in
 qobject-input-visitor
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
> Let's use the new function. Just as current behavior, we have to
> consume the whole string (now it's just way clearer what's going on).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   qapi/qobject-input-visitor.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
