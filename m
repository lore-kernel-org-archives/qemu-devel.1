Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F68A2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE/XEtK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F68A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh2C-0004vm-4Y
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSh0M-0002vH-LV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSh0K-00070x-Tv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602682783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1A1zcYepOWAMprx4fwEoH0JbQYlc0S/K68cOtM9VYA=;
 b=cE/XEtK5hmspB5+JfnJW7dKl/q330aOeOmUnB/fB+3/D6mRGc8GdMnSKL151RT9tSzXGhi
 sV+6bWMdnRFuMLpoCv1dp2RD1AJRPNNrItyMHzgpsS0s7GLKuoEumNMUakrmrls+IHf303
 EUr8PcpMcFzREeC4Zte8WJ9MP8PBaBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-oztzwiJkNj68zGgD3jaA3g-1; Wed, 14 Oct 2020 09:39:42 -0400
X-MC-Unique: oztzwiJkNj68zGgD3jaA3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF2FD86ABDA;
 Wed, 14 Oct 2020 13:39:40 +0000 (UTC)
Received: from thuth.remote.csb (reserved-198-128.str.redhat.com
 [10.33.198.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 252695C1C2;
 Wed, 14 Oct 2020 13:39:38 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Move MIPS GIC timer files to Boston
 board section
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <39fdf233-f4a2-5b13-c02f-e404a789d99c@redhat.com>
Date: Wed, 14 Oct 2020 15:39:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201013101659.3557154-5-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 12.16, Philippe Mathieu-Daudé wrote:
> The MIPS GIC timer is only used by the Boston board.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 702f73823fc..62db288bfc4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -233,11 +233,9 @@ F: docs/system/cpu-models-mips.rst.inc
>  F: hw/intc/mips_gic.c
>  F: hw/mips/
>  F: hw/misc/mips_*
> -F: hw/timer/mips_gictimer.c
>  F: include/hw/intc/mips_gic.h
>  F: include/hw/mips/
>  F: include/hw/misc/mips_*
> -F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  K: ^Subject:.*(?i)mips
>  
> @@ -1167,7 +1165,9 @@ S: Odd Fixes
>  F: hw/core/loader-fit.c
>  F: hw/mips/boston.c
>  F: hw/pci-host/xilinx-pcie.c
> +F: hw/timer/mips_gictimer.c
>  F: include/hw/pci-host/xilinx-pcie.h
> +F: include/hw/timer/mips_gictimer.h

If I grep for mips_gictimer_init, it seems like this function is used from
mips_gic_realize in hw/intc/mips_gic.c ... and mips_gic.c / TYPE_MIPS_GIC is
also used from the malta board ... so are you really sure this is right? Or
what did I miss?

 Thomas


