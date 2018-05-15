Received: from eggs.gnu.org ([2001:4830:134:3::10]:41742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIaiV-0001IZ-NI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIaiP-0007rr-SX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:14:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIaiP-0007rW-Oo
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:14:09 -0400
References: <20180515134950.3755-1-muriloo@linux.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f128b68-3fd1-1117-b883-d0724937ad09@redhat.com>
Date: Tue, 15 May 2018 09:14:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180515134950.3755-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] HACKING: document preference for g_new
 instead of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/15/2018 08:49 AM, Murilo Opsfelder Araujo wrote:
> This patch documents the preference for g_new instead of g_malloc. The
> reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d.
> 
> Discussion in QEMU's mailing list:
>    http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html
> 
> Cc: qemu-devel@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>   HACKING | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
