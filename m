Received: from eggs.gnu.org ([2001:4830:134:3::10]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1egsxP-00065p-Fi
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1egsxH-0003mw-N6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1egsxH-0003mM-G2
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 09:01:39 -0500
Date: Wed, 31 Jan 2018 16:01:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180131160104-mutt-send-email-mst@kernel.org>
References: <1517367668-25048-1-git-send-email-wangxinxin.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517367668-25048-1-git-send-email-wangxinxin.wang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] pc: correct misspelled CPU model-id for pc
 2.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Xin <wangxinxin.wang@huawei.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, arei.gonglei@huawei.com

On Wed, Jan 31, 2018 at 11:01:08AM +0800, Wang Xin wrote:
> Signed-off-by: Wang Xin <wangxinxin.wang@huawei.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Eduardo, will you take this?

> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index bb49165..635c8b2 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -617,7 +617,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
>  #define PC_COMPAT_2_2 \
>      HW_COMPAT_2_2 \
> -    PC_CPU_MODEL_IDS("2.3.0") \
> +    PC_CPU_MODEL_IDS("2.2.0") \
>      {\
>          .driver = "kvm64" "-" TYPE_X86_CPU,\
>          .property = "vme",\
> -- 
> 2.8.1.windows.1
> 
