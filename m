Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EE3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB83C206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILJ4gHCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB83C206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBXJ-0000rB-Uh
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBUg-0006mk-Lu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:19:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBUe-0004xt-6E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:19:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so20730642wrv.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lvyOdCj1Yx9Nx/M8YnLTELxYeeS6rNx6FmPz7aIm+d8=;
 b=ILJ4gHCBgQfG5OZtoWxxgHC54nw4gGI+ldnMdrUsuBDw6ZhPRRE3UxSvTPnCqMM47Z
 8G9xpra6My0ACBVdJ8K0wJISBmVe8p6b6sEU7VKzDEM9vNs+MdkMMrh7iaeGKcgnzfxT
 xQOTfAJdzExgECjQVcwZluPEWhowWzxWCPxZGtWngHLOC8TXQaDzN7vB1TPJDLljSNQW
 5f5idXGbrltUQR9/inRm14HuOn/1StXHRK4dlyj+Aa3yKaSIuFGCdqrvs6JatHy39WeA
 uhcntbV6BwUzUWE/NlWIL7dgTtYM8hE1sRcJOGcmQMQ7EmaLhQe/c2LlD9S83DWawPJR
 YsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lvyOdCj1Yx9Nx/M8YnLTELxYeeS6rNx6FmPz7aIm+d8=;
 b=IV3doxCN40DtPO4rwBG9hONPyqB/aDu0cxDfhzsJT4hlVbeRGAiC0t3G3XPSqTkcKq
 gmJgkagqABpTdW6gZAcEfN9jYjmj1lvbm3CXCfC0W9+VVABDBzOQ3gSYzQeeTWpNBhkB
 UZfJvpKt1SYv3lfb5Vbvf4qYUs6PQqu+gb1rLbcp+FK98d+C7Dczu8gp5F1SmRlM88CG
 fQiUtZSsGJeBb7AT5HLRMNSVpfRljyXtmDqJxgTQ1BaxBHGIgdVsT5/l+KWeZUke+J2J
 IEXvGBhLZ4VRtFru1jySgBIli5AUQrWjYT3fUPChOKdHTlLgBCftMf2NbjSvTWGO2+Bl
 S2jA==
X-Gm-Message-State: AOAM531APXuAdYAWVIP0DPuMQhMZ84HWHYZUzNovHvKp1DWnHJrSZ5QM
 D9hVfAGW3j4s0hCLl2Vdczxpmw==
X-Google-Smtp-Source: ABdhPJxIGui4vtqcBKu65hmbioRxYscB7+GytlPbypQ4o1sOqD8Q30OAU9sNLvZlpuScB6cXW3Uaxw==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr852147wru.324.1592313549950;
 Tue, 16 Jun 2020 06:19:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r7sm3749801wmh.46.2020.06.16.06.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:19:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C73051FF7E;
 Tue, 16 Jun 2020 14:19:07 +0100 (BST)
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-3-cfontana@suse.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v5 2/4] cpu-throttle: new module, extracted from cpus.c
In-reply-to: <20200615180346.3992-3-cfontana@suse.de>
Date: Tue, 16 Jun 2020 14:19:07 +0100
Message-ID: <87a713173o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> move the vcpu throttling functionality into its own module.
>
> This functionality is not specific to any accelerator,
> and it is used currently by migration to slow down guests to try to
> have migrations converge, and by the cocoa MacOS UI to throttle speed.
>
> cpu-throttle contains the controls to adjust and inspect throttle
> settings, start (set) and stop vcpu throttling, and the throttling
> function itself that is run periodically on vcpus to make them take a nap.
>
> Execution of the throttling function on all vcpus is triggered by a timer,
> registered at module initialization.
>
> No functionality change.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

