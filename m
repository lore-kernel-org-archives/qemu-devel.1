Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58CC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE6A20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 18:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej2aKg0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE6A20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir4f0-0008Tl-UH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 13:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ir4eI-0007vu-9p
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ir4eF-0007Ny-1w
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:41:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21870
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ir4eE-0007N2-TR
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 13:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578940869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzsvSn3vm+wBgNMJ8PeCKY2Pk4Acog14y15igrOXvYo=;
 b=Ej2aKg0OrdLngKsZLfmnFwyAhwTPAIf+AEa6lZ84O+Bx+Xvvg3kpXXi2FSV9lnD6E/3/8F
 bA+pg1OiaTgENXdna/y3u54jM0RUo8UiXxWACkEppOAu2/0Y3PbXFhI0yTOesW5wr6G3sc
 KvgAgqCte+LST5H23TzS+0RE9MCLk70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-5paUai2PN46VI-a3bWSjqw-1; Mon, 13 Jan 2020 13:41:05 -0500
X-MC-Unique: 5paUai2PN46VI-a3bWSjqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10E9907607;
 Mon, 13 Jan 2020 18:41:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3302A19C5B;
 Mon, 13 Jan 2020 18:40:57 +0000 (UTC)
Date: Mon, 13 Jan 2020 19:40:55 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 14/16] arm/run: Allow Migration tests
Message-ID: <20200113184055.tu3qqpsc72xqfw6t@kamzik.brq.redhat.com>
References: <20200110145412.14937-1-eric.auger@redhat.com>
 <20200110145412.14937-15-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110145412.14937-15-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 03:54:10PM +0100, Eric Auger wrote:
> Let's link getchar.o to use puts and getchar from the
> tests.
> 
> Then allow tests belonging to the migration group to
> trigger the migration from the test code by putting
> "migrate" into the uart. Then the code can wait for the
> migration completion by using getchar().
> 
> The __getchar implement is minimalist as it just reads the
> data register. It is just meant to read the single character
> emitted at the end of the migration by the runner script.
> 
> It is not meant to read more data (FIFOs are not enabled).
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  arm/Makefile.common |  2 +-
>  arm/run             |  2 +-
>  lib/arm/io.c        | 13 +++++++++++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index 7cc0f04..327f112 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -32,7 +32,7 @@ CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
>  asm-offsets = lib/$(ARCH)/asm-offsets.h
>  include $(SRCDIR)/scripts/asm-offsets.mak
>  
> -cflatobjs += lib/util.o
> +cflatobjs += lib/util.o lib/getchar.o
>  cflatobjs += lib/alloc_phys.o
>  cflatobjs += lib/alloc_page.o
>  cflatobjs += lib/vmalloc.o
> diff --git a/arm/run b/arm/run
> index 277db9b..a390ca5 100755
> --- a/arm/run
> +++ b/arm/run
> @@ -61,6 +61,6 @@ fi
>  M+=",accel=$ACCEL"
>  command="$qemu -nodefaults $M -cpu $processor $chr_testdev $pci_testdev"
>  command+=" -display none -serial stdio -kernel"
> -command="$(timeout_cmd) $command"
> +command="$(migration_cmd) $(timeout_cmd) $command"
>  
>  run_qemu $command "$@"
> diff --git a/lib/arm/io.c b/lib/arm/io.c
> index 99fd315..ed89e19 100644
> --- a/lib/arm/io.c
> +++ b/lib/arm/io.c
> @@ -87,6 +87,19 @@ void puts(const char *s)
>  	spin_unlock(&uart_lock);
>  }
>  
> +/*
> + * Minimalist implementation for migration completion detection.
> + * Needs to be improved for more advanced Rx cases

Please add that QEMU supports reading a maximum of 16 characters in
this minimal mode. We could even add a counter and then assert if
we try to read 16 or more.

> + */
> +int __getchar(void)
> +{
> +	int ret;
> +
> +	ret = readb(uart0_base);
> +	if (!ret)
> +		return -1;
> +	return ret;
> +}

What about taking the lock?

>  
>  /*
>   * Defining halt to take 'code' as an argument guarantees that it will
> -- 
> 2.20.1
> 

What do you think of the __getchar below?

Thanks,
drew


diff --git a/lib/arm/io.c b/lib/arm/io.c
index 99fd31560084..77beb331d6b2 100644
--- a/lib/arm/io.c
+++ b/lib/arm/io.c
@@ -79,6 +79,31 @@ void io_init(void)
 	chr_testdev_init();
 }
 
+static int ____getchar(void)
+{
+	int c;
+
+	spin_lock(&uart_lock);
+	c = readb(uart0_base);
+	spin_unlock(&uart_lock);
+
+	return c ?: -1;
+}
+
+int __getchar(void)
+{
+	static int count;
+	int c;
+
+	if ((c = ____getchar()) != -1)
+		++count;
+
+	/* Without special UART initialization we can only read 16 characters. */
+	assert(count < 16);
+
+	return c;
+}
+
 void puts(const char *s)
 {
 	spin_lock(&uart_lock);


