Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED836C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5412320848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwPyZ1Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5412320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfPV-00052v-5b
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSfA5-0001Li-5H
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSfA2-0007ha-FW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602675695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dj1dvIMhtzuIH8rI+DC8ga2BdwuQid2++XXBYSk1g0I=;
 b=YwPyZ1DvsEovKZ5Kw6Bk93Baz/ME9rBMb64sEh79MaRItgyhdlw+fgTB/RefD8iFlW4ixu
 3kaIDEmzNBK1R0DUvDpeDvvFHgS+VlIRW+mRMPInrckiHaM55lkkxzVtARhGuxkPDhV8H8
 J7KeI+o8WTqsQtbDcQnSXLncMXhSy2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-9aV7uyfSNQuUsgJI8rx91g-1; Wed, 14 Oct 2020 07:41:34 -0400
X-MC-Unique: 9aV7uyfSNQuUsgJI8rx91g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87460876ED0;
 Wed, 14 Oct 2020 11:41:32 +0000 (UTC)
Received: from thuth.remote.csb (reserved-198-128.str.redhat.com
 [10.33.198.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F7E26EF67;
 Wed, 14 Oct 2020 11:41:30 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Put myself forward for MIPS target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20201013101659.3557154-1-f4bug@amsat.org>
 <20201013101659.3557154-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f953ddb0-004e-2372-e2a9-6fbc3e773ff4@redhat.com>
Date: Wed, 14 Oct 2020 13:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201013101659.3557154-2-f4bug@amsat.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/2020 12.16, Philippe Mathieu-Daudé wrote:
> To avoid the MIPS target being orphan, volunteer to keep an eye
> on it and put together pull requests.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 426f52c1f63..d59e5c05c10 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -221,10 +221,11 @@ F: hw/microblaze/
>  F: disas/microblaze.c
>  
>  MIPS TCG CPUs
> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Orphaned
> +S: Odd Fixes
>  F: target/mips/
>  F: default-configs/*mips*
>  F: disas/*mips*
> @@ -2815,11 +2816,12 @@ F: tcg/i386/
>  F: disas/i386.c
>  
>  MIPS TCG target
> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  R: Huacai Chen <chenhc@lemote.com>
>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> -S: Orphaned
> +S: Odd Fixes
>  F: tcg/mips/

It would be good to get some feedback from the people with the "R:" entries
here, too ... but FWIW:

Reviewed-by: Thomas Huth <thuth@redhat.com>


