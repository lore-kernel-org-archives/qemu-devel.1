Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452EFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1161B215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAnlJ/xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1161B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMmY-0001wq-6v
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMaQ-0001v6-C0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGMaP-0001Om-90
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:21:30 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:35377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGMaP-0001Nk-4r
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:21:29 -0400
Received: by mail-oi1-x233.google.com with SMTP id x3so5589541oig.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DcwveP3ZdXpe9+xrCjhARIjjEd0lobYq0aAbg9PF9rw=;
 b=RAnlJ/xdTw1j6um3+G7lOzXrAKFYfX7wb1xjSM3UFUB3Nt15OSGLYReSMClxXc3/Hd
 cCXunMSTzU12T8tGhG1VxB7xwNCmTfK6wdskkWoq3I6A1eO9BGEXGy16yLAQVwPiyFYk
 Sjt2ZOGH3Zbk3sf07kNYRKu+VqNqGs+rwOYYiUyJuAbrgdfVRQYxlJb5P0JzwpJymkpC
 MSzn+lL2DiTJ/12HNtTZ7moD1NgLW+wZwnXyp49TWTEe09gsuGsO89vNv2S562dRTfkE
 U1JnNRXE0/cPg2N3ImCFlRdH82B4Ca0aZUzunRwTkXBVImbK4BSHBJ4S+LroEHF9w8Hx
 jVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DcwveP3ZdXpe9+xrCjhARIjjEd0lobYq0aAbg9PF9rw=;
 b=CPc+Pp4xZ0F7/OLVChHpkdksK4EolaL+s9DLmz7hhHsO8Vc2V9nqCArwuM+9xvSQDn
 e0GVgVgdRP0MBp8Cs4PcoGtfS/rrC8aORhpI2Fum51ywgJh3iGK5p3MSmHOe+OGu/j4j
 CCCHxeCSBhpdYXySW1dsA086OQmZdq+f8HMCFpEte2LrCJSRvPU/pHC3HrBs//f+8QpH
 O7si+ZFbC7nDJRthXqrs4gpAPy20qHukI7SjZDswP239H2++HIres5y/cE9njIWBZWRK
 3+QCcKKjZ09BlfwEyNjHKu8OZyDASfl4/qkrXhGLqS9ocqPbykYZPX3JOphB3ig/zOBb
 06Ag==
X-Gm-Message-State: APjAAAUiZ9ICZHGst9qaXWG/+066VVcfFJExT3ilbGjLKN/022pWabBV
 9OIp+ri5xMCJTKELhv5Msdti3KrMOuKPhY6wanY2MQ==
X-Google-Smtp-Source: APXvYqwHX/VxjuzrsL8gV0vh3VYilXPhIQG/eOure7Jp9dHO1WkTMTrqdsMCq0oK1LzefrhclEybVnU0l0j2r++KL8Q=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6584000oib.48.1570191687745; 
 Fri, 04 Oct 2019 05:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <1570100407-22549-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1570100407-22549-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 13:21:17 +0100
Message-ID: <CAFEAcA_Wqq2xJ=LLEj8qkOpODpOd=kie1tRosHet=RDxsWsnMQ@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Misc patches for 2010-10-02
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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

On Thu, 3 Oct 2019 at 12:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3=
dc:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-10-01' into staging (2019-10-01 13:13:38 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8cd5aa6899689e6f9f3e72bf43474a436148a341:
>
>   tests/docker: only enable ubsan for test-clang (2019-10-03 12:58:05 +02=
00)
>
> ----------------------------------------------------------------
> * Compilation fix for KVM (Alex)
> * SMM fix (Dmitry)
> * VFIO error reporting (Eric)
> * win32 fixes and workarounds (Marc-Andr=C3=A9)
> * qemu-pr-helper crash bugfix (Maxim)
> * Memory leak fixes (myself)
> * Record-replay deadlock (Pavel)
> * i386 CPUID bits (Sebastian)
> * kconfig tweak (Thomas)
> * Valgrind fix (Thomas)
> * distclean improvement (Thomas)
> * Autoconverge test (Yury)

> Thomas Huth (2):
>       Makefile: Remove generated files when doing 'distclean'

This change breaks the 'build from clean' part of my merge
build tests -- I've followed up to the patch email with the
description of why.

thanks
-- PMM

