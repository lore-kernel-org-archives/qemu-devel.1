Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE14C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35DF20867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWaNZ/8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35DF20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIw1-0005BI-Gr
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaIuu-0004LJ-Ff
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:33:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kaIus-0001oU-BI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:33:35 -0500
Received: by mail-wr1-x436.google.com with SMTP id w14so22024524wrs.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wUiCCIMAuUYCmfpZIW1GfPTOZevOoYArgDwtxa2M1J8=;
 b=YWaNZ/8ERlcybsDuGJx5rhdMRiS7JIEbz4P8sI8bY2RpsScyYSK2tEPm5EM1U5xQsj
 2B2THr+oQpVwatGby0WetyexfADulFThrOaeDDW5u0llsGf9m45HX/rAL56u33icCl7x
 vcbwV8QxBXYMCXDumHVqfsSUsjVziQ2z6TPQGFw9LZcPilliXBMNdkhBtSrYNS4qwlv4
 ne7dthuqgzDcy053JXtKVv5F2H9D1c/rkOk8iVok171qUIsijDNkqQV07TFOECfGD2/6
 Jt4Xqo45xERzckOsm2u0UTGVCdf75mSO+bRs6DtUW/XJxgnaheDItE15LRAuYwSoZm+U
 CEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wUiCCIMAuUYCmfpZIW1GfPTOZevOoYArgDwtxa2M1J8=;
 b=PzWLH6rjsMhtwx8FX1bvYaYEXn9w6Q9Pqur8dLvy6MiIQer17P3bBTgVk/eTnoIlvU
 AyuGV/wdnPBky/7nuShqU61JTgFLiCpjloAE2at/QYfrqlGuQ0JlGDwYe0Vq/kRn1ahN
 GZjj3tCKnlYRhIw5rf8CJ8mFNgtuFtwzMf2odDMesTjm4DFMvUcmSQUGgXj3c6X5wNyt
 aYyThMKJXHCWMV5PS2cUUXhz/Ig5EkP820T3mYfqUrw+KKUiLlsQzCN7JkDzLDI2HL4X
 6lSI5WF7zZEyGjYPJyLi/XWFN4ECtwj1pKFqDazDsta9xg9OL6Foq5DeZZyLzY48+1YP
 J43w==
X-Gm-Message-State: AOAM532pNMdAmX9it6WUioQPPhq7u1GB5RDrX3YGCKKyc4EjGUqWRjHa
 SWzCMvhCvBIYiTBfEINC30U=
X-Google-Smtp-Source: ABdhPJw+yDpfjIyqjOFmSVgtnAd4UFCz/KY44h4Q5pJUjgUJrhJwjXRIR0/O4wyTLcCze7I+zpc4YQ==
X-Received: by 2002:adf:c101:: with SMTP id r1mr30801406wre.87.1604496812716; 
 Wed, 04 Nov 2020 05:33:32 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f17sm2650368wrm.27.2020.11.04.05.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 05:33:31 -0800 (PST)
Subject: Re: [PATCH 2/3] tests: remove "bc" from package listing
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104131924.593522-1-berrange@redhat.com>
 <20201104131924.593522-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4fc628b-72b1-e29e-2cee-102ce779a08a@amsat.org>
Date: Wed, 4 Nov 2020 14:33:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104131924.593522-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 2:19 PM, Daniel P. Berrangé wrote:
> There is no sign of 'bc' being used by any tests in the tree.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/coverity-scan/coverity-scan.docker         | 1 -
>  tests/docker/dockerfiles/debian10.docker           | 1 -
>  tests/docker/dockerfiles/fedora-win32-cross.docker | 1 -
>  tests/docker/dockerfiles/fedora-win64-cross.docker | 1 -
>  tests/docker/dockerfiles/fedora.docker             | 1 -
>  5 files changed, 5 deletions(-)

I added it to be able to rebuild easily the blobs consumed
by our tests:

commit 1bbf2d010fc0e5f0a9c5e1967368c44bc64e086a
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Mon Mar 16 17:21:28 2020 +0000

    tests/docker: Install tools to cross-debug and build Linux kernels

    We often run Linux kernels to test QEMU. We sometimes need
    to build them manually to use non-default features. We only
    miss the tiny 'bc' tool.

    The ncurses library is helpful to run 'make menuconfig'.

    Finally, gdb-multiarch allow us to debug a TCG guest when its
    architecture is different than the host.

I think this is related to the question of what we can include
to the repository for testing... If we can not add binary and
don't have how to produce them, it becomes complicated.

