Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BADA20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQdJUx4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BADA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyilT-0003p8-FA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 17:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jyikl-0003PV-0k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:27:47 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jyikj-00019X-KW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:27:46 -0400
Received: by mail-pj1-x1044.google.com with SMTP id o22so3829247pjw.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cJSfMjcdL4YC0QAlYwqkZ+BEIdMEGFsMMQYba3V3F00=;
 b=WQdJUx4JrrsOjI0sdV2d/8GWXHhF71FRi+L0pn77pBRzw4bova1FYAxb5AoNLKY3Cx
 tcf+t/YzS4ty0jnV+SA+6l8hyvRpFFzQqcATj7/oleRC37sJHWH635KxVG9iDE8aUh5H
 ktz3U+CNCYobVRlVm+GxSFMAAndoqOqANhI7hdvL3gqYJKnsWJhefzGtdbURF3H3CAI3
 5mA2exy4dZqhBeOo+tDJOqQ3Dgc1GuezpACIP2rzuesU4IpjBFQyPiOQy3DMfyyA3Vxu
 qQyVZHe40NAOmzu6CX3ErGB6BpyHj68gZUeiooUdqD+uITIpWc5ugRz+ggqwOgQ+TzD6
 JLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cJSfMjcdL4YC0QAlYwqkZ+BEIdMEGFsMMQYba3V3F00=;
 b=ok3pTLgX0uJ6LS3VFtntE3hhLPId88EsEQ1Gl4aoWGBFUT/Fa0FPjGxYtTIZHcVEt9
 LnWN/HynI2d1TrUuKRKaxfwRrQBTa5exjLHq+VB5lSpxVmdoLIi2g4lhzHt7HVZ2Vyo7
 1Vhxhhg7u57TaZDO4Cp0xVkKCw52IFVg0lELSz3pDP9+KvqsvuVO6/1H0ENDolmXH7dE
 wtgStbqQOFMcK9zF1S7CXll6hvqiP3L6pLu3dmi70+taVVTaUapHvqbsko9mg44B5YFz
 6qb6hkkomHPFtuVcBaNx6M9DUFT0O4AKnHo0JaSQP8AQYE4SoBkoFC8u1XKHoKAom4ff
 XSzw==
X-Gm-Message-State: AOAM530SUy+FE01Pu1Pvtgv/UiR/JouaGJCV3WLwyiC/ikuR/v7901dL
 06xc+XOpSgy94C3y8s0+OSsdAGNG9fFBbYTGOWA=
X-Google-Smtp-Source: ABdhPJx5+azedPpGw2ERLGCM3Tx4UkAJiBVSBkPa3KATo615ae5wFMxfA2PIJI5hMQEANup+cQtv7T/RZYH4JcDeiG4=
X-Received: by 2002:a17:90b:1045:: with SMTP id
 gq5mr2263527pjb.30.1595539664165; 
 Thu, 23 Jul 2020 14:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
 <20200723210233.349690-3-Filip.Bozuta@syrmia.com>
 <CAMo8Bf+O8ggdKuxhwQ_GyBwDyPAwBB=v=kD1Dnq=VWW-SvHJEg@mail.gmail.com>
In-Reply-To: <CAMo8Bf+O8ggdKuxhwQ_GyBwDyPAwBB=v=kD1Dnq=VWW-SvHJEg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 23 Jul 2020 14:27:32 -0700
Message-ID: <CAMo8Bf+MEeTGuh5KfTBa97Xc11FfNAcYz5L9GGrKDtfopZQc0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] linux-user: Add missing termbits types and values
 definitions
To: Filip Bozuta <Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 2:25 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 2:04 PM Filip Bozuta <Filip.Bozuta@syrmia.com> wrote:
> >
> > This patch introduces missing target types ('target_flag_t', 'target_cc_t',
> > 'target_speed_t') in a few 'termibts.h' header files. Also, two missing
> > values ('TARGET_IUTF8' and 'TARGET_EXTPROC') were also added. These values
> > were also added in file 'syscall.c' in bitmask tables 'iflag_tbl[]' and
> > 'lflag_tbl[]' which are used to convert values of 'struct termios' between
> > target and host.
> >
> > Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> > ---
> >  linux-user/alpha/termbits.h   |  1 +
> >  linux-user/cris/termbits.h    | 18 ++++++++----
> >  linux-user/hppa/termbits.h    | 17 +++++++----
> >  linux-user/mips/termbits.h    | 17 +++++++----
> >  linux-user/ppc/termbits.h     | 21 ++++++++------
> >  linux-user/sh4/termbits.h     | 19 +++++++++----
> >  linux-user/sparc/termbits.h   | 18 ++++++++----
> >  linux-user/sparc64/termbits.h | 18 ++++++++----
> >  linux-user/syscall.c          | 34 +++++++++++-----------
> >  linux-user/xtensa/termbits.h  | 53 ++++++++++++++++++-----------------
> >  10 files changed, 130 insertions(+), 86 deletions(-)
>
> Curious why you did it to some targets, but not to others?
> E.g. the following headers have similar definitions:
> linux-user/aarch64/termbits.h
> linux-user/arm/termbits.h
> linux-user/i386/termbits.h
> linux-user/m68k/termbits.h
> linux-user/microblaze/termbits.h
> linux-user/nios2/termbits.h
> linux-user/riscv/termbits.h
> linux-user/s390x/termbits.h
> linux-user/tilegx/termbits.h

Never mind, I got this email before the other that adds generic headers...

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

