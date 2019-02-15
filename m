Received: from eggs.gnu.org ([209.51.188.92]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gue9u-0000Pu-Ay
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gue9t-0007rW-Iw
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gue9t-0007oe-AB
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FDwskD113225
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:08:03 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp2130.oracle.com with ESMTP id 2qhre5x05p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:08:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1FE7vHH002692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:07:57 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1FE7u1w001484
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:07:57 GMT
References: <1550227757-10869-2-git-send-email-pbonzini@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <23c50a32-dbe3-db22-fec5-f0fd9acf11dc@oracle.com>
Date: Fri, 15 Feb 2019 14:07:50 +0000
MIME-Version: 1.0
In-Reply-To: <1550227757-10869-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: remove unnecessary assignments from
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 15/02/2019 10:49, Paolo Bonzini wrote:
> It is only necessary to clear block-obj-y because Makefile.objs
> uses "+=" instead of "="; fix that and remove the assignment.
> The other variables need not be cleared at all.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   Makefile.objs   | 2 +-
>   Makefile.target | 4 ----
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Makefile.objs b/Makefile.objs
> index c3a2354..e5cc928 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -22,7 +22,7 @@ slirp-obj-$(CONFIG_SLIRP) = slirp/
>   #######################################################################
>   # block-obj-y is code used by both qemu system emulation and qemu-img
>   
> -block-obj-y += nbd/
> +block-obj-y = nbd/
>   block-obj-y += block.o blockjob.o job.o
>   block-obj-y += block/ scsi/
>   block-obj-y += qemu-io-cmds.o
> diff --git a/Makefile.target b/Makefile.target
> index a56a72f..06b44c0 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -174,10 +174,6 @@ endif # CONFIG_SOFTMMU
>   dummy := $(call unnest-vars,,obj-y)
>   all-obj-y := $(obj-y)
>   
> -block-obj-y :=
> -common-obj-y :=
> -chardev-obj-y :=
> -slirp-obj-y :=
>   include $(SRC_PATH)/Makefile.objs
>   dummy := $(call unnest-vars,.., \
>                  block-obj-y \
> 
