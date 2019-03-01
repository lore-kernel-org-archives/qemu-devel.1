Received: from eggs.gnu.org ([209.51.188.92]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkvl-00083i-UO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkvl-00076k-93
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:22:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkvl-000761-2e
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:22:37 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a36623d3-0df7-3177-ca51-e71ef66147cc@redhat.com>
Date: Fri, 1 Mar 2019 10:22:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] tests/qapi-schema: Cover forward
 reference to sub-module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, quintela@redhat.com

On 3/1/19 9:40 AM, Markus Armbruster wrote:
> The forward reference from the main module to the sub-module works
> fine, except for an issue visible in qapi-schema-test.out: the array
> type wrapped around the forward reference ends up in the main module,
> not the sub-module.  The next commit will explain why that's bad, and
> fix it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qapi-schema/qapi-schema-test.json | 3 ++-
>  tests/qapi-schema/qapi-schema-test.out  | 5 +++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
