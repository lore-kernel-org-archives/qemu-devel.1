Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb1Ls-00022p-Ir
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb1Lp-0005Rt-Hy
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb1Lp-0005RE-B9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:46:45 -0500
References: <1515934519-16158-1-git-send-email-linzc@zju.edu.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fad2f5d-a8e1-cde5-711a-ecbfcda60b59@redhat.com>
Date: Mon, 15 Jan 2018 10:46:41 +0100
MIME-Version: 1.0
In-Reply-To: <1515934519-16158-1-git-send-email-linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: set ioeventfd_update_pending after
 address_space_update_ioeventfds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzc@zju.edu.cn>, qemu-devel@nongnu.org

On 14/01/2018 13:55, linzhecheng wrote:
> We should set ioeventfd_update_pending same as memory_region_update_pending.
> 
> Signed-off-by: linzhecheng <linzc@zju.edu.cn>

Thanks.  This indeed fixes a bug introduced by commit
ade9c1aac5292ff698fa550adebe794c37d86cc9.

Paolo

> ---
>  memory.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/memory.c b/memory.c
> index 4b41fb8..0cf39d0 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1091,6 +1091,7 @@ void memory_region_transaction_commit(void)
>                  address_space_update_ioeventfds(as);
>              }
>              memory_region_update_pending = false;
> +            ioeventfd_update_pending = false;
>              MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
>          } else if (ioeventfd_update_pending) {
>              QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
> 
