Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC4C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 13:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC95206A4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 13:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC95206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i98aY-0002x1-Jl
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 09:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i98Zc-0002Tc-Qv
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i98Zb-0007ly-TK
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 09:58:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i98Zb-0007lf-Oc
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 09:58:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so16793902pgb.10
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 06:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=b8w7tH9B6Pgk41EpycnXY5kJ6zOJOQmDNW6abSEPV2k=;
 b=moiarP3RGDP4MnLPc4feNjlvIJFgdCxAEJfLqVTQ0Ii+JGmyLWGYpWg1Nt63sBljWD
 cxIKa5TpBBm/JfSDT03825T6LVtIAb87FSC9w9SWe51p5BrjCYWLwg/HZbn83Y0o+MCl
 tRpZHHt/snpLtv2tqGLVva8LTgZ6EiRQSrcmhhYX8ubY8VTNEQ7MDxGJcBNMpg698R86
 A/8mpqqZAZi/1T6Cvhq8KWS4OdyerJfyYlymdHWxbwiXAQ+Rh8euuD7Zc/k6CGptA3Ni
 tpn2z9WGjKGAVKC1GUCDK/4WRXg4D+u21Foo0eqLkgx7qM3NvRIM1PKdtLYEH6XrbqIq
 Dx1Q==
X-Gm-Message-State: APjAAAXPbayHZtrVmioJZVi9TbAj80oeLRowlhRfzX+74PtJ7eTOYTnY
 /B4cN/WuLJqFyBXClitDFQUNGg==
X-Google-Smtp-Source: APXvYqyG6UUFOZIeybCewgFHHwr4T0u/OlbdOaJGig9370eRos8SxNn7YD53UwOD0blWyYLz6CTPFg==
X-Received: by 2002:a17:90a:c20c:: with SMTP id
 e12mr11320430pjt.14.1568469526257; 
 Sat, 14 Sep 2019 06:58:46 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id 127sm62651466pfw.6.2019.09.14.06.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 06:58:45 -0700 (PDT)
Date: Sat, 14 Sep 2019 06:58:45 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 06:57:39 PDT (-0700)
In-Reply-To: <ac250aa8-886f-befb-070f-2f5d10861e39@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-5091386d-7dcb-4425-b56c-662581775593@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.193
Subject: Re: [Qemu-devel] [PATCH v2 03/17] RISC-V: support vector extension
 csr
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com, qemu-devel@nongnu.org,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 15:43:29 PDT (-0700), richard.henderson@linaro.org wrote:
> On 9/11/19 2:25 AM, liuzhiwei wrote:
>> @@ -873,7 +925,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>      [CSR_FFLAGS] =              { fs,   read_fflags,      write_fflags      },
>>      [CSR_FRM] =                 { fs,   read_frm,         write_frm         },
>>      [CSR_FCSR] =                { fs,   read_fcsr,        write_fcsr        },
>> -
>> +    /* Vector CSRs */
>> +    [CSR_VSTART] =              { any,   read_vstart,     write_vstart      },
>> +    [CSR_VXSAT] =               { any,   read_vxsat,      write_vxsat       },
>> +    [CSR_VXRM] =                { any,   read_vxrm,       write_vxrm        },
>> +    [CSR_VL] =                  { any,   read_vl                            },
>> +    [CSR_VTYPE] =               { any,   read_vtype                         },
>
> Is there really no MSTATUS bit to disable the vector unit,
> as there is for the FPU?  That seems like a defect in the
> specification if true...

The privileged part of the V extension hasn't been written yet, which is part 
of the reason this is a draft that we know will change.  We're letting it into 
QEMU so people can more easily prototype software, but won't be letting it into 
Linux or GCC to avoid users depending on behavior that will change in the 
future.

