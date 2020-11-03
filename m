Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9658BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2305206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqNwQ4dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2305206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZucX-0003GM-Lm
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZuUC-0004Bh-AK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kZuUA-000795-CV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU7QFvwrVx1l3RVXKVDYqwQocC3lMlX5oGRRksgES8M=;
 b=UqNwQ4dZOECECq1uYK4P+pFHzAUOYf0J41FVjnX2VwuLX/CjGghEd7HoeumBBo8XtdSrbV
 nglKr6u/5ka2GmBfkmLYDLc7sCtw6G1MdKlxzBH0QZvVIZzmcEB/LiplhTO6DEcAJ7ALZc
 8A6FpRjeL/HHe1ExqIsf6B/oF9SD46U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-OYD73tMpMnKZzLZfB_7Png-1; Tue, 03 Nov 2020 06:28:19 -0500
X-MC-Unique: OYD73tMpMnKZzLZfB_7Png-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8222186DD21;
 Tue,  3 Nov 2020 11:28:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-233.ams2.redhat.com [10.36.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E444F6EF7E;
 Tue,  3 Nov 2020 11:28:13 +0000 (UTC)
Subject: Re: [PATCH-for-5.2] MAINTAINERS: Demote Renesas target & hardware to
 'Odd Fixes'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201102104001.2062572-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12d9ccc4-1824-b8b3-c132-1795c2a6919a@redhat.com>
Date: Tue, 3 Nov 2020 12:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201102104001.2062572-1-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/2020 11.40, Philippe Mathieu-Daudé wrote:
> To be fair with other subsystems listed as 'Odd Fixes' but having
> maintainers more present, demote the Renesas sections from being
> 'Maintained' to 'Odd Fixes' (has a maintainer but they don't have
> time to do much other than throw the odd patch in.)
> 
> This matches Magnus's possibilities so far:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg710319.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c744a9bdf4..ff7c42ba451 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -289,7 +289,7 @@ F: linux-user/host/riscv64/
>  
>  RENESAS RX CPUs
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
> -S: Maintained
> +S: Odd Fixes
>  F: target/rx/
>  
>  S390 TCG CPUs
> @@ -1334,7 +1334,7 @@ RX Machines
>  -----------
>  rx-gdbsim
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
> -S: Maintained
> +S: Odd Fixes
>  F: docs/system/target-rx.rst
>  F: hw/rx/rx-gdbsim.c
>  F: tests/acceptance/machine_rx_gdbsim.py
> @@ -1344,7 +1344,7 @@ SH4 Machines
>  R2D
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  R: Magnus Damm <magnus.damm@gmail.com>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: include/hw/sh4/sh_intc.h
> @@ -2075,7 +2075,7 @@ F: docs/*/*xive*
>  Renesas peripherals
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  R: Magnus Damm <magnus.damm@gmail.com>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/char/renesas_sci.c
>  F: hw/char/sh_serial.c
>  F: hw/timer/renesas_*.c
> @@ -2086,7 +2086,7 @@ F: include/hw/timer/renesas_*.h
>  
>  Renesas RX peripherals
>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
> -S: Maintained
> +S: Odd Fixes
>  F: hw/intc/rx_icu.c
>  F: hw/rx/
>  F: include/hw/intc/rx_icu.h
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


