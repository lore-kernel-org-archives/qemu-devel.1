Received: from eggs.gnu.org ([2001:4830:134:3::10]:34486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkB6-0003P9-IQ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkB2-0007Pf-IY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:54:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSkB2-0007PH-Bj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:53:56 -0500
References: <20181130122844.29103-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c35ebae-9ddf-c544-57d8-62f2e344c800@redhat.com>
Date: Fri, 30 Nov 2018 08:53:46 -0600
MIME-Version: 1.0
In-Reply-To: <20181130122844.29103-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? v2] hostmem: Validate host-nodes
 before setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 11/30/18 6:28 AM, Eduardo Habkost wrote:
> host_memory_backend_set_host_nodes() was not validating
> host-nodes before writing to backend->host_nodes, making QEMU
> write beyond the end of the bitmap.
> 
> Fix the crash and add a simple regression test for the fix.
> 
> While at it, fix memory leak of the list returned by
> visit_type_uint16List().
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Looks like we may have 3.1-rc4 due to some CVE fixes; is this worth 
including in 3.1 as well?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
