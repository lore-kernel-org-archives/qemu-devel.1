Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00968C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45FB20704
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjgpCiPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45FB20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddZ0-0005il-TL
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jddXe-0004Mn-Mc
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:39:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jddXa-0006Ui-MA
 for qemu-devel@nongnu.org; Tue, 26 May 2020 13:39:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id c3so16995309wru.12
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3hfD3ml7lk6m4OdRbIJyvHpcUBE7nj0l2MA3rhHfEF8=;
 b=WjgpCiPxiZvziRAtxDY8oHafCj63QdrcEz0Bmej+CacJaDEBqnlT6lIsBa0Mmr9vGB
 EPNR9M1k35FRp1mvFR+q8NKn4csW8hZqnJwaF8RYVr3NJOoBbdq/NSLHhbact18bBKj0
 0xCMNjIANelPBYolbaI4n2cwt5oW8cIAAEGzFg2/W33kd9TQxenferNyd9qJWIAHKdF2
 JDM01QhGcAecC3DyYvO9DjssHRiKw/4RgtBGiJ6ikgsx/FQ36c4rJMHAUvtPcRlTMBEE
 nlBRSoiy3oTuENx9+yHbRm9AEy3GgOl/5aN7IHMcfdy0g23b9oA8ujWbz8I8lTxS/yv8
 HFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3hfD3ml7lk6m4OdRbIJyvHpcUBE7nj0l2MA3rhHfEF8=;
 b=GyptuX0M/qwNIuORhkzhd/ibtA8qVUvXH82ELe8mcOzt/e237C2QY9zyyPZo6B/J+/
 z+/TSlnTs1KiIRlX+RL/Kd06CfkpWjcyNoMCG6coRASj0sFWZB+6u++PLsXCvWNVajtp
 CsCSB/H2ExnoyjIqg4ZJnq81SII1/eUzuAfk8ub/X+ONBMHqxfHX7b7aaGZc5ZDFwV43
 zLOv6c37P4tREtjI4ELQU3NAgSmi+EJ1aX9di6Elb+hIZz6A1gofgF1h7l8QBCKyVmT6
 26g04+0EQbxJsgrX3sOmOztPy77kug4Si3bKlsdClEZOqlRoE6/Zh/BeC4aTuw+H6O3C
 hLxA==
X-Gm-Message-State: AOAM5316qrQMV5r3ShX2SMOQTRG/V+bG31XXUVA11cqJpuGRAF1iVl1o
 +OraL9exChdPfdMndOHDfqi8EjqDGUaxHqBm7PE=
X-Google-Smtp-Source: ABdhPJyP+nfa3EQCLgCxncuAZ+LLH22AQLwwFLEaTT9aouGS4SyvXTp6l9WrCq9v84fN9flfjH1AQhD4SLKNoIjUpuc=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr14199068wrq.420.1590514740886; 
 Tue, 26 May 2020 10:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
 <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
 <4e78400c-42be-08c6-492d-dc5596551efd@linaro.org>
 <CAHiYmc6zKmxgyKHzT4gazvJvPsX3SQYLjSXwK50_2eURkR3_NA@mail.gmail.com>
 <CAHiYmc7z+OfvE7nN1j14n2O8seVtqem_hsBwq=WyFgeo=WfybA@mail.gmail.com>
 <CALTWKrXv6NQUEzKFvPN4TmDGCKxY-Zaa+Dt-z0+sTgndco+EMA@mail.gmail.com>
 <CAHiYmc6289cQZEptA=KjpMDLx3S94Au7W79DXH9KTM-MLi3ADA@mail.gmail.com>
 <CAHiYmc7r0GBLytokN=cyonrQAC6S8J=SpPf9KroPgG+ACJPV5Q@mail.gmail.com>
In-Reply-To: <CAHiYmc7r0GBLytokN=cyonrQAC6S8J=SpPf9KroPgG+ACJPV5Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 19:38:47 +0200
Message-ID: <CAHiYmc70D2xo4m9zx16EbVH+om+04cqJz3O+Wa9pq7S=6LF-3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >
> > I think your last sentence in the bug report is not entirely correct.
> > It is not known what would be performance results in case of
> > correcting mmap.c. So, if possible, and unless Richard or someone else
> > disagrees, please change that last sentence to: "By doing so, a better
> > performance results could be achieved, compared to the case of the
> > workaround described above."
> >
> > Also, please add the tag "linux-user".
> >

Ahmed, since rx target supports system only mode at the moment, they
must include page crossing check in use_goto_tb(), which is missing
right now. So, since the rx bug is of a little bit of different
nature, please file another bug for rx target only - they have the bug
in system mode too, as opposed to other targets. Their fix should and
could be applied independently on any user-mode modifications for any
other target.

Sincerely,
Aleksandar

