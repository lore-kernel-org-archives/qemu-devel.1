Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB533C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BA820732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="K5I+qVLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BA820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95XD-0004pl-U8
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k959M-0006eL-VY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:24:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:59424 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k959L-0000Lz-5w
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:24:00 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 3AE8E56774;
 Fri, 21 Aug 2020 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1598009036; x=1599823437; bh=8IS/00VtCUA9BCDC4FUtY0
 BvBTW6Mt7QKwHWtZ50nxI=; b=K5I+qVLaIG0D0X+uqJR19EGjWg2iRMhaEgCOnA
 7mLJUqfaK1RHhCmG0XE46NIUBj0hdGl66y2UWR9oV8rvR8K6MECa+CYm6/NcuQAd
 KMmNQlacknEEhaS3oxTJPjzMiORG2rABME0wQWdm38CvWvqndOJF/dzTYu0FTytp
 sXsu8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nn3RSQpny8Sb; Fri, 21 Aug 2020 14:23:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B1F5F56264;
 Fri, 21 Aug 2020 14:23:55 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 21
 Aug 2020 14:23:55 +0300
Date: Fri, 21 Aug 2020 14:23:55 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 19/58] hvf: Move HVFState typedef to hvf.h
Message-ID: <20200821112355.GC89922@SPB-NB-133.local>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-20-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820001236.1284548-20-ehabkost@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 06:53:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 08:11:57PM -0400, Eduardo Habkost wrote:
> Move typedef closer to the type check macros, to make it easier
> to convert the code to OBJECT_DEFINE_TYPE() in the future.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2: none
> 
> ---
> Cc: Cameron Esfahani <dirty@apple.com>
> Cc: Roman Bolshakov <r.bolshakov@yadro.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/sysemu/hvf.h       | 1 +
>  target/i386/hvf/hvf-i386.h | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index d3bed80ea8..760d6c79a2 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -35,6 +35,7 @@ void hvf_vcpu_destroy(CPUState *);
>  
>  #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>  
> +typedef struct HVFState HVFState;

Forward declaration of HVFState is missed before the typedef.

>  #define HVF_STATE(obj) \
>      OBJECT_CHECK(HVFState, (obj), TYPE_HVF_ACCEL)
>  
> diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
> index ef20c73eca..e0edffd077 100644
> --- a/target/i386/hvf/hvf-i386.h
> +++ b/target/i386/hvf/hvf-i386.h
> @@ -57,13 +57,13 @@ typedef struct hvf_vcpu_caps {
>      uint64_t vmx_cap_preemption_timer;
>  } hvf_vcpu_caps;
>  
> -typedef struct HVFState {
> +struct HVFState {
>      AccelState parent;
>      hvf_slot slots[32];
>      int num_slots;
>  
>      hvf_vcpu_caps *hvf_caps;
> -} HVFState;
> +};
>  extern HVFState *hvf_state;
>  
>  void hvf_set_phys_mem(MemoryRegionSection *, bool);
> -- 
> 2.26.2
> 

