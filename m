Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzfI-0005LN-Fj
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gNzfE-0008UI-Hh
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:25:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gNzfE-0008QB-BX
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 07:25:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id q26so1034687wmf.5
	for <qemu-devel@nongnu.org>; Sat, 17 Nov 2018 04:25:28 -0800 (PST)
References: <20181113071336.6242-1-yuval.shaia@oracle.com>
	<20181113071336.6242-22-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <611957d8-b4ff-77c4-e365-d23f53b4484f@gmail.com>
Date: Sat, 17 Nov 2018 14:25:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181113071336.6242-22-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 21/23] hw/rdma: Do not use
 bitmap_zero_extend to free bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com



On 11/13/18 9:13 AM, Yuval Shaia wrote:
> bitmap_zero_extend is designed to work for extending, not for
> shrinking.
> Using g_free instead.
>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   hw/rdma/rdma_rm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> index 0a5ab8935a..35a96d9a64 100644
> --- a/hw/rdma/rdma_rm.c
> +++ b/hw/rdma/rdma_rm.c
> @@ -43,7 +43,7 @@ static inline void res_tbl_free(RdmaRmResTbl *tbl)
>   {
>       qemu_mutex_destroy(&tbl->lock);
>       g_free(tbl->tbl);
> -    bitmap_zero_extend(tbl->bitmap, tbl->tbl_sz, 0);
> +    g_free(tbl->bitmap);
>   }
>   
>   static inline void *res_tbl_get(RdmaRmResTbl *tbl, uint32_t handle)

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
