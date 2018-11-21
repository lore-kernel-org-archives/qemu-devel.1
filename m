Received: from eggs.gnu.org ([2001:4830:134:3::10]:48465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWc5-0002uf-1K
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWX1-0004aX-Tj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:43:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPWX1-0004Yi-Na
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:43:19 -0500
References: <20181121164421.20780-1-david@redhat.com>
	<20181121164421.20780-2-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1b85cc0-b7d6-979d-02b8-cd6ed2071d74@redhat.com>
Date: Wed, 21 Nov 2018 11:43:14 -0600
MIME-Version: 1.0
In-Reply-To: <20181121164421.20780-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-4.0 1/9] cutils: Add qemu_strtod()
 and qemu_strtod_finite()
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

On 11/21/18 10:44 AM, David Hildenbrand wrote:
> Let's provide a wrapper for strtod().
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/qemu/cutils.h |  2 ++
>   util/cutils.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 67 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
