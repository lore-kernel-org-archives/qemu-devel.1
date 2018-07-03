Received: from eggs.gnu.org ([2001:4830:134:3::10]:60345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB3b-0001Cq-J3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB3Y-0002l1-BN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB3Y-0002kX-4k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD2658160F82
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:28:39 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-28-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5795c7a-0314-9dbb-dd8b-48259c731043@redhat.com>
Date: Mon, 2 Jul 2018 21:28:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 27/32] qmp: Add some comments around null
 responses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/qmp-dispatch.c | 2 ++
>   1 file changed, 2 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 761812e924..6f2d466596 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -133,6 +133,7 @@ static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request,
>       } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
>           g_assert(!ret);
>       } else if (!ret) {
> +        /* TODO turn into assertion */
>           ret = QOBJECT(qdict_new());
>       }
>   
> @@ -176,6 +177,7 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
>           rsp = qdict_new();
>           qdict_put_obj(rsp, "return", ret);
>       } else {
> +        /* Can only happen for commands with QCO_NO_SUCCESS_RESP */
>           rsp = NULL;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
