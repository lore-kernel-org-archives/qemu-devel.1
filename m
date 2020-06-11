Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16735C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39B520656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBNFCkdz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39B520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJth-0001yw-5Z
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjJsq-0001MB-Ff
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:52:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjJsp-0002CA-Jq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591869146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5wh5ahgMWNnA+d+mRu796breUvM92L0ZaS1paii7vBM=;
 b=eBNFCkdzC3FyfSwPhFbI4389BIDZrp3lC3oqCEFvKoBuMNvzTYFSNQvf9UbIjASWStr6GI
 Tu+qYb0jOdjJBh5qUYXToiHvBXBp3F1RNtOuTCwamBVHvt1BQ1kog/PGL6JVL62GkiJkoR
 7KSHuIRH+3h0C1Q1Q59ExuAxsIP/Zmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-NzE3z-sjNC6FBj2jNskAVA-1; Thu, 11 Jun 2020 05:52:24 -0400
X-MC-Unique: NzE3z-sjNC6FBj2jNskAVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418AA100CCC0;
 Thu, 11 Jun 2020 09:52:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D2A87C3CB;
 Thu, 11 Jun 2020 09:52:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Adjust sh4 maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200611094029.9528-1-aleksandar.qemu.devel@gmail.com>
 <20200611094029.9528-2-aleksandar.qemu.devel@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <53584e62-70c4-122c-2434-3d55cb16f9a4@redhat.com>
Date: Thu, 11 Jun 2020 11:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200611094029.9528-2-aleksandar.qemu.devel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/2020 11.40, Aleksandar Markovic wrote:
> This patch transfers sh4 sections to Yoshinori Sato, who is
> best positioned in the community to assume sh4 maintainership.
> He is the maintainer of the related target rx as well, which
> means that some synergy between the two targets can be expected
> in future.
> 
> Further adjustments, reorganizations, and improvements of sh4
> sections are left to the future maintainer to be devised and
> executed, as he deems suitable.
> 
> Aurelien and Magnus are deleted as maintainers in some sections
> of the MAINTAINERS file with this patch. However, they will not
> be deleted from QEMU Hall of Fame, where their names will always
> remained carved in stone as QEMU pioneers and granddaddies.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Acked-by: Magnus Damm <magnus.damm@gmail.com>
> Acked-by: Yoshinori Sato <ysato@users.sourceforge.jp>
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

Wrong version of the patch? I think you agreed to change Magnus' line to
"R:" instead?

 Thomas


