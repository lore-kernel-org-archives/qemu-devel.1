Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BITCOIN_SPAM_02,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FF6C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEB7206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRaVXlnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEB7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXbK-0003Dx-Bt
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icXUo-0007V8-D3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icXUm-0004bo-CI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:27:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29079
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icXUm-0004bE-8j
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575476837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=XgSBMX7QaG545SIWQOnLBcvBjoAWoabk9DvDE6Y8fyE=;
 b=VRaVXlnvRWwncxwHt8zJk4xNJ+nkiAg9gFcFx2Mxnb3hS6Q6/jcRclwX5zi8P2bzw6ALCr
 v3JGtGIitfyyERzLz3Y6G21ccKYQDkIkrIhqn6GrnjfYK/+IfS133pidULxQklIuLCdWmc
 iyRJnvyQtX6c9eLn88OshhhfQymBZFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-4VpLxPSJO86Br9Ph_5Yfrg-1; Wed, 04 Dec 2019 11:27:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F93B107ACFB;
 Wed,  4 Dec 2019 16:27:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B5F5D6BE;
 Wed,  4 Dec 2019 16:27:11 +0000 (UTC)
Subject: Re: [PATCH] target/sparc: Remove old TODO file
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20190930171044.25312-1-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1b2ecf64-ee98-6a05-2455-436f822a7163@redhat.com>
Date: Wed, 4 Dec 2019 17:27:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930171044.25312-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4VpLxPSJO86Br9Ph_5Yfrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2019 19.10, Thomas Huth wrote:
> This file hasn't seen a real (non-trivial) update since 2008 anymore,
> so we can assume that it is pretty much out of date and nobody cares
> for it anymore. Let's simply remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/sparc/TODO | 88 -----------------------------------------------
>  1 file changed, 88 deletions(-)
>  delete mode 100644 target/sparc/TODO
> 
> diff --git a/target/sparc/TODO b/target/sparc/TODO
> deleted file mode 100644
> index b8c727e858..0000000000
> --- a/target/sparc/TODO
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -TODO-list:
> -
> -CPU common:
> -- Unimplemented features/bugs:
> - - Delay slot handling may fail sometimes (branch end of page, delay
> - slot next page)
> - - Atomical instructions
> - - CPU features should match real CPUs (also ASI selection)
> -- Optimizations/improvements:
> - - Condition code/branch handling like x86, also for FPU?
> - - Remove remaining explicit alignment checks
> - - Global register for regwptr, so that windowed registers can be
> - accessed directly
> - - Improve Sparc32plus addressing
> - - NPC/PC static optimisations (use JUMP_TB when possible)? (Is this
> - obsolete?)
> - - Synthetic instructions
> - - MMU model dependent on CPU model
> - - Select ASI helper at translation time (on V9 only if known)
> - - KQemu/KVM support for VM only
> - - Hardware breakpoint/watchpoint support
> - - Cache emulation mode
> - - Reverse-endian pages
> - - Faster FPU emulation
> - - Busy loop detection
> -
> -Sparc32 CPUs:
> -- Unimplemented features/bugs:
> - - Sun4/Sun4c MMUs
> - - Some V8 ASIs
> -
> -Sparc64 CPUs:
> -- Unimplemented features/bugs:
> - - Interrupt handling
> - - Secondary address space, other MMU functions
> - - Many V9/UA2005/UA2007 ASIs
> - - Rest of V9 instructions, missing VIS instructions
> - - IG/MG/AG vs. UA2007 globals
> - - Full hypervisor support
> - - SMP/CMT
> - - Sun4v CPUs
> -
> -Sun4:
> -- To be added
> -
> -Sun4c:
> -- A lot of unimplemented features
> -- Maybe split from Sun4m
> -
> -Sun4m:
> -- Unimplemented features/bugs:
> - - Hardware devices do not match real boards
> - - Floppy does not work
> - - CS4231: merge with cs4231a, add DMA
> - - Add cg6, bwtwo
> - - Arbitrary resolution support
> - - PCI for MicroSparc-IIe
> - - JavaStation machines
> - - SBus slot probing, FCode ROM support
> - - SMP probing support
> - - Interrupt routing does not match real HW
> - - SuSE 7.3 keyboard sometimes unresponsive
> - - Gentoo 2004.1 SMP does not work
> - - SS600MP ledma -> lebuffer
> - - Type 5 keyboard
> - - Less fixed hardware choices
> - - DBRI audio (Am7930)
> - - BPP parallel
> - - Diagnostic switch
> - - ESP PIO mode
> -
> -Sun4d:
> -- A lot of unimplemented features:
> - - SBI
> - - IO-unit
> -- Maybe split from Sun4m
> -
> -Sun4u:
> -- Unimplemented features/bugs:
> - - Interrupt controller
> - - PCI/IOMMU support (Simba, JIO, Tomatillo, Psycho, Schizo, Safari...)
> - - SMP
> - - Happy Meal Ethernet, flash, I2C, GPIO
> - - A lot of real machine types
> -
> -Sun4v:
> -- A lot of unimplemented features
> - - A lot of real machine types
> 

Ping?

 Thomas


