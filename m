Received: from eggs.gnu.org ([2001:4830:134:3::10]:58711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVALU-0007at-2J
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVALN-0001Pm-Tg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:14:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVALN-0001PQ-OR
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 02:14:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A58019CF74
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 07:14:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-2-pbonzini@redhat.com>
Date: Fri, 07 Dec 2018 08:14:35 +0100
In-Reply-To: <20181206232333.22408-2-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 7 Dec 2018 00:23:28 +0100")
Message-ID: <87k1kl3j1g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu/queue.h: do not access tqe_prev
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Use the QTAILQ_IN_USE macro instead, it does the same thing but the next
> patch will change it to a different definition.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/blockdev.c b/blockdev.c
> index 81f95d920b..7604b2183b 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4259,7 +4259,7 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
>          goto out;
>      }
>  
> -    if (!bs->monitor_list.tqe_prev) {
> +    if (!QTAILQ_IN_USE(bs, monitor_list)) {
>          error_setg(errp, "Node %s is not owned by the monitor",
>                     bs->node_name);
>          goto out;

Reviewed-by: Markus Armbruster <armbru@redhat.com>
