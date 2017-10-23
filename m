Received: from eggs.gnu.org ([2001:4830:134:3::10]:34601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e6arq-0004Gh-MR
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:26:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e6arl-0000Aq-0k
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:26:02 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:35445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1e6ark-0000Ad-PE
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:25:56 -0400
Date: Mon, 23 Oct 2017 12:25:50 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171023112550.lkwzsidpotdroyeh@starbug-vm.ie.oracle.com>
References: <1508786879-32603-1-git-send-email-zhiyong.wu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1508786879-32603-1-git-send-email-zhiyong.wu@ucloud.cn>
Subject: Re: [Qemu-devel] [PATCH] COLO: remove the operation to clear
 connection list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhiyong.wu@ucloud.cn
Cc: qemu-devel@nongnu.org

That's consistent with the documented behaviour of
g_hash_table_remove_all().


   Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

Thanks,

Darren.

On Tue, Oct 24, 2017 at 03:27:59AM +0800, zhiyong.wu@ucloud.cn wrote:
>From: Zhi Yong Wu <zhiyong.wu@ucloud.cn>
>
>When hash table is created with g_hash_table_new_full(),
>the free function has been registered. So it isn't necessary
>since g_hash_table_remove_all() will call connection_destroy()
>for each connection struct automatically.
>
>Signed-off-by: Zhi Yong Wu <zhiyong.wu@ucloud.cn>
>---
> net/colo.c |    6 ------
> 1 files changed, 0 insertions(+), 6 deletions(-)
>
>diff --git a/net/colo.c b/net/colo.c
>index 28ce7c8..668abb7 100644
>--- a/net/colo.c
>+++ b/net/colo.c
>@@ -197,12 +197,6 @@ Connection *connection_get(GHashTable *connection_track_table,
>             trace_colo_proxy_main("colo proxy connection hashtable full,"
>                                   " clear it");
>             connection_hashtable_reset(connection_track_table);
>-            /*
>-             * clear the conn_list
>-             */
>-            while (!g_queue_is_empty(conn_list)) {
>-                connection_destroy(g_queue_pop_head(conn_list));
>-            }
>         }
>
>         g_hash_table_insert(connection_track_table, new_key, conn);
>-- 
>1.7.1
>
>
