Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A393C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97BF24655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 15:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0Iagp7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97BF24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihF75-0006Ux-Q6
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 10:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihF6T-00066U-3n
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihF6R-0001vP-H4
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:49:40 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:35201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihF6R-0001sP-BI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 10:49:39 -0500
Received: by mail-ot1-x330.google.com with SMTP id f71so4683008otf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jVwXCSmM8/TQE//M+K3tfvuIIchNfzOHhWN8mGYG+Wc=;
 b=S0Iagp7NwwcRxavX5+NBf7c7h5Wn/mpzMy9Bok29W0c9TxrvOD3RxwhEfcAW2SEpam
 4utyXVQ0AXCyFxPAfDjbq/L96YZgKL2UPy7mydRonNDqRhdJZjDPs/Hi5z60qytQzc31
 1lM7T+xfswcj3OSYj+wx63NYM6Nk/I1kuHndlMSDz9jb8ZgzrHGf7zNO0dXk4ShED4Zb
 6g5cxVvVjLI4t50o8CEMVGebh4K8qYNlmZHvr/HMy71EOuW21o3vIu+3Rr4LsAX2JraN
 T1iBCMDqIKp4A2dI3dBz0Xfx55zHGviiU7lYdZR8umCy/WqZj/WUI5ztSS5crVSIysJI
 XGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jVwXCSmM8/TQE//M+K3tfvuIIchNfzOHhWN8mGYG+Wc=;
 b=UBjAHHOSJYcQgmiZVmBD6dCQzIRtTGC19Js/bRKntCo/lCnZWEnD2uB9D3tnCxET3M
 Px5LbZC53QDFg01hqEHfupI+6Fb4trmYU9mfn0RllEIqKq3A1gBEfC47v0JjSZsGWZvn
 Jys/kUUJJzL0Mib4bjm6PIUMIdvL0BO2wkOw87LM8ApP/yzoT+oWw1SdZ3NIprwb0JTF
 RxbYZiUdyzmxIDKqQRivyA2NUskGvGFbQvuE8CQdcHFBP9vRAWDp1s0X8VUOIxYRnkmb
 Vq5LFEE7C4+p1/sDAkRHjU52bxjrAMAOZfaAc4PR70QgoN6XdsZssziTvGERKw2m6DiF
 /ODQ==
X-Gm-Message-State: APjAAAUH6aGg6pCM1/HfvGUb0iSBr5Ka9yjOseuEAncztnOliqHyd7UE
 g36vquAWQxeX5Q8zeW70eRXt86S6Zz9IJTZ+J93QCw==
X-Google-Smtp-Source: APXvYqyu/cuOS0wE4NnlfeMu/SrHm13jZa9pXhlpiGlIw8yqFBkR7QGsDCu938VSTp9B8lwTi7YhRcFqn1e7fEC1bdI=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr36505610otp.97.1576597778423; 
 Tue, 17 Dec 2019 07:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20191217062651.9687-1-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 15:49:27 +0000
Message-ID: <CAFEAcA8a=E9GLnAz+vFtSQ8w=5RJK5aZJvQhEzxsRrThvMT5FQ@mail.gmail.com>
Subject: Re: [PULL 00/34] Error reporting patches for 2019-12-16
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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

On Tue, 17 Dec 2019 at 06:33, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-2019' into staging (2019-12-16 14:07:56 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-16
>
> for you to fetch changes up to 0e7f83bab6559775cd71e418b12a49145e59faa7:
>
>   nbd: assert that Error** is not NULL in nbd_iter_channel_error (2019-12-16 20:50:16 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2019-12-16
>
> ----------------------------------------------------------------

This gets conflicts:
diff --cc target/ppc/kvm.c
index 7406d18945,27ea3ce535..0000000000
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@@ -2076,7 -2076,7 +2076,11 @@@ int kvmppc_set_smt_threads(int smt
      return ret;
  }

++<<<<<<< HEAD
 +void kvmppc_error_append_smt_possible_hint(Error **errp_in)
++=======
+ void kvmppc_error_append_smt_possible_hint(Error *const *errp)
++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
  {
      int i;
      GString *g;
diff --cc target/ppc/kvm_ppc.h
index 47b08a4030,f22daabf51..0000000000
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@@ -28,7 -28,7 +28,11 @@@ void kvmppc_set_papr(PowerPCCPU *cpu)
  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
  int kvmppc_smt_threads(void);
++<<<<<<< HEAD
 +void kvmppc_error_append_smt_possible_hint(Error **errp_in);
++=======
+ void kvmppc_error_append_smt_possible_hint(Error *const *errp);
++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
  int kvmppc_set_smt_threads(int smt);
  int kvmppc_clear_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
  int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits);
@@@ -164,7 -164,7 +168,11 @@@ static inline int kvmppc_smt_threads(vo
      return 1;
  }

++<<<<<<< HEAD
 +static inline void kvmppc_error_append_smt_possible_hint(Error **errp_in)
++=======
+ static inline void kvmppc_error_append_smt_possible_hint(Error *const *errp)
++>>>>>>> remotes/armbru/tags/pull-error-2019-12-16
  {
      return;
  }

Furthermore, it turns out that the conflicts are due to
different patches from the same author to the same function
("ppc: well form kvmppc_hint_smt_possible error hint helper"
and "ppc: make Error **errp const where it is appropriate")
which both seem to be addressing broadly the same thing
but conflict with each other and arrived via different
pull requests.

So I'm just bouncing this one back for you to fix and
figure out which version you want...

thanks
-- PMM

