Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16039C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AFB2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVuu+Y3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AFB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSb18-0003zi-TV
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1kSazO-0003Vd-Hr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:14:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1kSazM-0006uz-Ot
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:14:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id x7so2473851wrl.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=oUr1d9pmPZpb4XFFZd5zMUqO9AeHyoOsgF96bviWetQ=;
 b=BVuu+Y3i1z9kMbn0V7jRJGUgtfvpjv+HktliIdZ4pSqTsnBzO4CsSfv1GC5CLypg1s
 kFoEGkwq1ICpPWB/JClZb+Yo2IdbCdJAluVlw7h1JsY4EueBtFnhvCGbBhwMFkGMSxKC
 HD3LTEQMe03/zywxGtQF8kYnzpRaBXPblwuhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=oUr1d9pmPZpb4XFFZd5zMUqO9AeHyoOsgF96bviWetQ=;
 b=YXPxY6yXH1mCjrPlHDskSRVS4nUYkDsa8HLplVyfGIMYpV+Auq3mzR8nSXQjNkumnD
 TLOYbg3NTICQd+cgTiiGVm0heMEPLoI4phyuyLK8/Hu0V4/kvtkjq5v9MfKTcIsVfz4v
 BHYGvNR0NcFd9eNyyAG55DCY83PoO+NGKzCNziYcoEpuez2CXRLQoOBV8d+DH4mC6SqW
 Tdon4/E0sHTlPufogfmgjKTxCjrfhZKRD/5otMwvzL/HW3g4PGkETHMehnNDrDyLIZvk
 bvf6Wa0m5RXGMP4eAJxgPKe49hvVlEgERxRo8gMyu1zo/LJ+ImTRaErxIwzGDk+FU8GR
 OU+Q==
X-Gm-Message-State: AOAM5317ktCSqazi5HsOp+E3H3zVEPiXqIQFncmDD3nU1qMeHGQO+3MG
 Sy4lo+p1Em5+mUr78Awxp2LyBA==
X-Google-Smtp-Source: ABdhPJzkntYr9ImoT9DdXhrHES242IWJgNIZTU4aUdCnZfBQsUKs92obrHhWiPpvm58nQprahf9AIw==
X-Received: by 2002:a05:6000:81:: with SMTP id m1mr3831026wrx.67.1602659657958; 
 Wed, 14 Oct 2020 00:14:17 -0700 (PDT)
Received: from
 f.7.c.a.0.7.9.b.6.d.5.e.8.7.d.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa
 (f.7.c.a.0.7.9.b.6.d.5.e.8.7.d.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:aba:5f3c:7d78:e5d6:b970:ac7f])
 by smtp.gmail.com with ESMTPSA id p9sm2215032wmm.4.2020.10.14.00.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 00:14:17 -0700 (PDT)
Message-ID: <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Victor Kamensky (kamensky)" <kamensky@cisco.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <f4bug@amsat.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Wed, 14 Oct 2020 08:14:14 +0100
In-Reply-To: <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-10-14 at 01:36 +0000, Victor Kamensky (kamensky) wrote:
> Thank you very much for looking at this. I gave a spin to
> your 3 patch series in original setup, and as expected with
> '-cpu 34Kf,tlb-entries=64' option it works great.
> 
> If nobody objects, and your patches could be merged, we
> would greatly appreciate it.

Speaking as one of the Yocto Project maintainers, this is really
helpful for us, thanks!

qemumips is one of our slowest platforms for automated testing so this
performance improvement helps a lot.

Cheers,

Richard


