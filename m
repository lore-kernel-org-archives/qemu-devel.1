Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C22C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25B320835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CUiKO3MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25B320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKzd-00030L-RI
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCKym-0002HV-V8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCKyk-0002lf-IV
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:50:00 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43227)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCKyi-0002kG-K2
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:49:58 -0400
Received: by mail-ot1-x330.google.com with SMTP id o44so3059720ota.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JbizzNlg2CKEas/rVo0NSsF/yuehxf4ZF3f8CiFItmg=;
 b=CUiKO3MOEoQf2iXgG1Qyd6a6OVHmvVQTD71RWnJA1XdfMSqqV/N7f3G4zhMBIGv7HJ
 gdBZcqz0TF+iaOjyrPNXwvhYqN+dvDsho8Wmm8BjhVSlw5O5iX7K+xDhuDVwmvnejebB
 HU7e/V6XZuUwqfBvLi3TES7nMtSS9FwNJGaFHO3N2q3yoXHnqkxHVzpEi5Krp34/xOCH
 q+bfZXjaKk1DG9Kk2mbR6pNkRAwPDlcmBQHMV2RdlOhX1Owp9lW04jnl4rAnd0KE1nY9
 aE9SbjwcOPg0xfqYv3fkm1YHBdvf1AG5PLAi/J9QVZFMIDLAXjB3YoRgm0wvNcz9RpJf
 OYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JbizzNlg2CKEas/rVo0NSsF/yuehxf4ZF3f8CiFItmg=;
 b=EbvIe2W+kECZebTx+DR9WNyb4yIBbblc82GTZjZuAYFOeTeHuEulNCJoknWsoDDsCu
 7dhE4V2pF9ccAPNGo30P6soElkaRXTif+DRlH18GAdo/G1Mukmq88+FpOPLm2xHO6w+9
 WOV6Kf1V5C88SClUSV56Jo/KEEG/aycZ2U8sj6xjlR+z8O4B8yLigN+kcAy0a7+rTr/c
 Nf1o3WNf1R36F1nTe8hEG1Xvf2A1uLXw5XPucq3aRiZ+2qknsRYrMunTvLW1OlyUM015
 Ove8Zo9C+nN6GTm3tLkCyFkLK+dEwSXm2QHr3pxBHp9blD/0Dui3pyzD9dqBVp+ZqqmT
 rAxQ==
X-Gm-Message-State: APjAAAU3Qj3kpH6yLlabh2ZX/p0tOCHhVtj4EecYkF5//I/ZEJthPQQ2
 jzhLugETK4cFKh2Lc+ZD3pbkmdLK8tjcEXQhbWT8sg==
X-Google-Smtp-Source: APXvYqwH4pQkLQ5taKcJUg9XRXB/BhIVYIxwAC7U817o4dVSOApU152GGP0S8l5G8nrSnVLL7h31i9vzcJPoM1KvNz0=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr21425570oti.135.1569232193829; 
 Mon, 23 Sep 2019 02:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190920162058.29743-1-kwolf@redhat.com>
In-Reply-To: <20190920162058.29743-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 10:49:42 +0100
Message-ID: <CAFEAcA9_bvioJZBDK+VoPupL5_Hjyu1jvMn-7pCcXduV64UpXA@mail.gmail.com>
Subject: Re: [PULL 0/4] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 17:21, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 521db80318d6c749a6f6c5a65a68397af9e3ef16:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-09-16' into staging (2019-09-16 15:25:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to d2c8c09fca9210d0f2399c8d570086a4a66bd22e:
>
>   iotests: Remove Python 2 compatibility code (2019-09-20 17:58:51 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix internal snapshots with typical -blockdev setups
> - iotests: Require Python 3.6 or later
>
> ----------------------------------------------------------------
> Kevin Wolf (4):
>       block/snapshot: Restrict set of snapshot nodes
>       iotests: Test internal snapshots with -blockdev
>       iotests: Require Python 3.6 or later
>       iotests: Remove Python 2 compatibility code

Hi. This fails 'make check' on all the non-x86 Linux hosts:
iotests 267 fails on aarch32, ppc64, s390x, aarch64.
Sample output from the aarch32 run; others are similar
but the listed snapshot size differs.

  TEST    iotest-qcow2: 267 [fail]
QEMU          --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -display none
-machine virt,accel=qtest
QEMU_IMG      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-io"
 --cache writeback -f qcow2
QEMU_NBD      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-51-generic
TEST_DIR      --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_helper

--- /home/peter.maydell/qemu/tests/qemu-iotests/267.out 2019-09-20
17:54:40.127012142 +0000
+++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/267.out.bad
      2019-09-20 18:02:11.756586745 +0000
@@ -34,7 +34,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -45,7 +45,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               636 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               684 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -70,7 +70,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               636 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               684 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -95,7 +95,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -106,7 +106,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -120,7 +120,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -135,7 +135,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -146,14 +146,14 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

 Internal snapshots on overlay:
 Snapshot list:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+1         snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 Internal snapshots on backing file:

 === -blockdev with NBD server on the backing file ===
@@ -167,7 +167,7 @@
 (qemu) info snapshots
 List of snapshots present on all disks:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+--        snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit

@@ -178,5 +178,5 @@
 Internal snapshots on backing file:
 Snapshot list:
 ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0               591 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
+1         snap0               640 KiB yyyy-mm-dd hh:mm:ss   00:00:00.000
 *** done
Not run: 172 186 192 220
Failures: 267
Failed 1 of 104 iotests


thanks
-- PMM

