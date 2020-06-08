Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66770C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD692076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/tR2V7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD692076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEzd-0000NM-1a
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiEyI-0007uS-Ns
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:25:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jiEyH-0000ay-HT
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591611936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=W1NMRGSTbmJa1sjQbZKaDZQUvRmqlb2ZnrfZ1bpnhWQ=;
 b=C/tR2V7PfNvgTG42QG23uBXzT2i5K1rwllH9FW2Mkz6IHIZMjoZYEf8OFTDxDT/c+P6bzM
 tw5ISzevNcrgq3tgSmcW2HOKOX9UdSwxpKH/u8KIDBM6PCnL1t2PT51XbeffELK8Qhqfn4
 EYXy+rMuymwZcXcgf4u+r5u52ugSZEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-W3CfULIXO1-vfHRYfxpqwg-1; Mon, 08 Jun 2020 06:25:03 -0400
X-MC-Unique: W3CfULIXO1-vfHRYfxpqwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995C88014D4;
 Mon,  8 Jun 2020 10:25:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-119.ams2.redhat.com [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D34B10013D4;
 Mon,  8 Jun 2020 10:24:57 +0000 (UTC)
Subject: Re: [PATCH v2 4/8] hw/sh4: Use MemoryRegion typedef
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <50833931-0a48-159c-97a6-efde8384fb5b@redhat.com>
Date: Mon, 8 Jun 2020 12:24:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200608090142.6793-5-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/2020 11.01, Philippe Mathieu-Daudé wrote:
> Use the MemoryRegion type defined in "qemu/typedefs.h",
> to keep the repository style consistent.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20200504081653.14841-2-f4bug@amsat.org>
> ---
>  include/hw/sh4/sh.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
> index 767a2df7e2..fe773cb01d 100644
> --- a/include/hw/sh4/sh.h
> +++ b/include/hw/sh4/sh.h
> @@ -10,9 +10,8 @@
>  
>  /* sh7750.c */
>  struct SH7750State;
> -struct MemoryRegion;
>  
> -struct SH7750State *sh7750_init(SuperHCPU *cpu, struct MemoryRegion *sysmem);
> +struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
>  
>  typedef struct {
>      /* The callback will be triggered if any of the designated lines change */
> @@ -32,7 +31,7 @@ int sh7750_register_io_device(struct SH7750State *s,
>  #define TMU012_FEAT_TOCR   (1 << 0)
>  #define TMU012_FEAT_3CHAN  (1 << 1)
>  #define TMU012_FEAT_EXTCLK (1 << 2)
> -void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
> +void tmu012_init(MemoryRegion *sysmem, hwaddr base,
>                   int feat, uint32_t freq,
>  		 qemu_irq ch0_irq, qemu_irq ch1_irq,
>  		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


