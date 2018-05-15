Received: from eggs.gnu.org ([2001:4830:134:3::10]:40686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIc8U-000274-Mx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIc8R-0004Xn-Ue
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIc8R-0004XT-O9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:45:07 -0400
References: <1526384108-49348-1-git-send-email-jianjay.zhou@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3bdf71d-71c6-b562-43b6-58ecf0865e4b@redhat.com>
Date: Tue, 15 May 2018 17:45:04 +0200
MIME-Version: 1.0
In-Reply-To: <1526384108-49348-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: delete struct AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com

On 15/05/2018 13:35, Jay Zhou wrote:
> Since struct AddressSpaceOps isn't used anywhere else,
> so just delete it.
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  memory.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index fc7f9b7..94b91f9 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -220,8 +220,6 @@ struct FlatRange {
>      bool readonly;
>  };
>  
> -typedef struct AddressSpaceOps AddressSpaceOps;
> -
>  #define FOR_EACH_FLAT_RANGE(var, view)          \
>      for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)
>  
> 

Queued, thanks.

Paolo
