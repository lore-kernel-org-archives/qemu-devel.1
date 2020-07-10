Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9638C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720B92078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAYkWoxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B92078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvAd-0000Fg-OI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtv9n-0008AW-OF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:41:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtv9k-0007db-PT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:41:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id c25so4492341otf.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rvrjcEpDCMpFjIp6kWoioCECdO1dU7B79bY/Bn7Jf1Q=;
 b=RAYkWoxrctryEW+F1SVoSzlJ4AgPRBDSiRMCg9oNJOdxB23KXhYB+yJvRCmV8Z1k/9
 Suon8XncLxVFwsKX8U6o5kJ/4tbn4OoQrZ8mZzBFJq7GzYAMxQtNYHMevIAeNuP21DqF
 K7g1a1b4jPhfQSryn2HPFAKoFGNf6FgxVUysyrrLGmPyO0IqFim4NFfxALwMr7WvBUWY
 iY2EgDC9TqvWtTRAOo5hOfZ3lanE/EyeFV7KES9VyQAzP5Jsc4EkYSqudpm9EmAnVPs0
 AZlPT2I887ZDq7+39D/kAP+eGkfaHirCHm/NLQWwx4pSOsI6t9GszHYtJ+QaLYu1YdgI
 a5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rvrjcEpDCMpFjIp6kWoioCECdO1dU7B79bY/Bn7Jf1Q=;
 b=P+LK2qOgMkKe+r353ilxnZc3/zj/hVHEu3gD+peS/tedhn8tPTdNbLQs3tHJ9p/31h
 oFzRrY+09NiMzBk+1qXirvLK9xS0QZldNpqe92N2f4KH2LmzN2ASCpIJRfzvgIhW1th+
 IEIzom6Sbe2n9KhL+0reLQ6BWR+Ez1T19Y2vCMHhqHhWcrbNoPBMT5ZvmRhbWeaJqmXL
 M07hgRTjyPjwUB/Wvf2MRVkU5n6mlJcaWeHM9oRyt5++DoreidjuEoAi8Ov9+xlfufDe
 P3dPkrSG5scJzvy1idrrEvyAvcGnPcBn1TwOtGuhavv31Wx6oRHt0FT9wD92nsgUzFk0
 Y9Ow==
X-Gm-Message-State: AOAM532XIYK2r1d4Jvz+5jn6jLNKCqhHr1sAiEctFw9Niwe+pibPLzxZ
 f+0OnwRwAKNHR6M27UUP5+QqJOclIcIlZnyx7yw5EQ==
X-Google-Smtp-Source: ABdhPJzOmqdgNyZ1j01d2jjfUVKkoWpRUA8tygcGaYgrJi581KcmJAmjB9+yk4L57iuwibl79GrBC5UzE0j/dg7N3+k=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr51864745oto.135.1594395703375; 
 Fri, 10 Jul 2020 08:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200709121713.283092-1-kwolf@redhat.com>
In-Reply-To: <20200709121713.283092-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 16:41:32 +0100
Message-ID: <CAFEAcA-LwS=MhC9ewXrQht2GzLMa951uGP=8MNGsTPqzEO89GA@mail.gmail.com>
Subject: Re: [PULL v2] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 13:17, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 8796c64ecdfd34be394ea277aaaaa53df0c76996:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200706-pull-request' into staging (2020-07-08 16:33:59 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to d1c824e681e423a6224c6831a493e9175fa02dc1:
>
>   qemu-img: Deprecate use of -b without -F (2020-07-09 14:14:55 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Mitigate file fragmentation with extent size hints
> - Tighten qemu-img rules on missing backing format
> - qemu-img map: Don't limit block status request size
>

iotest 114 fails on FreeBSD and OpenBSD (and probably NetBSD
but that build hasn't reported back yet): looks like a
non-portable use of 'truncate' ?

  TEST    iotest-qcow2: 114 [fail]
QEMU          --
"/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -disp
lay none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.RQQ2LyuG
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.FOdDM2/src/tests/qemu-iotests/114.out
2020-07-10 14:51:21.000000000 +0000
+++ /home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/114.out.bad
 2020-07-10 15:15:14.446278000 +0000
@@ -1,8 +1,11 @@
 QA output created by 114
-qemu-img: warning: Deprecated use of backing file without explicit
backing format (detected format of raw)
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
backing_file=TEST_DIR/t.IMGFMT.orig
+truncate: illegal option -- -
+usage: truncate [-c] -s [+|-|%|/]size[K|k|M|m|G|g|T|t] file ...
+       truncate [-c] -r rfile file ...
+qemu-img: TEST_DIR/t.IMGFMT: Could not open 'TEST_DIR/t.IMGFMT.orig':
No such file or directory
+Could not open backing image.
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-qemu-img: warning: Deprecated use of backing file without explicit
backing format
+qemu-img: Could not open
'/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/scratch/t.qcow2.orig':
Could not open '/home/qemu/qemu-test.FOdDM2/build/tests/qemu-iotests/scratch/t.qcow2.orig':
No such file or directory
 qemu-img: warning: Deprecated use of backing file without explicit
backing format (detected format of IMGFMT)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 qemu-img: warning: Deprecated use of unopened backing file without
explicit backing format, use of this image requires potentially unsafe
format probing

thanks
-- PMM

