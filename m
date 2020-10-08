Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412BCC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74422184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoOgi/nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74422184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQWq-0002Ui-QL
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQWI-00024v-2s
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQWF-0007hJ-UT
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602142759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmpmHx7pWy4h9rUxLThtA6vMovvmgZi3mdDjNA8zKj0=;
 b=BoOgi/nrveI/Av4iD7tXybZOneADtaoAbBUCQtZKFD0R59n+T2S9Dhf9glkTYmWv5cBdIL
 OPBB0fKS+CPChKA6OCZPK1eF81sdoFkOth7WpGQcFVmjAXv+u+ovOQ4HTIathb5H8QaooF
 zqHkqR08bE0snGNtA5Nx4m/MomrtOU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-pP4MB40HPjOxAZvnkFLnWA-1; Thu, 08 Oct 2020 03:39:17 -0400
X-MC-Unique: pP4MB40HPjOxAZvnkFLnWA-1
Received: by mail-wm1-f69.google.com with SMTP id i9so2826507wml.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BmpmHx7pWy4h9rUxLThtA6vMovvmgZi3mdDjNA8zKj0=;
 b=gde/HNZFJ620LvyS92s8oBpuHhYdsR831bqiO2Be++noyBajoVeH3J9ErYF2894xgt
 YAliBlVpQP8T/a7eoTSsEYTNEKJJObmc7tyBvW1ujw707las13qEzZXkMTDRPB/qdHHp
 x4Njv48WUgs9zfaQksXWc9xpdyoSweE9gL70VNCr8Ojq7cvZ3J6niexP5CZKm1y/wJXk
 ApXaDQK4gysTaIdOhLqd/2Jxnwdpo2o64YiAedGfXSghaZHrl6Eksij2d9nWGOmCHzjW
 4lfATv8+7M5/2jWu9DEKya+wqWnfFRfpwqOiTzu/OLprUVfmhojq4Z1TsFSCZJ3ZsSlS
 Rjgg==
X-Gm-Message-State: AOAM531mYdp4etwoWUo8AAhNN4OeKz67iMDrWf2pvYhU2ElBmNE66g3x
 XbecuVes4d+Sqs3cg2sR0bVgR7IeSkbDWGLRZFCGdexx1ZXgVsNi84VCfZMYXRAH+v7cQKoec5/
 1mvzgxNx/hLUKAT0=
X-Received: by 2002:a1c:4887:: with SMTP id v129mr7645848wma.13.1602142756007; 
 Thu, 08 Oct 2020 00:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2JJECOxQrPpg1FrhxNGuzo+fKgA/mwadrfZkwBObb4EOG5tRKfELGHfkBgBqQjPVyhYqMNw==
X-Received: by 2002:a1c:4887:: with SMTP id v129mr7645829wma.13.1602142755747; 
 Thu, 08 Oct 2020 00:39:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id c1sm6040764wru.49.2020.10.08.00.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:39:15 -0700 (PDT)
Subject: Re: [PATCH v3 05/16] fuzz: Declare DMA Read callback function
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-6-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ed304a0-38ee-1013-7d85-7b0ae0e7c4d2@redhat.com>
Date: Thu, 8 Oct 2020 09:39:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-6-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, philmd@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 04:24, Alexander Bulekov wrote:
> This patch declares the fuzz_dma_read_cb function and uses the
> preprocessor and linker(weak symbols) to handle these cases:
> 
> When we build softmmu/all with --enable-fuzzing, there should be no
> strong symbol defined for fuzz_dma_read_cb, and we link against a weak
> stub function.
> 
> When we build softmmu/fuzz with --enable-fuzzing, we link against the
> strong symbol in general_fuzz.c
> 
> When we build softmmu/all without --enable-fuzzing, fuzz_dma_read_cb is
> an empty, inlined function. As long as we don't call any other functions
> when building the arguments, there should be no overhead.

Can you move the weak function somewhere in tests/qtest/fuzz instead?
Then you don't need an #ifdef because you can add it to specific_fuzz_ss.

Paolo


