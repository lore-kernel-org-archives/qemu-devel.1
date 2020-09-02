Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8470C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BEF20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRzLbJxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BEF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDT92-00008q-TW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDT8T-00086E-OT; Wed, 02 Sep 2020 09:49:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDT8S-000511-5d; Wed, 02 Sep 2020 09:49:13 -0400
Received: by mail-wr1-x431.google.com with SMTP id e16so5328069wrm.2;
 Wed, 02 Sep 2020 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1LdkGkR52EGBm4iAd5x+Ux+35QJsNYEqBl1R1F6g2os=;
 b=dRzLbJxzs4QSESaxKGbPmSyjL0U6r01gReFOipzVy35aO9HxvFpoRJ3REMmr5IJsOx
 7JyqogRC/UX+UUSMK9O8L36AeZAx7bm6MJj+4rkCz7UlEgYKauTu8ZkLndCLuYLTnKA9
 tS8tLKDCFieuQW6gtj+SNatktnmLFG3YYyQVVzDTU0zlI7vhJXHXKI668IWdqQJeOo4D
 4cCho3h1NqUMf/p47LYDY7kjJmkfyCS0AZ3ZQgP6E+kXFTFynWLnQ/3Xkw+XQl4q1YE8
 vV3okMmwOnTLhGig4hqMH8M8T3Z8EZNhRp14ssNdBho+gO3P5bXDMHbRjH/8OX8x3CfE
 JDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LdkGkR52EGBm4iAd5x+Ux+35QJsNYEqBl1R1F6g2os=;
 b=lRMASISlgqeWji0pkLTAD2ZAZPglFAiox8qgi3jiWW87nQaZ5n6gpfQkWc1ouZtbQR
 Qe1mREEU8zKYeSRT7OxNyGllYWf+LY4DB6KfLD/fM6FYW0J9edDMKeXkKFusjo8STzNq
 dFu++Xrje8s/6J8+r6YrjmMlyzJT5A/a64z/8hY7O0OEwr13ONDR/6cukfsgJ0Ht9ekC
 dkqfCUKtLNKZj6BQEgG36TKy30UsdMUrF8F+ar1r6h/kP33MtZQSygUAyhT4CKvhVqM2
 X9vCWNgKCG5OBWhuqycQBfWW0bzOJSUg15aF2D9efPJ46/WQIjcP+mlBvqN25ZHX6RQP
 BmWA==
X-Gm-Message-State: AOAM533qSc4QYYetq+cdmoiDOX804auzVZgRojEy74D1fps6VwesmRrB
 Tv3MuJaGKhS3ruzF1jhMMzqZ3vbZWW4=
X-Google-Smtp-Source: ABdhPJyh1jnbILIgMrUPC/4LYxRWdrFMvyNR+CEfefilLmOlstg4oul/nFhP72phUjhtV/e4rvD0Ow==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr934384wrs.388.1599054549443;
 Wed, 02 Sep 2020 06:49:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id h5sm7562528wrt.31.2020.09.02.06.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 06:49:08 -0700 (PDT)
Subject: Re: flash programmer support in arm targets
To: Ronald Steinke <rsteinke@twistedpair.cc>, qemu-arm@nongnu.org,
 qemu-devel <qemu-devel@nongnu.org>
References: <CACUpvubY7qTh7Tg5euFSqB+b3V8eU62f3kU8qdMuRLFV1UgtCA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4cb93951-770a-f64f-fffc-4ab1c8e8ff7f@amsat.org>
Date: Wed, 2 Sep 2020 15:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACUpvubY7qTh7Tg5euFSqB+b3V8eU62f3kU8qdMuRLFV1UgtCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ronald,

On 9/2/20 3:30 PM, Ronald Steinke wrote:
> Are there arm targets that have hardware support for the internal flash
> programmer registers (e.g. FMD/FMA/FMC in lm3s6965)?

No, the flash controller of the Stellaris LM3S6965 is not
implemented.
Note that it is very simple (2 operations, 6 registers + 1 set
of protected bits), thus easy to implement and test. You can
have a look at hw/block/nand.c to have an idea how to start.

Regards,

Phil.

