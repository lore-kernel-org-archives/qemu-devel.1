Received: from eggs.gnu.org ([2001:4830:134:3::10]:49013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eupu6-00055k-1B
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eupu2-0005gw-US
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:36:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eupu2-0005gj-Hf
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 20:35:58 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-12-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c11aae81-0004-1acb-52bc-8b9c8c1e09c9@redhat.com>
Date: Sat, 10 Mar 2018 19:35:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-12-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 11/23] monitor: introduce
 monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> A tiny refactoring, preparing to split the QMP dispatcher away.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 50 +++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 17 deletions(-)
> 

> +    if (rsp) {
> +        if (id) {
> +            /* This is for the qdict below. */
> +            qobject_incref(id);
> +            qdict_put_obj(qobject_to_qdict(rsp), "id", id);

Another victim of qobject_to() refactoring.

Fixing that is minor, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
