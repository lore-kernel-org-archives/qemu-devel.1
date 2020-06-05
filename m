Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C08C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8FE206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jycu/C6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8FE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFUN-0006v3-W2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFTi-0006UX-Mp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:45:58 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFTh-0000dV-5P
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:45:58 -0400
Received: by mail-oi1-x22d.google.com with SMTP id i74so8777622oib.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hozvTI0alFdKVDODrWq7ZsOV9shpDED/o4OjBoCTE6Y=;
 b=Jycu/C6j3T1LtYDAK8DKWXqr4Vl0LV6fXhh5yAKCXMZXlPj51DOkPCS8YZ3BM1r1IZ
 tYHV6vESX8uWiWzroccp1ZIb7Px1KxotrYCo60Xh+S+kFq8rUzdQ+FruK+SFk8mnsopj
 fDnvH/y5/A5FjSa7VphOwh6YsIVsWq0hKx9moX0l/p7jaLXI70/Tqw8s4ld1lQCiqc2S
 6FmJ6NfKtFUjQNaY8nvOSxHeo3Igw8hJQyUlhBUL2Wvmna88eV/lozJfMWK2v2AHpTtT
 xZR3SV4RUWtT/f0eF2VAqQveSmCgVw6keKZlrRip+MvYTO2VcJK2PHXe1a677wgO/NMb
 M/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hozvTI0alFdKVDODrWq7ZsOV9shpDED/o4OjBoCTE6Y=;
 b=S+Jl1/mrUWoY5LVhbJZGnZKBmYbw/2n53GxWa4bglIb3IK1syfkHtXufaAf9XgwdSf
 EjJsL48iGSRFuoIwlN0dG+ugY7RGEZJHj2eimzeEmW+ShPQ1Ij82eZhOWSQpUPHW5n/5
 +3p344yt6cEeT29eXwR3KSq1c/05zZCG6nhE2BxnlP42mN0K8qVlQbyye4ERE/twPfVR
 cUsV2kgNZDOxJMoY/+gRxAJLSzZWUcv/vy6eBj6ToOLHXdBULTMBpOdAvU86z3A57beT
 FJp5IWfxbP5x0/7y7FjgYqx5KvuWr4mrV2W4yqSrIv+tSrj0kr//himkwuX3eJgYzffh
 jBcg==
X-Gm-Message-State: AOAM533O+UOtPyd/JDiLtWoC28UyDjHPFMEDgbJ9epWfNeCMMjtrzbx4
 yrb7DQTOEpAU1JWndcyTMzH358PEqiZMKbhLH36ggw==
X-Google-Smtp-Source: ABdhPJxpWY/Yy4xAoRQisbrLs+lDRfqlbFKuVYZuY0frw/n86lsZj/++TMEChU1ZDPcVlHJiaBwV89fPqZU/3IdWxRE=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2372994oib.146.1591375555473; 
 Fri, 05 Jun 2020 09:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200605114700.1052050-1-laurent@vivier.eu>
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 17:45:44 +0100
Message-ID: <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
Subject: Re: [PULL 00/19] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 12:48, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac635=
10:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' in=
to s=3D
> taging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
>
> for you to fetch changes up to aa3d2045d4ca760bd8c22935a2d73ee4f3480bd5:
>
>   stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 11:36:00 +=
0200)
>
> ----------------------------------------------------------------
> linux-user pull request 20200605
>
> Implement F_OFD_ fcntl() command, /proc/cpuinfo for hppa
> Fix socket(), prnctl() error codes, underflow in target_mremap,
>     epoll_create() strace, oldumount for alpha
> User-mode build dependencies improvement
>
> ----------------------------------------------------------------

Hi; this failed to compile on s390 and ppc when building hppa-linux-user:

/home/ubuntu/qemu/linux-user/syscall.c: In function =E2=80=98do_openat=E2=
=80=99:
/home/ubuntu/qemu/linux-user/syscall.c:7484:42: error: =E2=80=98is_proc=E2=
=80=99
undeclared (first use in this function); did you mean =E2=80=98
is_error=E2=80=99?
         { "/proc/cpuinfo", open_cpuinfo, is_proc },
                                          ^~~~~~~
                                          is_error
/home/ubuntu/qemu/linux-user/syscall.c:7484:42: note: each undeclared
identifier is reported only once for each function
 it appears in
/home/ubuntu/qemu/rules.mak:69: recipe for target 'linux-user/syscall.o' fa=
iled

Looks like this is because the #if condition guarding the
is_proc() definition doesn't line up with the uses (missing
a check on TARGET_HPPA).

thanks
-- PMM

