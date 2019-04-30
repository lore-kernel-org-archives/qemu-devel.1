Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7617AC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D52080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOR8-0007Uf-Fp
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:48:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLOQD-0007BG-Gi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLOQC-00045F-Fi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLOQC-00044t-9y
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:47:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so19985254wrq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=0Mn8qBmdS7ft5wU/mg9V+eAFAFymY2hW2FXzmOLO1UU=;
	b=YD6SaTu+Xyix/hGdGNZFWQ3sjXvekgn9WRyDb0BiqPMyNe8Uxn37WaE3yxWMpoSneZ
	+1utzm8EQfaI8Y/elistDXMkRvSnDy7i8+DoykSIGvBj8yo4B8Z5sY50PW6zRMqIqBJS
	DyawgNDVf/mHSb9ZtDzrnIKsDWHUXmyK+jFJERWidaN/ASVuktWiYcjNAyQ3AS3yEReU
	XQVNTk5LB8SWW7eXNDairdT7/KW9SthkE3GEJg3HIO5BrKH/2P9r6AkEu+FGyHMNHXWw
	IEoMkbG/ZBFHLmfPCcpdp3jta08kzIUwQ/OzhJR8A+KWRd33FUoR3RPGlSKsr5DzadHT
	/VGQ==
X-Gm-Message-State: APjAAAVzphVL3ZWQfs7jN+SVu5cMnCmhbN0yJUADsDASEFdb+1i1wU+g
	vQBy9x2Zj5Oj/jo85SOvpPe0vA==
X-Google-Smtp-Source: APXvYqxt0TKG0Dr+mZgf56vPPax/H/t+gSxKp7/UV1QOdUEQdoBg1E1HkMs1LQpNDi0g+zXaO2fcBg==
X-Received: by 2002:adf:f70a:: with SMTP id r10mr27408156wrp.96.1556614047217; 
	Tue, 30 Apr 2019 01:47:27 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id m4sm7709767wrb.15.2019.04.30.01.47.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 01:47:26 -0700 (PDT)
Date: Tue, 30 Apr 2019 10:47:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190430084724.ee2zeudgrqfoldmo@steredhat>
References: <20190427135642.16464-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190427135642.16464-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] qom/object: Display more helpful message
 when an object type is missing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430084724.OXt_Xjv733xU4_ceyVedF2bTD6QhH2KS_HOfnbidaR8@z>

On Sat, Apr 27, 2019 at 03:56:42PM +0200, Philippe Mathieu-Daudé wrote:
> When writing a new board, adding device which uses other devices
> (container) or simply refactoring, one can discover the hard way
> his machine misses some devices. In the case of containers, the
> error is not obvious:
> 
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   **
>   ERROR:/source/qemu/qom/object.c:454:object_initialize_with_type: assertion failed: (type != NULL)
>   Aborted (core dumped)
> 
> And we have to look at the coredump to figure the error:
> 
>   (gdb) bt
>   #1  0x00007f84773cf895 in abort () at /lib64/libc.so.6
>   #2  0x00007f847961fb53 in  () at /lib64/libglib-2.0.so.0
>   #3  0x00007f847967a4de in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>   #4  0x000055c4bcac6c11 in object_initialize_with_type (data=data@entry=0x55c4bdf239e0, size=size@entry=2464, type=<optimized out>) at /source/qemu/qom/object.c:454
>   #5  0x000055c4bcac6e6d in object_initialize (data=data@entry=0x55c4bdf239e0, size=size@entry=2464, typename=typename@entry=0x55c4bcc7c643 "xlnx.zynqmp_ipi") at /source/qemu/qom/object.c:474
>   #6  0x000055c4bc9ea474 in xlnx_zynqmp_pmu_init (machine=0x55c4bdd46000) at /source/qemu/hw/microblaze/xlnx-zynqmp-pmu.c:176
>   #7  0x000055c4bca3b6cb in machine_run_board_init (machine=0x55c4bdd46000) at /source/qemu/hw/core/machine.c:1030
>   #8  0x000055c4bc95f6d2 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /source/qemu/vl.c:4479
> 
> Since the caller knows the type name requested, we can simply display it
> to ease development.
> 
> With this patch applied we get:
> 
>   $ qemu-system-microblaze -M xlnx-zynqmp-pmu
>   qemu-system-microblaze: missing object type 'xlnx.zynqmp_ipi'
>   Aborted (core dumped)
> 
> Since the assert(type) check in object_initialize_with_type() is
> now impossible, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  qom/object.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Very appreciated!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

