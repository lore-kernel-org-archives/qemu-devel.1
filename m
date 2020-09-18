Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC6C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C92C2100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhnpyl/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C92C2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBUU-0002SG-Im
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBS3-00080m-5p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJBS1-0003Ds-MU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:09:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id b79so4583304wmb.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HOMEtjgEG4R9EyGOOdrc6QJ+px3k1Lgx6CXyxto8G2M=;
 b=Vhnpyl/T/Nld1nv0IFX9TZY5qfbbPBd/biXwrXYXtelEErLy417YcVtVAV6MIaczls
 erY/YNd5ftVKYJRk+nkQ1xeXjehdsW3kf6n766v3plxtD9yYf4V+2nHrMubomHKEMxv/
 +TtL+w32n8YmrHUuMJsa4CmxKqRi/XqsuNwzc/H8nDe8HLCisjmGcY2WtDnZjbYU8meD
 ED6XwcV4Tw+op6GGB96vzTf/5iC0XaQeSEH0VJiR/BYKFPhxGUnEFrmUBve5Wsz29ORF
 5mtC/KvgSMqu/Cz6QCY6b++VYiLJ+RMYKy//3AxB/waVfkAo/vWz+YjXen6JS2h0AW8q
 I/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HOMEtjgEG4R9EyGOOdrc6QJ+px3k1Lgx6CXyxto8G2M=;
 b=VppHK3OFscDLZShNqRNAIrsVz56CvIHTT9mqa4HeVJS6SbWRCkCO6ZrkXtnMoKXuas
 u1y/NZGDGcL/RDwqZSsXmTgj97N1aCaaF7iro/qXsFDSe4N5B+0SJbo5pmzHMdaqptNd
 gZtpCb4SUgHAljmpBaZvTehBRNw4CkbNEPUDyp+x/LPBzpss00ftrHKdKZq1DRN8Wumy
 sD02SsWtEI+Wel39pNPqwbOrig+cdDAPZReossvo8zlPFUkC59fg//5E3dVM9Tf6GjiB
 l1HMW1iPgzzq+rzSf1Oz9QCqVHT7tPrS+9COCQeCLoDK/jPEFqAtJKQbkDTvrIllNVE/
 AwLQ==
X-Gm-Message-State: AOAM533siUqBqf5OXwkGq1KkStKdWVNtljLMTpDgD1rSLz2moHPDcYVD
 grn0jcT1RxZaF8VfLxj55/s=
X-Google-Smtp-Source: ABdhPJw2P9VgSwmE5xJe79AREZWhf+RVmnlz4azy5qLN09/6qn0FsJAFco85Ox+ROtrzJwzxNNXujg==
X-Received: by 2002:a1c:7502:: with SMTP id o2mr13753363wmc.29.1600416539683; 
 Fri, 18 Sep 2020 01:08:59 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h8sm3808170wrw.68.2020.09.18.01.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 01:08:58 -0700 (PDT)
Subject: Re: [PATCH v3 07/10] disas: Configure capstone for aarch64 host
 without libvixl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
 <20200917235720.2685978-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <051684ca-3bf8-5526-1bbc-4de1c80d0000@amsat.org>
Date: Fri, 18 Sep 2020 10:08:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917235720.2685978-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 1:57 AM, Richard Henderson wrote:
> The ifdef tangle failed to set cap_arch if libvixl itself
> was not configured (e.g. due to lack of c++ compiler).
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

