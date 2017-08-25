Received: from eggs.gnu.org ([2001:4830:134:3::10]:52813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dlFDd-0005fh-Qg
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dlFDZ-0003ou-S8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dlFDZ-0003oc-MM
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:13 -0400
Date: Fri, 25 Aug 2017 16:04:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170825160408.2775c8b5.cohuck@redhat.com>
In-Reply-To: <3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com

On Fri, 25 Aug 2017 09:24:46 -0400
Farhan Ali <alifm@linux.vnet.ibm.com> wrote:

> The commit 198c0d1f9df8c4 s390x/css: check ccw address validity
> exposes an alignment issue in ccw bios.
> 
> According to PoP the CCW must be doubleword aligned. Let's fix
> this in the bios.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
> index f5b4549..55eaeee 100644
> --- a/pc-bios/s390-ccw/cio.h
> +++ b/pc-bios/s390-ccw/cio.h
> @@ -133,7 +133,7 @@ struct ccw1 {
>      __u8 flags;
>      __u16 count;
>      __u32 cda;
> -} __attribute__ ((packed));
> +} __attribute__ ((packed, aligned(8)));
>  
>  #define CCW_FLAG_DC              0x80
>  #define CCW_FLAG_CC              0x40

Currently testing.

This looks obviously right, but did you figure out what the (probably
unrelated) other failure was?
