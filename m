Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D6BC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184CE2465B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2576xKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184CE2465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irIkk-0003MW-N1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 04:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irIUV-0006gu-E1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irIUU-0006cR-0a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:28:03 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irIUT-0006bv-RT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:28:01 -0500
Received: by mail-ot1-x342.google.com with SMTP id r9so11945169otp.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wpCJ9YS9yc+LZvuLAbXxF0LDX++c3pfGXGupXimEcY=;
 b=T2576xKwARsjr4Ordlovn2lJ6+kZMxNSSXli2gcnkWibp83KEvkE09CM/WiCMMws4R
 PP5Dorecv5ifojQuw/sTHXK0krOE19j5BbJGskxz/YpiYxGCqNlHtH14YiWOaL8olcwR
 2b2xF6sBOQCldUWlM0ntGgKAljhvQPPBDAH+4VhZ/Jc4XVQML3mGljH8W8pKWgRGeL9D
 tamyF96wppb/HVBFnEg5uYWfswwCRv2EoDwCD2kZ/3zisdtsdNOLJeAJn4LOX/SqP5Bx
 5hVQM+Ux1/LJcvuMQBvf2NBsMaGHgjVNOBZ5n+n6ympWmv33gjAyN+fTfMC59hzRDj24
 vQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wpCJ9YS9yc+LZvuLAbXxF0LDX++c3pfGXGupXimEcY=;
 b=dSH9ViF2oW0ulH0ghgMQPrnPWzZ8wLegEliwkATdR6y+Pj8vJqg+GjgeCf90p1reQ9
 6iF56kUUE4pEmoFPBeVZy0GfXXedcZzZXOhxFzxu3lnv3dnoF0atuOVeqPOaRVOs7VYv
 X1rVe2YCu5X/PTBgTpbrD5+3s48m+S2OMNAjfd8YeHRfQVy7a6FFWIhp/q4t1ly+8UpM
 SCxgJT8dgiZsJ/jZHruXoLfdSt6QJ0GFcDne22A7Yqk5Mpj4YQNaTdPQhReEvWSMozdQ
 dy22w4gBHxyrwn+ztjfgQ/JbAKdV05RHZPOPEl+3KHAuRX1g0Xa9+qcAJLfYgKBGVxzV
 YUkg==
X-Gm-Message-State: APjAAAWaoGGRWMeRZI2qMT/yrj3yE9ut3vtxrxBw0i8FSaVpAbRyYgUJ
 5pmAwSPqjR+WQOtWAfTdq37ltePy433ANtiL6PLOcA==
X-Google-Smtp-Source: APXvYqyQN87bQ2hJ1djdfFH4st2/zzAFa5o/Lk6TdGsxmLqk4IB9L7o2akKijdL/eezL/UceEHh9m01+sWbcXP9QCfk=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr15089065otq.97.1578994078719; 
 Tue, 14 Jan 2020 01:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20200108042338.9082-1-richard.henderson@linaro.org>
 <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
 <100c3aab-a198-f1fd-6ae2-7671c3039d8d@linaro.org>
In-Reply-To: <100c3aab-a198-f1fd-6ae2-7671c3039d8d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 09:27:47 +0000
Message-ID: <CAFEAcA9dKPYASj+q52rYaziV9tT+KaMPsLZW-rrxsj0dyHppDQ@mail.gmail.com>
Subject: Re: [PULL 0/3] capstone update
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Mon, 13 Jan 2020 at 19:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/10/20 6:07 AM, Peter Maydell wrote:
> > On Wed, 8 Jan 2020 at 04:23, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:
> >>
> >>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/rth7680/qemu.git tags/pull-cap-20200108
> >>
> >> for you to fetch changes up to 7cc3836eac04a3e358b2496fbca704b3ee5197ae:
> >>
> >>   capstone: Add skipdata hook for s390x (2020-01-08 14:53:54 +1100)
> >>
> >> ----------------------------------------------------------------
> >> Update capstone to next
> >>
> >> ----------------------------------------------------------------
> >> Richard Henderson (3):
> >>       capstone: Update to next
> >>       capstone: Enable disassembly for s390x
> >>       capstone: Add skipdata hook for s390x
> >
> > Build failures:
> >
> >   CC      aarch64-linux-user/disas.o
> > In file included from
> > /home/ubuntu/qemu/capstone/include/capstone/capstone.h:302:0,
> >                  from /home/ubuntu/qemu/include/disas/capstone.h:6,
> >                  from /home/ubuntu/qemu/disas.c:9:
> > /home/ubuntu/qemu/capstone/include/capstone/riscv.h:16:10: fatal
> > error: capstone/platform.h: No such file or directory
> >  #include "capstone/platform.h"
> >           ^~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> >
> > (same on most hosts)
>
> This comes from not re-running configure, which changes the CFLAGS for the
> build of capstone from git.  Given that the source tree for capstone got
> rearranged between 3.x and 4.0, I don't see how I can avoid this.

Hmm, shouldn't the update to 'configure' in this merge cause Make
to rerun configure, though ?

thanks
-- PMM

