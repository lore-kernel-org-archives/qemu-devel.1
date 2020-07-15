Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71766C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1BA20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWG5jb8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1BA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvgwB-0003H3-Hu
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvgvK-00021z-Ew
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:54:10 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:33755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvgvI-0000zd-I7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:54:10 -0400
Received: by mail-ot1-x332.google.com with SMTP id h13so1368492otr.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cNmibun/DPdpRp3+UquHlIHQCbN3a4o1VFtgIr1HRzM=;
 b=yWG5jb8qZQrtV3xdcJkaSZef1FdBmqWRug058v3rntlThgAO5cnJZ4UnMRqAJKyk5P
 K8n1XFwrrTEkjPWneACabcYjKfYGbUQBpVZngCvkWLvzIKHK/st29BrugnFI6yEQxiCr
 H+RqEGyoH4f/PWrfP4HsocSDlTGKlTZOp3lawFK+kMuPkms8n/fKFcxbaCwTyd8rWONj
 rLSLulFVDcFtK9mPURV+1VAdL06q5i5ywO8mrdgMQM4CxDMKfV62E6AO0Zp0LfwAohpD
 fb0xb6tdEbHttv1JNuN8v4LIXcO+Rm1hI7lVX/G5CS8hHmEZQaZXUxqYjJ0Y6kv2YVNR
 PThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cNmibun/DPdpRp3+UquHlIHQCbN3a4o1VFtgIr1HRzM=;
 b=pwCY4eZwGBWGdzfnLg/iA6HGoAubV9ydPRVZcaezTI+CQVHn/Qjgja8wqsbv331qVH
 IMos1vYga+BjS2wULlHDGvhGRsN4rKRCC37UoxBVYOv7iOj4xjOnzvXc7UvA7nP6gY+W
 mnjdITnUmLCZ9Tun7Nxae6Kgbz2T4FdutBjDmGdePnLpqd3Z7Lq+zh6U0YY0EzXyc/Ba
 xLZFAZ/tD5ltLZ2Iq2YZtDnn+KIbrUM9n+BE9BHisLnp1WcLzs3sr0bpxLDKNCcDKqIm
 qn+AQfhWGS+gY7dFSQoJxYCzc7F2Zp2J+fsHjmPnj597yo0+HqQQ0BgSLCdtr255ZoSw
 k9vQ==
X-Gm-Message-State: AOAM530/o179V3vbxig7DOy/u1j5o1x95bb/3lJ1OMNGLJnlzJATzFme
 xAkeE/8x54OYNh9SW9ugmUy7vCpQKiRDH3rcO13SRQ==
X-Google-Smtp-Source: ABdhPJx2lWUJ9AVEkZ/W+jYZMpa4a6H6Z/pV8gsAgKUB9ODxlARLZQZIw/ud1CKDzOvIJvrZrIesN+zk87LXGE4QTc0=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr8962981oto.135.1594817647108; 
 Wed, 15 Jul 2020 05:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200714222132.10815-1-philmd@redhat.com>
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 13:53:56 +0100
Message-ID: <CAFEAcA99GLUrk1D2ktXryJY1b97qyjcqHpaWE-1ad-f43CXH8w@mail.gmail.com>
Subject: Re: [PULL 00/19] Python patches for 5.1
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 23:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 1a53dfee92284d3016a579ef31d53367e84d9d=
d8:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-07-13' i=
nto staging (2020-07-14 13:52:10 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200714
>
> for you to fetch changes up to 84dcdf0887cdaaba7300442482c99e5064865a2d:
>
>   python/qmp.py: add QMPProtocolError (2020-07-14 22:22:22 +0200)
>
> ----------------------------------------------------------------
> Python patches for 5.1
>
> - Reduce race conditions on QEMUMachine::shutdown()
>
>  1. Remove the "bare except" pattern in the existing shutdown code,
>     which can mask problems and make debugging difficult.
>  2. Ensure that post-shutdown cleanup is always performed, even when
>     graceful termination fails.
>  3. Unify cleanup paths such that no matter how the VM is terminated,
>     the same functions and steps are always taken to reset the object
>     state.
>  4. Rewrite shutdown() such that any error encountered when attempting
>     a graceful shutdown will be raised as an AbnormalShutdown exception.
>     The pythonic idiom is to allow the caller to decide if this is a
>     problem or not.
>
> - Modify part of the python/qemu library to comply with:
>
>   . mypy --strict
>   . pylint
>   . flake8
>
> - Script for the TCG Continuous Benchmarking project that uses
>   callgrind to dissect QEMU execution into three main phases:
>
>   . code generation
>   . JIT execution
>   . helpers execution
>
> CI jobs results:
> . https://cirrus-ci.com/build/5421349961203712
> . https://gitlab.com/philmd/qemu/-/pipelines/166556001
> . https://travis-ci.org/github/philmd/qemu/builds/708102347


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

