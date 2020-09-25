Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8624C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0B2208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew72VXaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0B2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLr2x-0001Uv-7X
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLr0L-0007d8-CV
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:55:29 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLr0J-000394-Gm
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:55:29 -0400
Received: by mail-ed1-x542.google.com with SMTP id ay8so3165432edb.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DcYykCHyeNl6J7SncadKiN6WQ0gXErLUY/rp3GEE4Dk=;
 b=ew72VXaj1Bi4rkmM2DoWWlB3AddUdasKTxDPlefCIBm2wqGw+SPNJcIbmC0R9PAXTL
 98xW0t+DsCk95N0fMW8gwj5wfzb6h/FyNjQar/0zfMsuRXBi+1XAleLQoA83FKPpxWBK
 XdiXYL2RQfnntnRfskwn4sTAxK9LUrypG6p4a8e8x/oQzwSl/sq0BOQfUA5DU8p6azoh
 avske/6TgV5QEEF/pFxclAdg5cqHwDRa9bOTY72vzyW0fPhMHyiYii2RbAf8ivQGr7IW
 r1eHBQtrpCCVAELDCobUvQFOdtC0svQBUeWmuHrxaksU8r4SN3HPQPkogd3AEFKeCxpE
 aWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DcYykCHyeNl6J7SncadKiN6WQ0gXErLUY/rp3GEE4Dk=;
 b=qcdDg0C81xA73Sxm4ndCUpS0W5rb9jJnI5VYBp0OnAvGBBSeLxc9EnXStyQimgaQ8g
 rWzbGiphQPEdV87kLW+bzOUgX2BbALHlShdhnFUVb3Vj8XDjkyArJ76YIcPgWYd0Yf05
 GDez0uwG43/fwCnGInjKlARnFPDUvPYYOXYL3wJC/+8iQgLH4WCEthtYe86FCzCmBBJu
 +78nYgYCLwEj6FFwWlNBvq22Vp47JIPGtVcpOiweRBr4vgoB1Y2XVBZDpXW5KVGDgkGP
 AXcv91rljcdBpWVN6FBRFuqPJVlO2OnboPKa3RDxfixg7URiBwJ7FPda3k/NhZY3mCKJ
 LfvA==
X-Gm-Message-State: AOAM532f6W3zCVB5huqC/wudoLocLTbYQTF3SQsrQGf3hwXASGKVP1qj
 Z0pXfB0DmwEn3NJ07I0nElllukxMc7EaO4xQENk4MQ==
X-Google-Smtp-Source: ABdhPJzcSDwfNVoT1rOSgkMPh3c1HZOzcU4j0alEuB8t8qG4gCMTG1RRgli98aTKz60mCirEX/8VwM6yS8/ZlT1MLxU=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr2441434edq.52.1601052925914; 
 Fri, 25 Sep 2020 09:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200916142004.27429-1-cfontana@suse.de>
 <d0bb4af9-55a1-b332-af6f-7601dfb10db7@linaro.org>
 <402c303b-64a4-c2ed-151a-48f2e2cb40ac@redhat.com>
 <66180c1d-f075-dd0c-cddc-bc26e511aef3@suse.de>
In-Reply-To: <66180c1d-f075-dd0c-cddc-bc26e511aef3@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 17:55:15 +0100
Message-ID: <CAFEAcA9sq_nes=LBQE2b+ANYMu=pQRHh7_2k9joprAMOxbLE1Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] QEMU cpus.c refactoring part2
To: Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 haxm-team@intel.com, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 at 17:09, Claudio Fontana <cfontana@suse.de> wrote:
> Hi, if it is helpful I just rebased on latest master and pushed to
>
> https://github.com/hw-claudio/qemu.git branch: "cpus-refactoring"
>
> The following changes since commit d4277402b5e4645e4c7706a3221f8acd3f1a50f7:
>
>   tests: add missing genh dependency (2020-09-25 14:10:56 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/hw-claudio/qemu.git
>
> for you to fetch changes up to 4822a683c261c249e46d26cd65ff37cc1e1cfb94:

Hi -- any chance you could not include the pull-request cover letter
wording in your emails, please ? It causes my filters to put the
email into my "pull requests to apply" folder...

thanks
-- PMM

