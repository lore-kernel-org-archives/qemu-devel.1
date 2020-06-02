Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F66420734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1c7lea6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F66420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfy1S-0003Oo-KE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfy0l-0002PX-UM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:54:47 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:36760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfy0k-00066F-U2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:54:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id x22so132938pfn.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MLgaGNAcY4DzBGxSSksqhm3igUs2JVkoA7ZxL2vr8Rk=;
 b=V1c7lea6N0P6MTFf9d8CH8XQ/JTwhC+L0g3XyPE3mRxZwbu1PrhHp4iv54JKjsPElT
 97HkwITVKAOyl3Pz3SAkTNMiumewItfMTen9Iazl2zjWdagPLo/sZ3yM1xg/y/ApjH6W
 D8KMO5+hz6jKt/zSfM9G0axdckzYzSyQx12zfEfrvaTsi93thcNL5rAqtHw9ytJuRA1s
 qy1guGHeym0pmJhO3Wv11LabC/5d+Tdm6+s19UbSpJM2giEmBSJqIAXIPpD+I0gaaOgw
 yMmEl5zEf4BbAetgPvfaCspu3Q3QVk33wT6YQ4VRKF1GgEVu7ePr/+9nvWK+yC3Zu+Z/
 AimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MLgaGNAcY4DzBGxSSksqhm3igUs2JVkoA7ZxL2vr8Rk=;
 b=flXT3Y6MlAXgudTM1OahN69SMokFJPBILud7LGux/86ucCeEvuhPVDef/jf+a9B9kz
 DksvLYiNW3UatIv+M9D5QE4ClZKM/yj96L1HHBu/EKNBvkuD8rpOeIJdRoV7X2pmZ/mI
 3ZhLCP6JnmKvqYOabF9QsrdBFFq41m72TKYCs8y7CEofBlKhLonQenMXq/r7Hx61lEds
 8sHa43/QqCzPFaJV1AwgxlGwT1ZQKQjq6fRr+BvrOEATumWdv6vBepQzWwQMTMorF8GE
 iTSRRLpXjjRZPcNTeNEbbQup060mL8X5LqDUITedJWeMvtFc0qx9mWRnJWefhLtYGC7G
 5TGg==
X-Gm-Message-State: AOAM531WCfci8teJqgx+TjCAsP23WVLHnfWN1YJ5sFMj3yCXHeP9bD81
 rHp/+cxpLlV8IigGTGtnznh5Fw==
X-Google-Smtp-Source: ABdhPJyRTjC/w8+5+5sIm/dWueJIR1CmiWmheInGxu1keyfUES3FupWu5rJxoPsZObpkcz0+wsEBWA==
X-Received: by 2002:a63:64b:: with SMTP id 72mr22811956pgg.437.1591070085340; 
 Mon, 01 Jun 2020 20:54:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b140sm770096pfb.119.2020.06.01.20.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:54:44 -0700 (PDT)
Subject: Re: [RFC v2 14/18] guest memory protection: Rework the
 "memory-encryption" property
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-15-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4061fcf0-ba76-5124-74eb-401a0b91d900@linaro.org>
Date: Mon, 1 Jun 2020 20:54:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-15-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:43 PM, David Gibson wrote:
> +++ b/include/hw/boards.h
> @@ -12,6 +12,8 @@
>  #include "qom/object.h"
>  #include "hw/core/cpu.h"
>  
> +typedef struct GuestMemoryProtection GuestMemoryProtection;
> +

I think this needs to be in include/qemu/typedefs.h,
and the other typedef in patch 10 needs to be moved there.

IIRC, clang warns about duplicate typedefs.


r~

