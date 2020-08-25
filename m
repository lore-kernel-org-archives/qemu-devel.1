Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53D9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684742075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYJD7xhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684742075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZX7-0007q5-LS
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZVy-0006g2-Pf
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:01:30 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:33992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZVv-000128-H8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:01:30 -0400
Received: by mail-ej1-x636.google.com with SMTP id d26so6581840ejr.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6RRwTsSRAth4xTLvFoswLh74DDZmvoXs0ZuaSRR8mc=;
 b=dYJD7xhqjmsLiuyBW0eVNJTNkT9T6ExruOHSCvwZbuDnWNtGbNIIY7aLYqHhXOEGDk
 sVoeVDuG6aqPHm6yRKev5WSFdRreiq44wdnQ0iUz2ukA4t7/Sm5SHwee2RCfIjTueycZ
 gB6DNXL8WNfpzv1SZ6ZVJC469s+e1/lig6LcohDu2zZ+xaw5Z0du6GCkFy+pCWzioRlL
 wyDInbMHCstPnV7xudY05DxQeQo0l4hOSoeS9pGlqF5hOezJOWNxtwHZlQmildj70taD
 LSZfmv0uwWE41dfzUpnsRZ1qfvMM4Mfj19nRWtxyzqiWnnBBW2cQhjJAGAzvFivHsjRr
 Y3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6RRwTsSRAth4xTLvFoswLh74DDZmvoXs0ZuaSRR8mc=;
 b=L4Zpc8ckgZXT5Q8CxKngVNkzIRihV3Ug0cJFcRai0aD9VS8t5GKDCA10b4EIlVzIAB
 n1Q3vMax69yj0aVJkCxfG2Usdb1b1z38EGtPCB6cv1lnjoQfOr//jtZmlnu4k0UUf+Ts
 4qGvbFW1M2KatVXgBSlPG0NG5q6BGx+ZNrLHBGpz5rSGVHLC/jZvsD5assIMDI9qQN0r
 AzjsbKqbT0lzxdFnWUyLoJCesDqMmB1VJNovA8HQPe/njzI8HeMsEtT11yESI+liRyeK
 LhQKvyoKUKO1uKuglne9EC74BR+TuBdcmFYj9SyYu0ARhfYqPXXYn0IUXq7BgLsm3Sz7
 BZEA==
X-Gm-Message-State: AOAM532hCe4iFJSWwznwyDHq93JImO6WkeqVGBcaM9BmCeclE/194d4U
 sbWp9DA/PYWD8tl0QC+EZDSd+kQGThS1UnNO97SblQ==
X-Google-Smtp-Source: ABdhPJyzoHlNK/Vq7qWjm25WTMiYtwXr3Gwwebgeo1trUjkNThTgcRay1VN1s188WOhFC1YCOyLwVQ6iV54W8+S2tiI=
X-Received: by 2002:a17:906:59b:: with SMTP id
 27mr11320715ejn.56.1598364085584; 
 Tue, 25 Aug 2020 07:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200825083311.1098442-1-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 15:01:14 +0100
Message-ID: <CAFEAcA-4bgPq2_8c7wo9y_A5Mp1KZ7iLuye5jQMMesXfE+fNhw@mail.gmail.com>
Subject: Re: [PULL 00/34] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 09:33, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812' into staging (2020-08-24 16:39:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-08-25
>
> for you to fetch changes up to c576fd97d4ca77b5a1a27728df11a61083dbfa98:
>
>   iotests: Add tests for qcow2 images with extended L2 entries (2020-08-25 10:20:18 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - qcow2 subclusters (extended L2 entries)

This fails 'make check' on the BSDs because it assumes it has a bash
in /bin/bash, which isn't necessarily true:


  TEST    iotest-qcow2: 271 [fail]
QEMU          --
"/home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/../../qemu-system-aarch64"
-nodefaults -display none -accel qtest -machine virt
QEMU_IMG      --
"/home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- NetBSD/amd64 localhost 9.0
TEST_DIR      -- /home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/mktemp.fPDlHdxw
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.dvSnX6/src/tests/qemu-iotests/271.out
2020-08-25 12:59:52.000000000 +0000
+++ /home/qemu/qemu-test.dvSnX6/build/tests/qemu-iotests/271.out.bad
 2020-08-25 13:11:25.483774595 +0000
@@ -1,726 +1 @@
-QA output created by 271
-
-### Standard write tests (backing file: yes) ###
-
-Formatting 'TEST_DIR/t.IMGFMT.raw', fmt=raw size=1048576
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=raw size=1048576
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
-write -q -P PATTERN 0 1k
-L2 entry #0: 0x8000000000050000 0000000000000001
-write -q -P PATTERN 3k 512
-L2 entry #0: 0x8000000000050000 0000000000000003
-write -q -P PATTERN 5k 1k
[skip rest of expected output]
-wrote 2048/2048 bytes at offset 40960
-2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-*** done
+./check: ./271: /bin/bash: bad interpreter: No such file or directory
  TEST    iotest-qcow2: 283


thanks
-- PMM

