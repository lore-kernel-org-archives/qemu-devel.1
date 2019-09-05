Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AAAC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDA621743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHxwmiua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDA621743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5onv-0000Al-R2
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5omo-00087D-LP
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5omn-0003nJ-Dx
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:14:42 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5omn-0003mw-8A
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:14:41 -0400
Received: by mail-oi1-x244.google.com with SMTP id x7so1307497oie.13
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3mY2eSeYGc8iuD3+IGNUaAdB3k9W1JHcf3TWBghyQh4=;
 b=XHxwmiuaub4mRHLXdFQLIrihmxQdY1X6TU5vIh1//ayjz8X9ck8drwpD78MrLl72tp
 f14lQE475M0ArWK7ClQX5L0E18ilJ5VhnV2/fXSLXZ9KhQGJPGOvO8MFi2eKxowO5NAI
 0H8EbK96xZoR6x+Zxf1lRrms+WyNGRp+MrxztFxmLsROOasIxcMUrTdaGwLMiKfNBnSN
 UdM41mBMx7EljTAajQ0ykbY1Vf0SMRkwGyHtHERe2aDeMhgi0mn8IPQckAbqCwPwA5RL
 7lr8FCmtJ9P1EYmVA2DHuiM896GCnL7WCsZ6Pm6q95H5Hc5HHCnMiUJ+mEAjcP4KgmCd
 hjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3mY2eSeYGc8iuD3+IGNUaAdB3k9W1JHcf3TWBghyQh4=;
 b=esjQVF9GDCKyAisUa7KZ54yc8k0z4/3biFCYnlmAmxBjUFIlC3n7kMzCZt8SsGyCLd
 o5Fu1j4ySfF7JGxf35qWWlbUHuRBCiJlMR/xF/GHFZO6VP6oJoUeNakzpuKWfRPYd+pe
 jWb4cvLTx4zao/Tdp0l92BcQHOPaFhml2/ob3iWqovLhLKKo0WJdhgwfStfD0Ddm3K+X
 whFg2uJ5caKbpKxYC8ZlXGVBgX48QpoHO9sPCcFBWKJsxyoviK6EhiSrsmsXIPOOdeS/
 q0TqjeKKaD0Go+s0eCpzdqZGKK83RGVvVKUHJ4CaEF73DWvdvVrrFpAxlxv0MrXoBojX
 UNIQ==
X-Gm-Message-State: APjAAAWdlzx45nl7P+rtGVaQddOeJ4vT/2vgoDsIr33JQ4TebHZtIFqM
 BGqo7HHWl6BtUZLf8PR15EpXF4NbWxm6BA5SYrqt3w==
X-Google-Smtp-Source: APXvYqwnsSiRi9Xx+mWZd5WIVqyXAjG2mq2uyzE+Na7SMbagtqWch2e6RQjcNIbMGJIdeI2RTE7vw/EPGIVBnGUkzvc=
X-Received: by 2002:aca:281a:: with SMTP id 26mr1916626oix.163.1567678480164; 
 Thu, 05 Sep 2019 03:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190905083049.11645-1-thuth@redhat.com>
In-Reply-To: <20190905083049.11645-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 11:14:29 +0100
Message-ID: <CAFEAcA-HCiktA0MjS_+FUtJPQQMTfGU6tpaa-DKFa_JNqVOWgQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 0/8] qtests and misc patches
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

On Thu, 5 Sep 2019 at 09:30, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit a8b5ad8e1faef0d1bb3e550530328e8ec76fe8=
7c:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-09-04 17:22:34 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-09-05
>
> for you to fetch changes up to 7bb21c0ac301e423b483dd7fc171b0d7b56de2cf:
>
>   qemu-doc: Do not hard-code the name of the QEMU binary (2019-09-05 09:4=
5:09 +0200)
>
> ----------------------------------------------------------------
> - Make the core libqtest library independent from global_qtest
> - Clean up docs from hard-coded qemu-system-* names
> ----------------------------------------------------------------
>
> Thomas Huth (8):
>       tests/migration: Do not use functions anymore that rely on global_q=
test
>       tests/libqos/e1000e: Make e1000e libqos functions independent from =
global_qtest
>       tests/libqos: Replace clock_step with qtest_clock_step in virtio co=
de
>       tests: Remove unnecessary global_qtest references
>       tests/libqtest: Move global_test wrapper function into a separate h=
eader
>       tests/libqtest: Use libqtest-single.h in tests that require global_=
qtest
>       tests/vm: Take the J=3Dx setting into account for the vm-boot-ssh t=
argets, too
>       qemu-doc: Do not hard-code the name of the QEMU binary

Hi; I'm afraid this fails to build:

/home/pm/qemu/tests/virtio-9p-test.c: In function =E2=80=98v9fs_req_init=E2=
=80=99:
/home/pm/qemu/tests/virtio-9p-test.c:162:16: error: =E2=80=98global_qtest=
=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98g_file_test=
=E2=80=99?
     req->qts =3D global_qtest;
                ^~~~~~~~~~~~
                g_file_test
/home/pm/qemu/tests/virtio-9p-test.c:162:16: note: each undeclared
identifier is reported only once for each function it appears in
/home/pm/qemu/rules.mak:69: recipe for target 'tests/virtio-9p-test.o' fail=
ed


thanks
-- PMM

