Received: from eggs.gnu.org ([2001:4830:134:3::10]:38508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYDu-0003TL-KZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUYDr-0003pt-ET
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:23:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUYDr-0003pP-8M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:23:15 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A796C05AA48
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 12:23:15 +0000 (UTC)
References: <20170118175343.GA26873@amt.cnet>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f83f95ce-c4db-6b45-3d91-11977400f043@redhat.com>
Date: Fri, 20 Jan 2017 13:23:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170118175343.GA26873@amt.cnet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH] pc.h: move
 x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 18/01/2017 18:53, Marcelo Tosatti wrote:
> 
> As noticed by David Gilbert, commit 6053a86 'kvmclock: reduce kvmclock
> differences on migration' added 'x-mach-use-reliable-get-clock' and a
> compatibility entry that turns it off; however it got merged after 2.8.0
> was released but the entry has gone into PC_COMPAT_2_7 where it should
> have gone into PC_COMPAT_2_8.
> 
> Fix it by moving the entry to PC_COMPAT_2_8.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index b22e699..738bfd6 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -375,14 +375,15 @@ int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
>  #define PC_COMPAT_2_8 \
> -
> -#define PC_COMPAT_2_7 \
> -    HW_COMPAT_2_7 \
> +    HW_COMPAT_2_8 \
>      {\
>          .driver   = "kvmclock",\
>          .property = "x-mach-use-reliable-get-clock",\
>          .value    = "off",\
>      },\
> +
> +#define PC_COMPAT_2_7 \
> +    HW_COMPAT_2_7 \
>      {\
>          .driver   = TYPE_X86_CPU,\
>          .property = "l3-cache",\
> 
> 

Queued, thanks.

Paolo
