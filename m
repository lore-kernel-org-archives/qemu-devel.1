Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6239C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 00:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708942065C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 00:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+55B2Eo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708942065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhjFg-0002u0-M1
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 20:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jhjF0-0002Ul-Ri
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 20:32:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jhjEz-0007h9-Tg
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 20:32:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c71so11897608wmd.5
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pIMp/wD1dZ3Y4BpT5Tc0jS52N1iDYA+vxjf4Xjfs1M4=;
 b=t+55B2Eo+fblsYSxREX2joXk99xF197xzSJPkyVnFdlAmuWly81sc6ASNt1eH+KsxS
 NyyqeekOymzJE6sCcnM5HRhtlVJd5XH6ADrldZ4o1bFidmdrSYPRX1OOLlCrR9KDFIHt
 0nGGaniCqeSIDBOX0CbFZO0BhmzSRO2soLsomG0EjeHeTaZ0yrx9JwuZxMDMmg++W3qA
 myEtT3Azr13tO1aXoJunZZMrUjjIUddQrPnnh209nOEGClnR8YO818dcoieCTQSWQR3D
 6Fnu/6AHQFRCN4bAV+aZpDYBJBhDMaMMuD+ALrg+fg6e/6fzIndpeXuGtf2wptCAJ0Y+
 xQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pIMp/wD1dZ3Y4BpT5Tc0jS52N1iDYA+vxjf4Xjfs1M4=;
 b=LGo7zC/8HYeCCxvegHHO0zN2YI93VDEz9K2HeMQhxh8FyiOGqyDAs9FtNh1VrkxwB0
 koDk/6yHbzn/iZnmFfhypOARal3Gq/WSSQoIHaI9UvzWDZrKyfY1Qg2zoxhxdsqDOs3A
 UQ9MtOj40/LflPE9gjGpatAFzJ3oCZ24U00pEeuwg8RcdMZrdaNSg+Y5DXMiaGC0yEgb
 D+sbjWJ3KEcPqKnW26KeS0RUSW0NfLBy9jSK/jzKshaONZ53ypFwxVBymp1+hLung/xM
 tSEGa/o94ypiMI/NTmqKZ2s0CP6bAIfnKTmxiDC2psMBKzle2xsj27UgaH6bxqeWXPp5
 o8sw==
X-Gm-Message-State: AOAM531SAoN18EpozlKtnOvniL9CvHR3lqNn3xgHOsFyKcFxDO6q/C8/
 JvRT22DnnbjHeLbD48/LMKNmd6eFfth5CVeaYo0=
X-Google-Smtp-Source: ABdhPJz9YFCB9uMom0L1rWGcN2IQccR4BuHMKnyJOA/H2NC1+troZYUeBZhLubhk7j5GbaD7K2ipggnbt6EP573xiyU=
X-Received: by 2002:a7b:c3c6:: with SMTP id t6mr9092262wmj.159.1591489963876; 
 Sat, 06 Jun 2020 17:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200606131517.1250346-1-laurent@vivier.eu>
 <d76cc8d8-98c3-fee4-4b10-b271bd6bb37e@vivier.eu>
In-Reply-To: <d76cc8d8-98c3-fee4-4b10-b271bd6bb37e@vivier.eu>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 7 Jun 2020 02:32:31 +0200
Message-ID: <CAHiYmc4JJwK=Ax6VsGpzpxxAjqZrjNS8n0_qQybPYCQmJ02EsA@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Linux user for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

=D1=81=D1=83=D0=B1, 6. =D1=98=D1=83=D0=BD 2020. =D1=83 15:24 Laurent Vivier=
 <laurent@vivier.eu> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Le 06/06/2020 =C3=A0 15:14, Laurent Vivier a =C3=A9crit :
> > The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac6=
3510:
> >
> >   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' =
into s=3D
> > taging (2020-05-26 14:05:53 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/vivier/qemu.git tags/linux-user-for-5.1-pull-request
> >
> > for you to fetch changes up to 95722b27845b972250a7d4f93b693b01e2a0c3a1=
:
> >
> >   stubs: Restrict ui/win32-kbd-hook to system-mode (2020-06-05 21:23:22=
 +0200)
> >
> > ----------------------------------------------------------------
> > linux-user pull request 20200605-v2
> >
> > Implement F_OFD_ fcntl() command, /proc/cpuinfo for hppa
> > Fix socket(), prnctl() error codes, underflow in target_mremap,
> >     epoll_create() strace, oldumount for alpha
> > User-mode build dependencies improvement
> >
> > ----------------------------------------------------------------
> >
> > Andreas Schwab (1):
> >   linux-user: implement OFD locks
> >
> > Helge Deller (2):
> >   linux-user: return target error codes for socket() and prctl()
> >   linux-user: Add support for /proc/cpuinfo on hppa platform
> >
> > Jonathan Marler (1):
> >   linux-user/mmap.c: fix integer underflow in target_mremap
> >
> > Laurent Vivier (1):
> >   linux-user, alpha: fix oldumount syscall
> >
> > Philippe Mathieu-Daud=3DC3=3DA9 (13):
> >   Makefile: Only build virtiofsd if system-mode is enabled
> >   configure: Avoid building TCG when not needed
> >   tests/Makefile: Only display TCG-related tests when TCG is available
> >   tests/Makefile: Restrict some softmmu-only tests
> >   util/Makefile: Reduce the user-mode object list
> >   stubs/Makefile: Reduce the user-mode object list
> >   target/riscv/cpu: Restrict CPU migration to system-mode
> >   exec: Assert CPU migration is not used on user-only build
> >   arch_init: Remove unused 'qapi-commands-misc.h' include
> >   target/i386: Restrict CpuClass::get_crash_info() to system-mode
> >   target/s390x: Restrict CpuClass::get_crash_info() to system-mode
> >   hw/core: Restrict CpuClass::get_crash_info() to system-mode
> >   stubs: Restrict ui/win32-kbd-hook to system-mode
> >
> > Sergei Trofimovich (1):
> >   linux-user/strace.list: fix epoll_create{,1} -strace output
> >
> >  Makefile                   |  2 +-
> >  arch_init.c                |  1 -
> >  configure                  |  4 +++
> >  exec.c                     |  4 ++-
> >  hw/core/cpu.c              |  2 ++
> >  include/hw/core/cpu.h      |  7 ++++-
> >  linux-user/generic/fcntl.h |  4 +++
> >  linux-user/mmap.c          |  2 +-
> >  linux-user/strace.list     |  4 +--
> >  linux-user/syscall.c       | 33 +++++++++++++++++----
> >  stubs/Makefile.objs        | 52 +++++++++++++++++++--------------
> >  target/i386/cpu.c          |  6 +++-
> >  target/riscv/cpu.c         |  6 ++--
> >  target/s390x/cpu.c         | 12 ++++----
> >  tests/Makefile.include     | 18 ++++++------
> >  util/Makefile.objs         | 59 ++++++++++++++++++++++++--------------
> >  16 files changed, 143 insertions(+), 73 deletions(-)
> >
> > --=3D20
> > 2.26.2
> >
>
> It has failed again on the PATCH 4/19. I think there is a problem with
> one of the cc. I re-sent the series again and it has worked this time.
>

A similar problem happened to me once. I was getting a list of cc
addresses via get_maintainers.pl, and copying and pasting the
output in terminal. The problem of incomplete git send-email. in
my case, did not stop until I manually entered all email addresses
rather than copy/paste them. Still do not know what was the root
cause.

Aleksandar

> Thanks,
> Laurent
>

