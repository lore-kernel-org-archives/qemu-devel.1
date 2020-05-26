Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C612C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69AE2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 19:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rrErR/xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69AE2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdf6r-0008Su-4M
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 15:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jdf6B-0007r0-RP; Tue, 26 May 2020 15:18:51 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:38890 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jdf6A-00027M-EW; Tue, 26 May 2020 15:18:51 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id E756E4C80C;
 Tue, 26 May 2020 19:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1590520723; x=1592335124; bh=+X2W6B1dVBAEYBvgcvQaaN
 Z1XrNWpFif7Kyy/Cl63b8=; b=rrErR/xklLBiRq7qLEtnLnmoZqskUQpfDEqaic
 HZKLVYDUfBpQxcV15JXm2v2VxT8hQUAexBfZdYoT/DM+haWUa7EnaXeoUykjOS5q
 A8gXaZtRLEfOWj5oBprJaRsLvcE+sYpasdHAJ4XM+qGM+e/1eBecp0QLCsWThy4D
 ag128=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fsz_tCLt5sfE; Tue, 26 May 2020 22:18:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 3B28747117;
 Tue, 26 May 2020 22:18:43 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 26
 May 2020 22:18:44 +0300
Date: Tue, 26 May 2020 22:18:44 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 3/7] sysemu/hvf: Only declare hvf_allowed when HVF is
 available
Message-ID: <20200526191844.GB4851@SPB-NB-133.local>
References: <20200526172427.17460-1-f4bug@amsat.org>
 <20200526172427.17460-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526172427.17460-4-f4bug@amsat.org>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 15:16:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: "Edgar E .
 Iglesias" <edgar.iglesias@xilinx.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 07:24:23PM +0200, Philippe Mathieu-Daudé wrote:
> When HVF is not available, the hvf_allowed variable does not exist.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: Fixed typo s/tcg_allowed/hvf_allowed/ (Edgar)
> ---
>  include/sysemu/hvf.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index d211e808e9..fe95743124 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -18,7 +18,6 @@
>  #include "exec/memory.h"
>  #include "sysemu/accel.h"
>  
> -extern bool hvf_allowed;
>  #ifdef CONFIG_HVF
>  #include <Hypervisor/hv.h>
>  #include <Hypervisor/hv_vmx.h>
> @@ -26,11 +25,12 @@ extern bool hvf_allowed;
>  #include "target/i386/cpu.h"
>  uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>                                   int reg);
> +extern bool hvf_allowed;
>  #define hvf_enabled() (hvf_allowed)
> -#else
> +#else /* !CONFIG_HVF */
>  #define hvf_enabled() 0
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
> -#endif
> +#endif /* !CONFIG_HVF */
>  
>  /* hvf_slot flags */
>  #define HVF_SLOT_LOG (1 << 0)
> -- 
> 2.21.3
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

