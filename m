Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CD220BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiviDVix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CD220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkfm-00079w-4u
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkfC-0006jZ-20
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:09:14 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:35807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkfA-0006Bc-1w
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:09:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id u21so2891896eja.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=g3lSyxDdiSKeUGX8Pi5+8vWMx3p/sCXvccDvkEYzo0I=;
 b=MiviDVixlVf6LTD4gE0/XnonReTsjpmwxUIt+LfsCdtb+sNyfl6SpjDHxJAHfG2/g5
 qBDd0nZkUJS9mujELQ9S4NIEVvL6N68VtX5Bosl8Xesn3PkP05loFOUCubKVWEJD+J3p
 kPjrM6I4LARhZ9wgr7fdEIDOMWbKAaTvhOaPcccHsWLAFua/ozVrOngSL5Z3ViXwc8X8
 qTipBVFaiYU5RySqEcgBU1bPMIpA5zyHtIx6ZBqCpDrD3p0mI1DtKMod9Dyrzf+qqyAE
 7qctbyvQOEfeDICP3YZHKoR+1QDtMyaN4nUaDJcNFLCa2dg2ZBHqZ6NbYZBFYwPjTBZ4
 Lwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=g3lSyxDdiSKeUGX8Pi5+8vWMx3p/sCXvccDvkEYzo0I=;
 b=JZaBSY4pLlDJXapAKj2k+QjCt8oEkuqchWgHazdQLdKnBnJcf8s7XTJZRijtYExvIT
 +G8GZR+8Dz+Tw2eKBNt5e+WJRbl+qNCXMNikgYjv/ZfS54aRW6ofZoT8X4HdsiY21/qU
 4IM9gP1tOaXHx4YyER3UAGaAqiXNr/ZdDP6ji2MV/gEOfaofqKh7pbCOlhrCkHosITg3
 H7FcrPslgHkA3IV+KvuguLjQlZy+9aNwzDdve2jbZGe5Cp/O2DGmSvuYngCPbQQ2OoPm
 ebE+4SY7nDkl3msDUVMaunsMrZa/HGnP1WyCAY/GrJz8w5Y5JmVzJ+b6C/hU19JApK4J
 higg==
X-Gm-Message-State: AOAM532bsCBJmhzAfiIQreudAwiVc3dU4KE3BLGP+2TeogfuNYrY2my3
 EUNyIaOO/lToGURwxQ62PRODghlq8YOwZeUOOpMASw==
X-Google-Smtp-Source: ABdhPJzUUwnDT72lLnJqwRtjUsTQozVb9QVZT5gTlsnROxZp10iBKtbmKL/tb8KJxhWdRfZhTGhiforvJWiIRvB76aY=
X-Received: by 2002:a17:906:552:: with SMTP id
 k18mr1874798eja.482.1601028550421; 
 Fri, 25 Sep 2020 03:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200924092314.1722645-1-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 11:08:59 +0100
Message-ID: <CAFEAcA-HeCVAOt4OP5Jq_vMj2cCpO2efC7Db0B70OXbJaxRCww@mail.gmail.com>
Subject: Re: [PULL 00/92] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Thu, 24 Sep 2020 at 10:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 0fc0142828b5bc965790a1c5c6e241897d3387=
cb:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/input-20200921-pull-r=
equest' into staging (2020-09-22 21:11:10 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f40b138ec74bfdaf50f77e46e4b9c10a38f43db6:
>
>   Merge tag 'pull-cap-20200922' of https://github.com/rth7680/qemu into H=
EAD (2020-09-23 14:39:20 -0400)
>
> ----------------------------------------------------------------
> * SCSI fix (Dmitry, Li Feng, Li Qiang)
> * memory API fixes (Eduardo)
> * removal of deprecated '-numa node', 'cpu-add', '-smp' (Igor)
> * ACPI fix for VMBus (Jon)
> * relocatable install (myself)
> * always remove docker containers (myself)
> * serial cleanups (Philippe)
> * vmware cpuid leaf for tsc and apic frequency (Sunil)
> * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
> * i386 XSAVE bugfix (Xiaoyao)
> * QOM developer documentation in docs/devel (Eduardo)
> * new checkpatch tests (Dov)
> * x86_64 syscall fix (Douglas)
> * interrupt-based APF fix (Vitaly)
> * always create kvmclock (Vitaly)
> * fix bios-tables-test (Eduardo)
> * KVM PV features cleanup (myself)
> * CAN FD (Pavel)
>
> meson:
> * fixes (Marc-Andr=C3=A9, Max, Stefan, Alexander, myself)
> * submodule and environment CFLAGS overhaul (myself)
> * moved libmpathpersist, cocoa, malloc tests (myself)
> * support for 0.56 introspected test dependencies (myself)

Conflict in docs/system/deprecated.rst, which was easy
enough to fix up but then git tells me also

# Changes not staged for commit:
#       modified:   capstone (new commits)

so something is weird with the submodule status and I'm
not confident enough to go ahead with committing the
resulting merge commit.

In any case Richard's pullreq fails to build so I imagine if
I got to trying to test yours it would fail with those issues.
This kind of thing is why I prefer merges not to come with
other peoples' pullrequests pre-merged into them.

Can you rebase and resend, please?

(You might also find semantic conflicts with Stefan's
now-merged pullreq that includes the atomic->qatomic
rename; I didn't get far enough to find out.)

thanks
-- PMM

