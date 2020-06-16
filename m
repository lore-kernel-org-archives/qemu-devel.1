Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DB9208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4jdbik/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB9208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlE8V-0002F7-0q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlE2V-0002d4-Mu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:02:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlE2N-0003Ty-0r
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:02:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so21374746wrc.7
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tC342W3u8Hf+SqaVj5fo+tJgKTfB85PVplFBVKEhgfk=;
 b=J4jdbik/2EjNxPOyx0q4J32Zb5yk+pK5Il2i0B80y/4AcdMrFtdf+ugqJiozvyjuWF
 T3gwl71jIzeZzrnQ4j4wcPNBovygpwUuXKEi77DZLFJfdbmq6rHzwb4KwlY9IaGUSyoJ
 6g5wNkdsCbf+q7yhEjGeGJKiW40uNJZKvX3HVhLY35AFHWWwMxymMY6D5aw6lnZtU6bB
 mbkDHJARXNgeA7tXHbSSVy94jhuOcYnIxPtnJE+t8H60TLmPJVgzMmjEXog/2tjdUcGl
 qbRiQ7sRVvbcbSCgRjIiJMPJbuL86uss8lGEWi/pCSkmeDxeII5wnkQRPSjoQeu3uTI2
 B0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tC342W3u8Hf+SqaVj5fo+tJgKTfB85PVplFBVKEhgfk=;
 b=VoU4RJJ0BMFytFkYIA3wGCm65IOaJBDQjmg4d3msPI1gBd52RyEU3mZkHXoW5kLYuW
 OOssNS5fw6eEF7MxYOhX6HN72TgPVzSs6VLVNMmLb+35lalJe6BgZovGAg+YMTJ0oevp
 EpdidNO6wgN/hxKWNPKhzT6hS1Vjm4ZL26OkOHL+C63UFZzzu74pd38IaF+EFubcb/Y0
 7Q7wGL47AP7CrkemkY5LoN00WOpK/Nyu+3cDBoeTvO910N7rAYh+gLS+pBbaoW3Prkea
 ApNL/TKjKXushlw/H2OfGfRQSCj33kCuu2WPKn5kZrw3mjd9KIvk0IXo+QqsunnatfYy
 vyUg==
X-Gm-Message-State: AOAM531R5PImzexxYAQJg9XYXD5dxjLZWoOR1qW8uFHTkK2QIe1bdO3n
 VE4Hi7gOvJDOm9VAMA8t0Lp26Q==
X-Google-Smtp-Source: ABdhPJyiKIErfvwX38VxRwa2gYfX8d8nKodxQ0Lf7MjsImkQoMJBXV8DtBqIHTuuzHW/I9FrZaJZBg==
X-Received: by 2002:adf:d84a:: with SMTP id k10mr3715244wrl.336.1592323328416; 
 Tue, 16 Jun 2020 09:02:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t189sm4742455wma.4.2020.06.16.09.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:02:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 419271FF7E;
 Tue, 16 Jun 2020 17:02:06 +0100 (BST)
References: <20200612014606.147691-1-jkz@google.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Josh Kunz <jkz@google.com>
Subject: Re: [PATCH 0/5] linux-user: Support extended clone(CLONE_VM)
In-reply-to: <20200612014606.147691-1-jkz@google.com>
Date: Tue, 16 Jun 2020 17:02:06 +0100
Message-ID: <87k107yp6p.fsf@linaro.org>
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

Not for me - which probably means you don't have docker/podman setup or
cross compilers for all the various guests we have. See
tests/tcg/configure.sh

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
>     interaction between QOM<->linux-user. My naive implementation based
>     on the current implementation `exit(2)` was regularly crashing. If
>     maintainers have suggestions for better ways to handle exit_group,
>     they would be greatly appreciated.=20
>   * execve does not clean up the CPUs of clone'd children, for the same
>     reasons as `exit_group`.

Apart from "a more perfect emulation" is there a particular use case
served by the extra functionality? AIUI up until this point we've
basically supported glibc's use of clone() which has generally been
enough. I'm assuming you've come across stuff that needs this more fine
grained support?

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

