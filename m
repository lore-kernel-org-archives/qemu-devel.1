Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB428C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 11:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4CC2078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW/eZnR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4CC2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk4Ac-0002lG-NK
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 07:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jk49n-0001hX-BT
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 07:17:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40877)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jk49l-0004cW-0u
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 07:17:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id r15so10266924wmh.5
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H+lZ/bzUu/WlKlAoN7/C0YR19ugvHxsurBmCu9+4kUU=;
 b=xW/eZnR5OC9f5Tzo10XF2V+eNuGDSG/oxyVGVre74hm89w9YxD9c+XoAFnB2TkPv9i
 SfrKnw2rxlvEAz9pzKi4n8gbYdoG6ORSoqfTrGGD9VbulajmcICWYaP5tgwVGuH0Jsq0
 lLUGbKJxnorib8uiDYAr+wU3ejvb7YO45if9R/iB9ouoXT0TNdmlC2up7kd+sihF4wjf
 yJ978czO2Sg0h4CQLsAQtn5kRFs5/vR05hvwKCmIqPfpiUBJRrRJjON5UyQQw53iSMXd
 1fvTEc4utcB1/upHHcLy8FiDfSYAqTLM6s+AcsmTiWYrL3MdlAVrThRWSsNAA8F/5idh
 rHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H+lZ/bzUu/WlKlAoN7/C0YR19ugvHxsurBmCu9+4kUU=;
 b=BJ21naNGeWc8ADez9alt3v0u9YFhHJnzJaDUwqDoPYkpfq+Ud8iq4vbNMB4O6tVifn
 oi1aGsxc2/RdagQ3Yt5ic8i/rUgpEIBdtDrE1ncNlcMw6oow/B1FSTuEoxyymjF+H3jt
 NxH3dYxp7kE9d+rYyekvMNJklwjch1S6YvxR8i2LbRBRXdCVLWzojbT45+sDvEy/Rr7H
 jTsP4+C8izzTb/8ZfvkwmzFwxQzw311e0wIsAochbygg81LEk7S6/nMobSz95yP8i0n2
 Z1X86sENkmg3v2C0kTNyvOD2dqoGOXMB1BScp5wCjeY1IGPeiPzOD2ZBUJZr0e3KYtiD
 C5nA==
X-Gm-Message-State: AOAM5310gF2XZtdeY4d+Ai3oZlFUPgyjEemiGT27lTTozyMUmZ0uZm1r
 c5+W2lk2+nL6NyX2IoqpfnLQOw==
X-Google-Smtp-Source: ABdhPJx8B7Ai47J3j35X2zFeSK74q9/eVnfjaWNJNHcTNknlHx2bLR1RF5r0LRg/TA2sGk9Pdfev6w==
X-Received: by 2002:a1c:dc44:: with SMTP id t65mr3733192wmg.128.1592047011635; 
 Sat, 13 Jun 2020 04:16:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j16sm16804120wre.21.2020.06.13.04.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 04:16:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5909E1FF7E;
 Sat, 13 Jun 2020 12:16:49 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 0/5] linux-user: Support extended clone(CLONE_VM)
In-reply-to: <20200612014606.147691-1-jkz@google.com>
Date: Sat, 13 Jun 2020 12:16:49 +0100
Message-ID: <87lfkr43mm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Josh Kunz <jkz@google.com> writes:

> This patch series implements extended support for the `clone` system
> call. As best I can tell, any option combination including `CLONE_VM`
> should be supported with the addition of this patch series. The
> implementation is described in greater detail in the patches themselves.
>
> Testing:
>
>   * All targets built on x86_64.
>   * `make check` and `make check-tcg` are passing. Additional tests have
>     been added to `linux-test.c` to validate clone behavior.
>
> Caveats:
>
>   * This series touches, but does not fix, several bits of code that are
>     racey (namely the sigact table and the fd trans table).
>   * `exit_group` does not perform the appropriate cleanup for non-thread
>     children created with `CLONE_VM`. CPUs for such children are never
>     cleaned up. The correct implementation of exit-group is non-trivial
>     (since it also needs to track/handle cleanup for threads in the
>     clone'd child process). Also, I don't fully understand the
>     interaction between QOM<->linux-user.

When the QOM object gets unrefed for the final time it should cause a
bunch of clean-up in the common vCPU management code where things like
plugin cleanup are done.

This was recently touched in 1f81ce90e31ef338ee53a0cea02344237bc470cc
where I removed linux-user messing around with the active cpu list and
left it to the core code to deal with. Previously it wasn't being
properly unrealized.

>     My naive implementation based
>     on the current implementation `exit(2)` was regularly crashing. If
>     maintainers have suggestions for better ways to handle exit_group,
>     they would be greatly appreciated.=20
>   * execve does not clean up the CPUs of clone'd children, for the same
>     reasons as `exit_group`.
>
> Josh Kunz (5):
>   linux-user: Refactor do_fork to use new `qemu_clone`
>   linux-user: Make fd_trans task-specific.
>   linux-user: Make sigact_table part of the task state.
>   linux-user: Support CLONE_VM and extended clone options
>   linux-user: Add PDEATHSIG test for clone process hierarchy.
>
>  linux-user/Makefile.objs            |   2 +-
>  linux-user/clone.c                  | 565 ++++++++++++++++++++++++++++
>  linux-user/clone.h                  |  27 ++
>  linux-user/fd-trans-tbl.c           |  13 +
>  linux-user/fd-trans-type.h          |  17 +
>  linux-user/fd-trans.c               |   3 -
>  linux-user/fd-trans.h               |  75 ++--
>  linux-user/main.c                   |   1 +
>  linux-user/qemu.h                   |  49 +++
>  linux-user/signal.c                 |  84 ++++-
>  linux-user/syscall.c                | 452 ++++++++++++----------
>  tests/tcg/multiarch/Makefile.target |   3 +
>  tests/tcg/multiarch/linux-test.c    | 227 ++++++++++-
>  13 files changed, 1264 insertions(+), 254 deletions(-)
>  create mode 100644 linux-user/clone.c
>  create mode 100644 linux-user/clone.h
>  create mode 100644 linux-user/fd-trans-tbl.c
>  create mode 100644 linux-user/fd-trans-type.h


--=20
Alex Benn=C3=A9e

