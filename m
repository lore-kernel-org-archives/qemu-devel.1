Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DF9C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE97221D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9WVCgLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE97221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0qV-0002as-OO
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jC0pv-0002CM-N1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jC0pu-0002cw-DS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:51:47 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jC0pu-0002bH-5Z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:51:46 -0400
Received: by mail-lj1-x241.google.com with SMTP id 19so2171945ljj.7
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RxrCgcDeyx+cZbNt4wk7y7I+wi0StNegNeKf6H/f5UA=;
 b=P9WVCgLr9979tY0pk3JZEdG4k5BUPxT4aIPs3H5tcu/k+GjHbR74CbfXGZxmaZYa/V
 a1rjzoumNJrvblii2y/VI7o5uAqBmFCBFjvSYoCRP6GvK24d/qx/yW6b7TP/nmejGhzS
 cGFD2D8dcd/5yugmcxbcZpMFAikAmroXIGsX1VbNs4mmoqhDnPW/fwAiYgE0jq0g3rOD
 A/Sbk9cAtZIqCLrhTx/KjDDYJZvWp4kJTb38T4Z+/rQA9kvfWKNbHDuZYEcVAFToaJgf
 8kAhjiVBosvFsW72F8F9LbRTCFsTtrExRs6w4xMum8LX7pNwqVGRWDbPwFqUh2vtQTYD
 14cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RxrCgcDeyx+cZbNt4wk7y7I+wi0StNegNeKf6H/f5UA=;
 b=OmFJ7q5UnT0zmjSjeTvP7ajh2bfeCx1q09XqOQP+a2ch25JUrsLGaLR5BPIhJjwLTt
 UFACYHUdSa/Df9+jnYtL7KxRvVfyf4tIpTjX7jqmiJro09cACA9JQck1GPDKsIEr9nkQ
 IfY4O2vzyrdIv7t8eLnOXNvHLhLCDV59S4gwCDSrSp3rcIv+7GBre46W36XxPwTXio5a
 LnBYXcE42//2aufvITqnZpi+QUtRBzaf12a97vR/PbV9uiSDm8iZMx7hidXg7+amy3yj
 /t+yQAcy07SB/HeE7GVU1a09m9WxdJxJMPJmDY/Sey+qN+cc5tmxzGSDZC2HZxpP3/XG
 D7vA==
X-Gm-Message-State: ANhLgQ3zJ/loITfEpOAjdNvOdOTk3jvB+jWlicihSprjR2LP/+X1YLzW
 RnK7RmYvkGsH/qjdVaxg7ItzPUPHK/VSQoLCgNoH1g==
X-Google-Smtp-Source: ADFU+vsKS9ufYQUZz38NwYOpIrIARAlu/yrlvZhd4aCySjNDJM2ohp+qAaurRJm7gSgzazycvCwp4P+drPDaecSJc8w=
X-Received: by 2002:a2e:3812:: with SMTP id f18mr2047524lja.129.1583931104361; 
 Wed, 11 Mar 2020 05:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200310182536.11137-1-robert.foley@linaro.org>
 <87pndjgksk.fsf@linaro.org>
In-Reply-To: <87pndjgksk.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 11 Mar 2020 08:51:08 -0400
Message-ID: <CAEyhzFvcqbmSPkW0Z076vdxSrj8ntC0W4dXgJjLbbwWUUOLJfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] tests/vm: Add support for aarch64 VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 08:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This is version 3 of the patch series to
> > add support for aarch64 VMs in the vm-build infrastructure.
> >  - Ubuntu 18.04 aarch64 VM
> >  - CentOS 8 aarch64 VM
> >
> > V2:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05310.html
>
> Hmm weird - it's broken check-acceptance for me:
>
> JOB LOG    : /home/alex/avocado/job-results/job-2020-03-11T12.03-8250144/=
job.log
>  (01/29) ./tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x=
86_64_pc: ERROR: 'ConsoleSocket' object has no attribute 'makefile' (0.35 s=
)
>

Nice catch.  Looks like our new ConsoleSocket object needs at least
one more method on it.
Will take a look at it.

Thanks & Regards,
-Rob
> --
> Alex Benn=C3=A9e

