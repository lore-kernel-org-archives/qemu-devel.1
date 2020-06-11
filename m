Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85ED92072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5kGyNsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85ED92072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIY1-00051u-OJ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjIWs-00036B-Ej
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:25:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjIWr-0007Ti-DO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591863940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=t9VqhlzNJD2uk9P1MOMSfAcgQrhIajOmDrqT1VUUN+4=;
 b=M5kGyNsJmkNVhgYA33LSdgwj3iTwiBgDgUlG1LeJ5LdXK6QL5onsJE0e4EyrHriMw7s/Rw
 lhOpP4OLd7Z0uDl+nZ8K/f9UQPiPZfLRL3rNxbkwUQumV4iSzjQdRaUuzREfv2mzjSy70g
 YumqehAl2zv+aXBvLa7xeRd1keaD+pA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-UD9CDRdyMteYp22NGrb-9w-1; Thu, 11 Jun 2020 04:25:38 -0400
X-MC-Unique: UD9CDRdyMteYp22NGrb-9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FC5A464;
 Thu, 11 Jun 2020 08:25:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-215.ams2.redhat.com [10.36.113.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EB38FF77;
 Thu, 11 Jun 2020 08:25:35 +0000 (UTC)
Subject: Re: [PATCH 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200610221743.24627-1-aleksandar.qemu.devel@gmail.com>
 <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <05510fa8-f2f7-7f66-13e4-59e6210adcb0@redhat.com>
Date: Thu, 11 Jun 2020 10:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200610221743.24627-2-aleksandar.qemu.devel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/2020 00.17, Aleksandar Markovic wrote:
> This patch transfers sh4 sections to Yoshinori Sato, who is best
> positioned in the community to assume their maintainership. He is
> the maintainer of the related target rx.
> 
> Further adjustments, reorganizations, and improvements of sh4
> sections are left to the future maintainer to be devised and
> executed, as he deems suitable.
> 
> Aurealien and Magnus are deleted from some sections from the
> MAINTAINERS file with this patch. However, they will not be
> deleted from QEMU Hall of Fame, where their names will always
> be carved in stone as QEMU pioneers and granddadies.
> 
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Magnus Damm <magnus.damm@gmail.com>
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>

They more or less "acked" Philippe's patch, but I don't think you can
conclude from that that they agree to your changes automatically, too.
So please don't put "Acked-by"s into your completely new patch that you
did not gather yourself.

> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7890ce82..7ddb6db38c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,7 +296,7 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>  
>  SH4 TCG CPUs
> -M: Aurelien Jarno <aurelien@aurel32.net>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Odd Fixes
>  F: target/sh4/
>  F: hw/sh4/
> @@ -1251,14 +1251,14 @@ F: include/hw/riscv/opentitan.h
>  SH4 Machines
>  ------------
>  R2D
> -M: Magnus Damm <magnus.damm@gmail.com>
> +M: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Maintained
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
>  F: hw/timer/sh_timer.c

Magnus said that he is still interested in R2D, just does not have the
time anymore to actively maintain it. So I think it is a bad idea if you
completely remove him here. His line should be changed from "M:" to "R:"
instead unless he explicitely states that he wants to completely be removed.

 Thomas


