Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA12C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE632054F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="XzXNKG0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE632054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEBkx-0003Ej-ED
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 07:51:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBk0-0002VT-Uw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBjz-0005dg-Sz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:08 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:40838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEBjz-0005c9-EA
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:50:07 -0400
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id 24A0841927;
	Wed, 10 Apr 2019 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received:received; s=mta-01; t=
	1554897004; x=1556711405; bh=Xn2Vty2XEPRL/jASa/7j8l24mQ4TQswqaQ1
	Rr2j5JsU=; b=XzXNKG0lmnpa+NaS6pB2QuPId50ntrjHreNFVB9FlOjNZFLVE3W
	cwZ5KROb4cdh69LGwE00fZQ7BB2xH5MqfnEDtvmYODSNg8kGvx9OLlG9mZ0IJFsx
	UfuBq917qetljAWd5r+Atfy+fCjSlRMF7OvfdBkXeJSV3hTPYPR+FqPw=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9KYe2xlnpRP; Wed, 10 Apr 2019 14:50:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 857B1418F9;
	Wed, 10 Apr 2019 14:50:03 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
	(172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32;
	Wed, 10 Apr 2019 14:50:03 +0300
Date: Wed, 10 Apr 2019 14:50:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190407115839.25054-3-skrtbhtngr@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
	T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 89.207.88.251
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410115001.GLnbvKCmifDYJUOT3FCNn-SDIQqDlRH_tiMYE3uNKfw@z>

On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> Keep the calls made to synchronize cpu by all hypervisors in one place
> inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> ---
>  cpus.c                    | 12 ------------
>  include/sysemu/hw_accel.h | 10 ++++++++++
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index e83f72b48b..026df0dc5f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1021,10 +1021,6 @@ void cpu_synchronize_all_states(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_state(cpu);
> -        /* TODO: move to cpu_synchronize_state() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_state(cpu);
> -        }
>      }
>  }
>  
> @@ -1034,10 +1030,6 @@ void cpu_synchronize_all_post_reset(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_reset(cpu);
> -        /* TODO: move to cpu_synchronize_post_reset() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_reset(cpu);
> -        }
>      }
>  }
>  
> @@ -1047,10 +1039,6 @@ void cpu_synchronize_all_post_init(void)
>  
>      CPU_FOREACH(cpu) {
>          cpu_synchronize_post_init(cpu);
> -        /* TODO: move to cpu_synchronize_post_init() */
> -        if (hvf_enabled()) {
> -            hvf_cpu_synchronize_post_init(cpu);
> -        }
>      }
>  }
>  
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index d2ddfb5ad0..bf081b4026 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -15,6 +15,7 @@
>  #include "sysemu/hax.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/whpx.h"
> +#include "sysemu/hvf.h"
>  
>  static inline void cpu_synchronize_state(CPUState *cpu)
>  {
> @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_state(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_state(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_post_reset(CPUState *cpu)
> @@ -40,6 +44,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_reset(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_reset(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_post_init(CPUState *cpu)
> @@ -53,6 +60,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
>      if (whpx_enabled()) {
>          whpx_cpu_synchronize_post_init(cpu);
>      }
> +    if (hvf_enabled()) {
> +        hvf_cpu_synchronize_post_init(cpu);
> +    }
>  }
>  
>  static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> -- 
> 2.20.1
> 
> 

Hi Sukrit,

The commit itself looks sane but qemu starts to hang during BIOS boot
after I've applied it if I run it with hvf accel.

Thanks,
Roman

