Received: from eggs.gnu.org ([2001:4830:134:3::10]:51522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnN8q-0004IS-2B
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fnN8m-0006sR-56
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:00:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fnN8l-0006rm-GF
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 08:00:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B858787916
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 12:00:34 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ca087b01-80d8-16cf-9b9a-b4b56e3e66e8@redhat.com>
Date: Wed, 8 Aug 2018 14:00:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak       | 2 --
>  default-configs/arm-softmmu.mak         | 2 --
>  default-configs/hppa-softmmu.mak        | 3 ---
>  default-configs/i386-softmmu.mak        | 2 --
>  default-configs/mips-softmmu-common.mak | 2 --
>  default-configs/ppc-softmmu.mak         | 1 -
>  default-configs/ppcemb-softmmu.mak      | 2 --
>  default-configs/sh4-softmmu.mak         | 2 --
>  default-configs/sh4eb-softmmu.mak       | 2 --
>  default-configs/sparc64-softmmu.mak     | 2 --
>  default-configs/x86_64-softmmu.mak      | 2 --
>  11 files changed, 22 deletions(-)
> 
> diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
> index bbe361f01a..2d81a98441 100644
> --- a/default-configs/alpha-softmmu.mak
> +++ b/default-configs/alpha-softmmu.mak
> @@ -2,8 +2,6 @@
>  
>  include pci.mak
>  include usb.mak
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_I82374=y
>  CONFIG_I8254=y
>  CONFIG_I8257=y
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 834d45cfaf..4d33e9983d 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -5,8 +5,6 @@ include usb.mak
>  CONFIG_VGA=y
>  CONFIG_NAND=y
>  CONFIG_ECC=y
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
>  CONFIG_PTIMER=y
>  CONFIG_SD=y
>  CONFIG_MAX7310=y
> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
> index 4badc0521e..f3712afc27 100644
> --- a/default-configs/hppa-softmmu.mak
> +++ b/default-configs/hppa-softmmu.mak
> @@ -1,8 +1,5 @@
>  include pci.mak
>  include usb.mak
> -CONFIG_SERIAL=y
> -CONFIG_SERIAL_ISA=y
> -CONFIG_ISA_BUS=y

You should maybe mention CONFIG_ISA_BUS in the patch description, too.

Apart from that nit:

Reviewed-by: Thomas Huth <thuth@redhat.com>
