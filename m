Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637223119
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgvJOfdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637223119
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5WG-0003Pa-Fz
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL5UV-00028E-CC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:11:27 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:41877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kL5UT-0002Du-HY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:11:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id lo4so27937052ejb.8
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C5DffLpEbf6xWIp3rZqM5eZtsqe3TCM7SboNavNdXIM=;
 b=hgvJOfducTbQ80g2qS9XtM03cUUwztD6ypFirbp7B6tVJzqeyFrhvBJ70amIPD72RH
 kQb6Wbk29Hg8rsf8QvH44OWOJu/dRBdnRPCyhA8rFIB6y59bd3xXOly7DHAN1AmMpHS+
 Q6VGYOvOU2GLxF14qfgAZqMznjGHdb0sxgc+Ozba8yShS5i9JEPialFdlxXdenKb5cqn
 T4+G1v7MiamsVBEusRKT48at/9KFlnYEJqG22bzwBb1uGGI+SJp7RKpYvANe8LD35o6g
 /7KPGNRPdJZWojrzioFnap5m482yJ8FY8yQM46Or4flysd8QqM/prsCfcgqxLgIx3Qu+
 4vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C5DffLpEbf6xWIp3rZqM5eZtsqe3TCM7SboNavNdXIM=;
 b=tzsQLZuDNcPbe4Gr1Kw+g3MQ8Udl7jnV0HTiuXymTDJ5zZZVrA9BPJQvWBlCSs7mFk
 CyakkntX7WIJ9rF5QaoQDycon/vHhqUHdPLORMJHZbsue/dLLlyswjAUn+flGVnfWjXg
 jq6K5s1IjYArmhhORPQnpVUpKTERB2BrGhy5RMOIDrYMhAnJDUaoiNYL5J5FcNN5x3EH
 ZbfpfODqT7MRrmStAPylndz9ul+w/KVFHouojC4ZUZDVu14CYcosSdkXr4Hg5p7ncFA4
 78c0BYfhCoyU+PT9bnqN80naiYwevrN2B+MGvPRlbmahgZxpl/ji/fsir72TG/aoeLk4
 QyMg==
X-Gm-Message-State: AOAM530xv33H/KdwuLN1D1KMsnVSFx8h4vwqkWKOeyODIn1R1vdy2JXY
 dnpz5JvDfipZiLovPMitASyHk2Ed5DWWC6/VVZr0Wg==
X-Google-Smtp-Source: ABdhPJwrahGZvWZargPn1fH684eCCCUjYBJJAcbzgrw8ZGQtpKbRXRVuCu+7g0OOu6eFwp4XftgBP9WtrmRHLRZXfU4=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr10646599ejb.4.1600870282177; 
 Wed, 23 Sep 2020 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200921155638.1328200-1-pbonzini@redhat.com>
In-Reply-To: <20200921155638.1328200-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Sep 2020 15:11:11 +0100
Message-ID: <CAFEAcA8JxxFWzTQQPkdovat9wS_p05TRZhyUZ81U=-JcMzukRw@mail.gmail.com>
Subject: Re: [PULL v2 00/57] Misc patches for 2020-09-19
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 16:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a2=
16:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-2020091=
8' into staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6b58f5adc256c7b7f61f1b22fba75b4c6218ed0b:
>
>   oss-fuzz: move linker arg to fix coverage-build (2020-09-21 10:23:09 -0=
400)
>
> v1->v2: rebased, couple new patches
>
> ----------------------------------------------------------------
> * SCSI fix (Dmitry, Li Feng, Li Qiang)
> * memory API fixes (Eduardo)
> * removal of deprecated '-numa node' (Igor)
> * ACPI fix for VMBus (Jon)
> * relocatable install (myself)
> * always remove docker containers (myself)
> * serial cleanups (Philippe)
> * vmware cpuid leaf for tsc and apic frequency (Sunil)
> * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
> * i386 XSAVE bugfix (Xiaoyao)
>
> meson:
> * fixes (Marc-Andr=C3=A9, Max, Stefan, Alexander, myself)
> * moved libmpathpersist, cocoa, malloc tests (myself)
> * support for 0.56 introspected test dependencies (myself)

Conflicts on merge -- could you rebase and fix up, please?

thanks
-- PMM

