Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1faMTy-00087x-U2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1faMTv-0003EI-Qb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:40:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1faMTv-0003CG-LR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 10:40:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B77D857AB
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 14:40:38 +0000 (UTC)
References: <489fd750574cf761c1f083eaa7d2306e41035004.1522004432.git.crobinso@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <5b7975a2-d5ff-d975-ea41-e8f67c701df9@redhat.com>
Date: Tue, 3 Jul 2018 10:40:38 -0400
MIME-Version: 1.0
In-Reply-To: <489fd750574cf761c1f083eaa7d2306e41035004.1522004432.git.crobinso@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH sgabios] Makefile: Add HOSTCC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

I probably should have added more context here...

We carry this patch to sgabios in Fedora to enable cross compilation. It
would be nice to get it into the qemu sgabios git repo so we don't have
to track it downstream anymore

Thanks,
Cole

On 03/25/2018 03:03 PM, Cole Robinson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 970b0ff..c8cb92b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -30,6 +30,7 @@ ASFLAGS += -DBUILD_USER="$(BUILD_USER)"
>  LDSCRIPT := rom16.ld
>  LDFLAGS := -T $(LDSCRIPT) -nostdlib
>  OBJCOPY := objcopy
> +HOSTCC := $(CC)
>  
>  ASRCS = sgabios.S
>  
> @@ -55,7 +56,7 @@ sgabios.elf: .depend $(OBJS) $(LDSCRIPT) csum8
>  	$(LD) $(LDFLAGS) $(OBJS) -o $@
>  
>  csum8: csum8.c
> -	$(CC) -Wall -O2 -o $@ $<
> +	$(HOSTCC) -Wall -O2 -o $@ $<
>  
>  sgabios.o: buildinfo
>  
> 
