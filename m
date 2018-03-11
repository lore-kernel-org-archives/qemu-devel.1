Received: from eggs.gnu.org ([2001:4830:134:3::10]:51349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqLG-0005Fg-JW
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqLD-0001uC-GE
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:04:06 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60206 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqLD-0001tl-Au
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:04:03 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-16-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b6e171f-6062-5d9a-4790-cdac5b21112a@redhat.com>
Date: Sat, 10 Mar 2018 20:03:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-16-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 15/23] qmp: add new event
 "command-dropped"
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
> This event will be emitted if one QMP command is dropped.  Along,

s/Along,/Also,/

> declare an enum for the reasons.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/misc.json | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 0123143d4b..8c7e736681 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
