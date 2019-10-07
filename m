Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4EEC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A62F205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhWyx8Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A62F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSF1-0006Xz-Pa
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSCo-0004na-B8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSCm-0005DX-AL
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:33:38 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:44475)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHSCk-0005AR-IV
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:33:36 -0400
Received: by mail-ot1-x330.google.com with SMTP id 21so10737601otj.11
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DF85m79MdXazF+UGlJIYlHGlRwKp+XKXiXGKov+KI4I=;
 b=IhWyx8Xufr1t7q6j7aYf9P7CWTEGReVcdywEm2YoACu+rGiLHKNHEc6aRoONOPTOah
 yK3IZth4FstvX0rtA/b/q+SxoPQbUsmIyjsz2vaUpMEPMwqtKbVLffZAIMqKVvUcfMXc
 hZClLRPBaflBvgeXkZ58xxxQdovafZeJq4HMi9fUJ2j/Ca4u1BtnI8FdQTKwyA8gUYr5
 2fXP8506CsV5RcCuoCtCiPEN+N/znxGc8CT+LhKiUYI70bJf/60D4iSrWX/JSBAcaXvz
 uUbMUgQsy9fr55wWuVN6oOB8c6oz0gDz1u/eaf1Ak+XquGNp43f4UDOknaXKiscHqu1B
 ZCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DF85m79MdXazF+UGlJIYlHGlRwKp+XKXiXGKov+KI4I=;
 b=FLVfrd5Kd6H/6ecAPZW193E89BgUS8b99RRTtr0byPsWO628vrcNGI+GJcMp6X1NOo
 3ITvZcslC1xOo5WmrUEgh+mjGa0Y2PI8J/Iby85cVKL+vdI0FpfGoVEXqUCLiQBVv2B4
 4yeGHKoEdh5kpdDM0NruTFKGOph4TEwAnQpiHH2G78oxpO+0tS6s1w89gkdaUyd1JjyI
 9WI6Xga3610FkL0CxkaM8004xhiPNLITJ3WNhGmekYvcssriTO7ZIsp+v0R7l3v79mac
 5QX6QjTA834jvtLwHkjNBt8Y6di3p+4iVAMAHPYkLcWt7ZHJhXPxt8AxBnG4uxEF50Kf
 Pezw==
X-Gm-Message-State: APjAAAW8NvjiLSXGMY3+xKBPMwjgYVOZ6RhcA6EEcfql+j2BTtplkOgJ
 NcQ/tgyLWUcrVc1CObQaFnABmaVPOoUq4oXjbEoWGw==
X-Google-Smtp-Source: APXvYqym6omKpj1+yfMEJJBCTdjljdDYg6CLTc+R85zj7fmKDkdrlfE5TzBn3iPblQ8QeQwK6ZckzCB/YPOVMm8x1Ik=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr19569752ote.97.1570451612286; 
 Mon, 07 Oct 2019 05:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191003193245.8993-1-jsnow@redhat.com>
In-Reply-To: <20191003193245.8993-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 13:33:21 +0100
Message-ID: <CAFEAcA9Z92iuYwEUdsSpej_pGiAX6H6FBaGySqKxXHGjGRueNw@mail.gmail.com>
Subject: Re: [PULL v2 0/8] Ide patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Oct 2019 at 20:33, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 7f21573c822805a8e6be379d9bcf3ad9effef3dc:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-10-01' into staging (2019-10-01 13:13:38 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to f6d61c9509c56eea3cdd2d23b40d285601b1c1ca:
>
>   hd-geo-test: Add tests for lchs override (2019-10-03 14:36:54 -0400)
>
> ----------------------------------------------------------------
> Pull request V2
>
> - Added signoff into the mirrored commits themselves (vs just the email)
> - Kudos to `stg-foreach stg edit --sign`
>
> ----------------------------------------------------------------

Hi; the new tests in hd-geo-test seem to hang on
big-endian hosts (both s390x and ppc64 hung here):

linux1@lxub05:~/qemu/build/all$ QTEST_QEMU_IMG=./qemu-img
QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
./tests/hd-geo-test
/x86_64/hd-geo/ide/none: OK
/x86_64/hd-geo/ide/drive/cd_0: OK
/x86_64/hd-geo/ide/drive/mbr/blank: OK
/x86_64/hd-geo/ide/drive/mbr/lba: OK
/x86_64/hd-geo/ide/drive/mbr/chs: OK
/x86_64/hd-geo/ide/device/mbr/blank: OK
/x86_64/hd-geo/ide/device/mbr/lba: OK
/x86_64/hd-geo/ide/device/mbr/chs: OK
/x86_64/hd-geo/ide/device/user/chs: OK
/x86_64/hd-geo/ide/device/user/chst: OK
/x86_64/hd-geo/override/ide:


thanks
-- PMM

