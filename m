Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64862C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2202076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o77+yC/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2202076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbNi-0001aE-CN
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbJw-0004wO-QG
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:28:16 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbJv-0005il-JC
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:28:16 -0400
Received: by mail-ot1-x332.google.com with SMTP id c3so1994241otr.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=reQyUrW9mva1Op8l/EMrOreOktGwhFUrlHplVgfpIbc=;
 b=o77+yC/akFvBIL3fCREBfxEP46bDkXXoccQ3s0vlSSYQyAX3UI5Biu/wJQ6puhtHYO
 3BkHRc3uwhgKNlwkJYWFgjLesliA0cYydUDRZp9F4CLVwe6uPO2RXOjAKhZ4zHXFHIqn
 RTkVkptKxgF8aZVEQyIJImlCgvGUnuEsLWFhnn9JDl85cvyOJd9+Lh6/aD+6//NB1140
 hv2DXojictHiTWziJm35smAl3kDh9OHg+1AqSgyEegubuEvO9lVXRLPXWqo0q06Guby9
 dM6wW2pbBOHvmib6GBmjIO3etVHYEvo59mQUwskkWGaHeBkakyBM257mFzLgt11MUyEJ
 aEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=reQyUrW9mva1Op8l/EMrOreOktGwhFUrlHplVgfpIbc=;
 b=KPNJI+QurLguzF4gN40a2k6SBIJxfL1O9X9qOGI/ybRNdzkhYEqVT4mWnRxY6lTYwf
 0NM5eBUfPXrxp3kp8j/koGlXzWRNmTnNOAW1XsAAM/+1kipyfskpLQYFzgq8/ci758+k
 jT71rHgCbYr80feTp21IL39gN5AFcPrsN42QZ7Kwn98JgZGG3NM37eMTv1zcnTdl1t2C
 rhqlVXS/HPQXMQRi/A+QmJITyWegpANdj2v4ceDiTSiL0aBZuIpr9oXqlR0eu/er1SCR
 1er9+cP6GqgOeDTcwK27S/hhwp2iWFmrxxysgMAifRcwbqSzFiokS02cn28kD5HIMIN2
 fMLA==
X-Gm-Message-State: AOAM533liAG/MaXBgpix7hWtcIzUrKD9b4ZPlKbfDgxJnQq1+jA+KHH7
 mWtI71tdWpJbjXm5pV+3vmBBHSD73l7oGeYtVMnV3w==
X-Google-Smtp-Source: ABdhPJx8HQ3nSRmJIViug/Xxsj7fN8V2OYbJyKYF6XhzhbPbdVPZhWVBfoIWYpr4TXJSZMxLKZh/ncrK6yDm9KqN4Nk=
X-Received: by 2002:a9d:3623:: with SMTP id w32mr681400otb.91.1589552894202;
 Fri, 15 May 2020 07:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200515124521.335403-1-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 15:28:03 +0100
Message-ID: <CAFEAcA9Wh7DKs38aMJ+35Sji8cFaViBXsphWZyZ_qW6n1qn30g@mail.gmail.com>
Subject: Re: [PULL 00/51] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Fri, 15 May 2020 at 13:45, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 013a18edbbc59cdad019100c7d03c0494642b74c:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200514' into staging (2020-05-14 16:17:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7d8f21a650e562270f5ed5341134c9c2c39dc5e8:
>
>   iotests/030: Reduce run time by unthrottling job earlier (2020-05-15 14:12:34 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Introduce real BdrvChildRole
> - blk/bdrv_make_empty() functions instead of calling callbacks directly
> - mirror: Make sure that source and target size match
> - block-copy: Fix uninitialized variable
> - block/replication: Avoid cancelling the job twice
> - ahci: Log lost IRQs
> - iotests: Run pylint and mypy in a testcase
> - iotests: log messages from notrun()

Hi; I'm afraid aarch64, ppc64 and aarch32 all failed on iotest 229:


PPC64:
  TEST    iotest-qcow2: 229 [fail]
QEMU          --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-system-ppc64"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.6nPwQm0Y01
SOCKET_SCM_HELPER --
/home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm215/qemu/tests/qemu-iotests/229.out 2020-05-15
12:46:57.991595216 +0000
+++ /home/pm215/qemu/build/all/tests/qemu-iotests/229.out.bad
2020-05-15 12:55:31.022877791 +0000
@@ -21,5 +21,5 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id":
"testdisk"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id":
"testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len":
2097152, "offset": 2097152, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len":
2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
 *** done

AArch64:
  TEST    iotest-qcow2: 229 [fail]
QEMU          --
"/home/pm/qemu/build/all/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -dis
play none -machine virt -accel qtest
QEMU_IMG      -- "/home/pm/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/pm/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/pm/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/aarch64 qemu-test 5.4.19
TEST_DIR      -- /home/pm/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.xiNXu5VDz9
SOCKET_SCM_HELPER --
/home/pm/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/pm/qemu/tests/qemu-iotests/229.out    2020-05-15
12:46:56.086403523 +0000
+++ /home/pm/qemu/build/all/tests/qemu-iotests/229.out.bad
2020-05-15 12:58:25.074083672 +0000
@@ -21,5 +21,5 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "ru
nning", "id": "testdisk"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "ab
orting", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "
testdisk", "len": 2097152, "offset": 2097152, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "
testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
 *** done

AArch32:

  TEST    iotest-qcow2: 229 [fail]
QEMU          --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-
nodefaults -display none -machine virt -accel qtest
QEMU_IMG      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-io"
 --cache writeback --aio thre
ads -f qcow2
QEMU_NBD      --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-51-generic
TEST_DIR      --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.tbyzUS8J3l
SOCKET_SCM_HELPER --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_helper

--- /home/peter.maydell/qemu/tests/qemu-iotests/229.out 2020-05-15
12:46:56.206202633 +0000
+++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/229.out.bad
      2020-05-15 13:06:42.331534509 +0000
@@ -21,5 +21,5 @@
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "ru
nning", "id": "testdisk"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "JOB_STATUS_CHANGE", "data": {"status": "ab
orting", "id": "testdisk"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "
testdisk", "len": 2097152, "offset": 2097152, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "BLOCK_JOB_CANCELLED", "data": {"device": "
testdisk", "len": 2097152, "offset": 1048576, "speed": 0, "type": "mirror"}}
 *** done

thanks
-- PMM

