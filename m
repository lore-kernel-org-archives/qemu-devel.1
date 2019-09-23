Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD9DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BAB20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 08:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BAB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCJNL-0001F2-Sj
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 04:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iCJMa-0000j1-U3
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iCJMZ-0003bU-7n
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:06:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iCJMY-0003a1-Vq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:06:27 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4069C053B34
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:06:24 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v13so4509871wrq.23
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TYLW/DnlkXsXUQ6xIaC1xsIFXzrLmfMObQE4o+gp+90=;
 b=ZUqwoKb8bFqVCgEi4D7IlSPUIlLWJPCrNy40mrhC2mSbHYqyrD0QGeTOrH9nf//0HT
 N8eyapmBTI9CjSWv4TwpQ/arsfG+rHJ/4Sqlz5xzfosN4sDsysyjWKFBkAOtFayKXe57
 ZEJ/wlHUtLGMgHGfhjEUlVxF1f0nUAZuzajT8ocNSzEDx2AH5An1TJoDiV0EiuGijfWe
 jWchY2FkCwmgrnr5Oxr4g+aeyjAa8UC2xiwkb9IpdbAK0rUPD7KpW38EbbjmFSFcE8M9
 m233Tf7YMqjpzTb8TkOvM7/BgbzSmj7iufXcFUQzi5PzEuODUB08d7OHZsQZzDovc4qr
 8fXQ==
X-Gm-Message-State: APjAAAXbYLKS/f2oi7Lfdd7LcQnI/WdPVkwyntLzIRsNG6KublhOzKj/
 vZja7ZEhB1p1NRpxLgDwXFwZgmw6elNLs1rzmdtPVZgFyhwXeVpw/E1Gb5QAsNLUsy8vePfr6lH
 3Qhkh1shkwMsWwsU=
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr13438072wme.51.1569225983544; 
 Mon, 23 Sep 2019 01:06:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYwP83zy87sW2+IQnAx0mAJ7q7lhbCkgveAY2O1ItMYXi9b59wfhFUU5PD7qkfW9kdpM1MIA==
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr13438045wme.51.1569225983254; 
 Mon, 23 Sep 2019 01:06:23 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id z4sm8903167wrh.93.2019.09.23.01.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 01:06:22 -0700 (PDT)
Date: Mon, 23 Sep 2019 10:06:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 1/2] target/i386: clean up comments over 80 chars per
 line
Message-ID: <20190923080620.uhyvwzzqwzavstqi@steredhat>
References: <20190923063041.12420-1-tao3.xu@intel.com>
 <20190923063041.12420-2-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923063041.12420-2-tao3.xu@intel.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 02:30:40PM +0800, Tao Xu wrote:
> Add some comments, clean up comments over 80 chars per line. And there
> is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD, remove
> the extra enter and spaces.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.h | 164 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 107 insertions(+), 57 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5f6e3a029a..fa4c4cad79 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -641,63 +641,113 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_SVM_PAUSEFILTER  (1U << 10)
>  #define CPUID_SVM_PFTHRESHOLD  (1U << 12)
>  
> -#define CPUID_7_0_EBX_FSGSBASE (1U << 0)
> -#define CPUID_7_0_EBX_BMI1     (1U << 3)
> -#define CPUID_7_0_EBX_HLE      (1U << 4)
> -#define CPUID_7_0_EBX_AVX2     (1U << 5)
> -#define CPUID_7_0_EBX_SMEP     (1U << 7)
> -#define CPUID_7_0_EBX_BMI2     (1U << 8)
> -#define CPUID_7_0_EBX_ERMS     (1U << 9)
> -#define CPUID_7_0_EBX_INVPCID  (1U << 10)
> -#define CPUID_7_0_EBX_RTM      (1U << 11)
> -#define CPUID_7_0_EBX_MPX      (1U << 14)
> -#define CPUID_7_0_EBX_AVX512F  (1U << 16) /* AVX-512 Foundation */
> -#define CPUID_7_0_EBX_AVX512DQ (1U << 17) /* AVX-512 Doubleword & Quadword Instrs */
> -#define CPUID_7_0_EBX_RDSEED   (1U << 18)
> -#define CPUID_7_0_EBX_ADX      (1U << 19)
> -#define CPUID_7_0_EBX_SMAP     (1U << 20)
> -#define CPUID_7_0_EBX_AVX512IFMA (1U << 21) /* AVX-512 Integer Fused Multiply Add */
> -#define CPUID_7_0_EBX_PCOMMIT  (1U << 22) /* Persistent Commit */
> -#define CPUID_7_0_EBX_CLFLUSHOPT (1U << 23) /* Flush a Cache Line Optimized */
> -#define CPUID_7_0_EBX_CLWB     (1U << 24) /* Cache Line Write Back */
> -#define CPUID_7_0_EBX_INTEL_PT (1U << 25) /* Intel Processor Trace */
> -#define CPUID_7_0_EBX_AVX512PF (1U << 26) /* AVX-512 Prefetch */
> -#define CPUID_7_0_EBX_AVX512ER (1U << 27) /* AVX-512 Exponential and Reciprocal */
> -#define CPUID_7_0_EBX_AVX512CD (1U << 28) /* AVX-512 Conflict Detection */
> -#define CPUID_7_0_EBX_SHA_NI   (1U << 29) /* SHA1/SHA256 Instruction Extensions */
> -#define CPUID_7_0_EBX_AVX512BW (1U << 30) /* AVX-512 Byte and Word Instructions */
> -#define CPUID_7_0_EBX_AVX512VL (1U << 31) /* AVX-512 Vector Length Extensions */
> -
> -#define CPUID_7_0_ECX_AVX512BMI (1U << 1)
> -#define CPUID_7_0_ECX_VBMI     (1U << 1)  /* AVX-512 Vector Byte Manipulation Instrs */
> -#define CPUID_7_0_ECX_UMIP     (1U << 2)
> -#define CPUID_7_0_ECX_PKU      (1U << 3)
> -#define CPUID_7_0_ECX_OSPKE    (1U << 4)
> -#define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
> -#define CPUID_7_0_ECX_GFNI     (1U << 8)
> -#define CPUID_7_0_ECX_VAES     (1U << 9)
> -#define CPUID_7_0_ECX_VPCLMULQDQ (1U << 10)
> -#define CPUID_7_0_ECX_AVX512VNNI (1U << 11)
> -#define CPUID_7_0_ECX_AVX512BITALG (1U << 12)
> -#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
> -#define CPUID_7_0_ECX_LA57     (1U << 16)
> -#define CPUID_7_0_ECX_RDPID    (1U << 22)
> -#define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
> -#define CPUID_7_0_ECX_MOVDIRI  (1U << 27)  /* MOVDIRI Instruction */
> -#define CPUID_7_0_ECX_MOVDIR64B (1U << 28) /* MOVDIR64B Instruction */
> -
> -#define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
> -#define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
> -#define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
> -#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
> -#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
> -#define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
> -
> -#define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
> -
> -#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
> -                                                                             do not invalidate cache */
> -#define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
> +/* Support RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE */
> +#define CPUID_7_0_EBX_FSGSBASE          (1U << 0)
> +/* 1st Group of Advanced Bit Manipulation Extensions */
> +#define CPUID_7_0_EBX_BMI1              (1U << 3)
> +/* Hardware Lock Elision */
> +#define CPUID_7_0_EBX_HLE               (1U << 4)
> +/* Intel Advanced Vector Extensions 2 */
> +#define CPUID_7_0_EBX_AVX2              (1U << 5)
> +/* Supervisor-mode Execution Prevention */
> +#define CPUID_7_0_EBX_SMEP              (1U << 7)
> +/* 2nd Group of Advanced Bit Manipulation Extensions */
> +#define CPUID_7_0_EBX_BMI2              (1U << 8)
> +/* Enhanced REP MOVSB/STOSB */
> +#define CPUID_7_0_EBX_ERMS              (1U << 9)
> +/* Invalidate Process-Context Identifier */
> +#define CPUID_7_0_EBX_INVPCID           (1U << 10)
> +/* Restricted Transactional Memory */
> +#define CPUID_7_0_EBX_RTM               (1U << 11)
> +/* Memory Protection Extension */
> +#define CPUID_7_0_EBX_MPX               (1U << 14)
> +/* AVX-512 Foundation */
> +#define CPUID_7_0_EBX_AVX512F           (1U << 16)
> +/* AVX-512 Doubleword & Quadword Instruction */
> +#define CPUID_7_0_EBX_AVX512DQ          (1U << 17)
> +/* Read Random SEED */
> +#define CPUID_7_0_EBX_RDSEED            (1U << 18)
> +/* ADCX and ADOX instructions */
> +#define CPUID_7_0_EBX_ADX               (1U << 19)
> +/* Supervisor Mode Access Prevention */
> +#define CPUID_7_0_EBX_SMAP              (1U << 20)
> +/* AVX-512 Integer Fused Multiply Add */
> +#define CPUID_7_0_EBX_AVX512IFMA        (1U << 21)
> +/* Persistent Commit */
> +#define CPUID_7_0_EBX_PCOMMIT           (1U << 22)
> +/* Flush a Cache Line Optimized */
> +#define CPUID_7_0_EBX_CLFLUSHOPT        (1U << 23)
> +/* Cache Line Write Back */
> +#define CPUID_7_0_EBX_CLWB              (1U << 24)
> +/* Intel Processor Trace */
> +#define CPUID_7_0_EBX_INTEL_PT          (1U << 25)
> +/* AVX-512 Prefetch */
> +#define CPUID_7_0_EBX_AVX512PF          (1U << 26)
> +/* AVX-512 Exponential and Reciprocal */
> +#define CPUID_7_0_EBX_AVX512ER          (1U << 27)
> +/* AVX-512 Conflict Detection */
> +#define CPUID_7_0_EBX_AVX512CD          (1U << 28)
> +/* SHA1/SHA256 Instruction Extensions */
> +#define CPUID_7_0_EBX_SHA_NI            (1U << 29)
> +/* AVX-512 Byte and Word Instructions */
> +#define CPUID_7_0_EBX_AVX512BW          (1U << 30)
> +/* AVX-512 Vector Length Extensions */
> +#define CPUID_7_0_EBX_AVX512VL          (1U << 31)
> +
> +/* AVX-512 Vector Byte Manipulation Instruction */
> +#define CPUID_7_0_ECX_AVX512BMI         (1U << 1)
> +#define CPUID_7_0_ECX_VBMI              (1U << 1)
> +/* User-Mode Instruction Prevention */
> +#define CPUID_7_0_ECX_UMIP              (1U << 2)
> +/* Protection Keys for User-mode Pages */
> +#define CPUID_7_0_ECX_PKU               (1U << 3)
> +/* OS Enable Protection Keys */
> +#define CPUID_7_0_ECX_OSPKE             (1U << 4)
> +/* Additional AVX-512 Vector Byte Manipulation Instruction */
> +#define CPUID_7_0_ECX_VBMI2             (1U << 6)
> +/* Galois Field New Instructions */
> +#define CPUID_7_0_ECX_GFNI              (1U << 8)
> +/* Vector AES Instructions */
> +#define CPUID_7_0_ECX_VAES              (1U << 9)
> +/* Carry-Less Multiplication Quadword */
> +#define CPUID_7_0_ECX_VPCLMULQDQ        (1U << 10)
> +/* Vector Neural Network Instructions */
> +#define CPUID_7_0_ECX_AVX512VNNI        (1U << 11)
> +/* Support for VPOPCNT[B,W] and VPSHUFBITQMB */
> +#define CPUID_7_0_ECX_AVX512BITALG      (1U << 12)
> +/* POPCNT for vectors of DW/QW */
> +#define CPUID_7_0_ECX_AVX512_VPOPCNTDQ  (1U << 14)
> +/* 5-level Page Tables */
> +#define CPUID_7_0_ECX_LA57              (1U << 16)
> +/* Read Processor ID */
> +#define CPUID_7_0_ECX_RDPID             (1U << 22)
> +/* Cache Line Demote Instruction */
> +#define CPUID_7_0_ECX_CLDEMOTE          (1U << 25)
> +/* Move Doubleword as Direct Store Instruction */
> +#define CPUID_7_0_ECX_MOVDIRI           (1U << 27)
> +/* Move 64 Bytes as Direct Store Instruction */
> +#define CPUID_7_0_ECX_MOVDIR64B         (1U << 28)
> +
> +/* AVX512 Neural Network Instructions */
> +#define CPUID_7_0_EDX_AVX512_4VNNIW     (1U << 2)
> +/* AVX512 Multiply Accumulation Single Precision */
> +#define CPUID_7_0_EDX_AVX512_4FMAPS     (1U << 3)
> +/* Speculation Control */
> +#define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
> +/* Arch Capabilities */
> +#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)
> +/* Core Capability */
> +#define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)
> +/* Speculative Store Bypass Disable */
> +#define CPUID_7_0_EDX_SPEC_CTRL_SSBD    (1U << 31)
> +
> +/* AVX512 BFloat16 Instruction */
> +#define CPUID_7_1_EAX_AVX512_BF16       (1U << 5)
> +
> +/* Write back and do not invalidate cache */
> +#define CPUID_8000_0008_EBX_WBNOINVD    (1U << 9)
> +/* Indirect Branch Prediction Barrier */
> +#define CPUID_8000_0008_EBX_IBPB        (1U << 12)
>  
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
>  #define CPUID_XSAVE_XSAVEC     (1U << 1)
> -- 
> 2.20.1
> 

-- 

