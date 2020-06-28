Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC18EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975F420720
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBRqSDbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975F420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpXHX-00034e-Qn
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 09:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpXH0-0002em-1L
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 09:23:06 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpXGx-0005Ii-VN
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 09:23:05 -0400
Received: by mail-ot1-x333.google.com with SMTP id k15so13019612otp.8
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 06:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KJ4cpHr5TEBEGz2W2cvl2SHXBWIAsxR/baeqZKqtwvU=;
 b=TBRqSDbv23gzxjvrfWM2R2cKSbAR+rik956s8FuolR111E5riIvbi9VTAL1rHqDllt
 Vzc0Yc9TZ3hEt4NnY5TOhFkMj7SGWTlFdNhqTCUCgPFbnCLgW7SFYui2tT3t/Gd/UMJ4
 oONYGshkEPgIfD7FCS2nt3n6HRukkROfiH6RK6jM5AZsBfI7gj31G0tBgyzBp5R6ck5z
 UMyXUCqUqHgAaOeEwOxi/txP84C6EqLq7vti8QKGLBYj5ugU4wZfDabcx6pq8K+qXZms
 w05INtx309T81tlM5dUlt3gw0HNgY2QFpX8A49yReFZwYHrZlrsC4WwPpQAV67aSQuPQ
 Phbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KJ4cpHr5TEBEGz2W2cvl2SHXBWIAsxR/baeqZKqtwvU=;
 b=RfjLP//ZGOHrriI09VlIiy5oyYlLNZLgEKMCu5IM6gEAvV0mq9G7YpTfdQHFCTKGM1
 hfpe9Rdr+I9EpK/fLK0BMm46TVsXj2UVgeDim+i0bcUMRQWSpUBj7X5ZZ1Rph+nxIL5v
 +rrZkwsWWvn14Z7WMqB3i7VHTfNMw+LwiSayINclCwU0sTQh8e3mwfHxLRHuNpFZ8/JM
 Vdk04oNWmHY6KzvTYA02PDRiqzX8cZkHVTnJDVI/YD8y8WKx2JP2SlxzbZlb2wh7H2sQ
 vTRIPTpjX4mm94jTmH6A36u6pcHpMT+gNRQEHYFNZhEA8xAaKs9vlbrCpRuIJ1w7Lk43
 mRpA==
X-Gm-Message-State: AOAM532sI33L9ai7e4KCRWdamFcAsH2QrGPOpESqif1fAkPqPenrIIH9
 4geI/f2gSKVCe/MdaWOFXDNDAp4UJF/f0uGlllBvdA==
X-Google-Smtp-Source: ABdhPJxicnpifOLPzeE/mZpZM8yo6T+aMVc/V9RqukzNlsC6IkLbijWeI7j7LiwSF6FRaBslNfjVSRqN4x+61uIVBho=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr1841083ood.69.1593350582414; 
 Sun, 28 Jun 2020 06:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <5EF7B7DB.6040305@mindspring.com>
In-Reply-To: <5EF7B7DB.6040305@mindspring.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jun 2020 14:22:51 +0100
Message-ID: <CAFEAcA8RB5PdafUSM0hH0paw7MFTv-RJ1-Z6SdJWNsC7hvyToQ@mail.gmail.com>
Subject: Re: Building in Solaris 11.4
To: Michele Denber <denber@mindspring.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sat, 27 Jun 2020 at 23:05, Michele Denber <denber@mindspring.com> wrote:
>
> Well I removed the "static" from the line
>
> static int openpty(int *amaster, int *aslave, char *name,
>                    struct termios *termp, struct winsize *winp)
>
> in util/qemu-openpty.c.  I odn't know if that was the right thing to do but it did allow it to compile.

No, that doesn't sound right. The code in qemu-openpty.c
for Solaris assumes that solaris does not provide
openpty(), and so it provides its own implementation.
This is a very old bit of portability-workaround. It
sounds like at least some Solaris versions do provide
a system openpty() in termios.h (in libc, or perhaps
needing an extra -lsomething?), in which case we want
to detect that and use it (not compiling the QEMU
code for solaris-without-openpty).

The first thing to do here would be to find out which
versions of Solaris provide openpty(), and which header
and library need to be used to compile code that uses it.
The gnulib docs think it is missing on Solaris 11.3:
do we care about supporting that as a host OS?
https://www.gnu.org/software/gnulib/manual/html_node/openpty.html

Then you'd need to improve configure so that it looked for
"does the system provide openpty() via termios.h" and defined
CONFIG_OPENPTY_IN_TERMIOS to indicate that; then if that is
set we qemu-openpty.c can make solaris use the "system has
openpty()" codepath rather than "system doesn't have that".
If it turns out that all Solaris versions new enough that we
might care about them do have openpty() we could also delete
the handling code for systems that don't.

> CC      monitor/trace.o
> util/drm.c: In function 'qemu_drm_rendernode_open':
> util/drm.c:41:16: error: 'struct dirent' has no member named 'd_type'; did you mean 'd_name'?
>          if (e->d_type != DT_CHR) {
>                 ^~~~~~
>                 d_name
> util/drm.c:41:26: error: 'DT_CHR' undeclared (first use in this function); did you mean 'TH_CWR'?
>          if (e->d_type != DT_CHR) {
>                           ^~~~~~
>                           TH_CWR
> util/drm.c:41:26: note: each undeclared identifier is reported only once for each function it appears in
> gmake: *** [/export/home/denber/qemu-5.0.0/rules.mak:69: util/drm.o] Error 1
>
> This looks like more "not in Solaris" POSIX stuff.

Ah, the Haiku folks just ran into exactly this issue.
Their fix should also be good for Solaris:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08800.html
(This whole file is for using a Linux-specific feature so there's
no point even compiling it for other OSes.)

thanks
-- PMM

