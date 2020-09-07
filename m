Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C922C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C5D21556
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvXAZDq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNfr-0006Zb-4h
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFNfC-00063Z-3I
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:22:54 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:35975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFNf9-00028s-NM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:22:53 -0400
Received: by mail-ej1-x62a.google.com with SMTP id e23so19597383eja.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=567r3FBVF6W9mK7iue0v8vLjrsBIMfPdDhdxER/ESQs=;
 b=NvXAZDq2K8Prso876b+vm7LaemuWn5ajJySJgBwpBMA+cltEI2ovhmUDr+kmy6ImXX
 /ZKRDB7DPW2WvFbQTLk9Nq0L+OVOJqorZp19/KI16Koir2AUL5MzZY8pnMPrtyYAtsDc
 1+Ma1jhn5H4onGyp6NP2PcaZnOPMkgRVxH+cyJZgKqZPh0hcNnAcnAmxc2kfsy7ZQfDI
 Iohpjh4g1BMyuEGOnpcnp+O6E1Ek5WsL+BRDqGWzK+ct/uS5uOakjhcS4mAMkPfYYFfa
 LtgeL2P4++wTp8Gwr6dj5QpS+XM+e0lQz7idVglR+Qq5IZNNoM3BKo1pk8odsRrILqF/
 bAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=567r3FBVF6W9mK7iue0v8vLjrsBIMfPdDhdxER/ESQs=;
 b=R/nAT5N6OJkL7uc66+s6ERBbZmN2My4xXbqcRUCJjX1gaxR/uzr+VciA7pwLg5a5y8
 ItrssiMpESmr//vm0K/U+MG//3SpmJVqbgMQGU70BZVuIKk9H/i7wzcdWEMTL9Wjw3bX
 GR+sS1t6zBneRq8xUyn3I8CDTAuPxVO/g1JPYboOZrs9mlCKY+3GknVBAL8pzWZehVkg
 +tmrP8g0QE0G7kHpMGI4hQWzGUTjfHX5ez6AH/jJw2lpLTMLbnWL+Ek1HjOKYcFYLT/l
 VlUR+7RtmQgmvMUp1ot065RxqgIdBzur1DLUY7NR/3Xa1snRg89pjsbB5RilEB75l3NQ
 gfyQ==
X-Gm-Message-State: AOAM531W5R/dY9Q+WjVGcjM5hX3rQe5i/7/DEIjwxUFVtzXgJyX8yKCz
 pqafO4i31w8B3IUAY9gor5+wqsubGHKqLXcWceclCQ==
X-Google-Smtp-Source: ABdhPJxJ4Oz5SNyZUL8QNgWPTKpcc5fHyOKAey0eSRckfgFVxItqQ86dEfJbxMKgFImh015j9M/WicbrTjkXmc7wc3I=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr5153124ejv.56.1599510169869; 
 Mon, 07 Sep 2020 13:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200907110936.261684-1-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 21:22:38 +0100
Message-ID: <CAFEAcA_woBi7gMG9vK7heTwc-uCee8q3O44Mq3icHvCk2bYNNg@mail.gmail.com>
Subject: Re: [PULL 00/64] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Sep 2020 at 12:09, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4cc0ec9b1b8830f7d1fcf5dfded19ef070f98eaa:
>
>   block/nvme: Pair doorbell registers (2020-09-07 12:47:57 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-img create: Fail gracefully when backing file is an empty string
> - Fixes related to filter block nodes ("Deal with filters" series)
> - block/nvme: Various cleanups required to use multiple queues
> - block/nvme: Use NvmeBar structure from "block/nvme.h"
> - file-win32: Fix "locking" option
> - iotests: Allow running from different directory

Fails in make check on iotests 040 and/or 041, various hosts:

s390x linux:

  TEST    iotest-qcow2: 041 [fail]
QEMU          --
"/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-system-s390x"
-nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/s390x qemu01 4.15.0-72-generic
TEST_DIR      -- /home/ubuntu/qemu/build/all/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.5Tpl6u2SCo
SOCKET_SCM_HELPER --
/home/ubuntu/qemu/build/all/tests/qemu-iotests/socket_scm_helper

--- /home/ubuntu/qemu/tests/qemu-iotests/041.out        2020-09-07
14:29:45.468466636 -0400
+++ /home/ubuntu/qemu/build/all/tests/qemu-iotests/041.out.bad
2020-09-07 14:43:41.494989911 -0400
@@ -1,5 +1,29 @@
-...........................................................................................................
+.FF........................................................................................................
+======================================================================
+FAIL: test_explicit_mirror_filter (__main__.TestFilters)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1415, in test_explicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 888,
in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Device 'virtio-blk-ccw' can't go on
PCI bus"}}"
+
+======================================================================
+FAIL: test_implicit_mirror_filter (__main__.TestFilters)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1381, in test_implicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 888,
in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Device 'virtio-blk-ccw' can't go on
PCI bus"}}"
+
 ----------------------------------------------------------------------
 Ran 107 tests

-OK
+FAILED (failures=2)


freebsd:

  TEST    iotest-qcow2: 040 [fail]
QEMU          --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-system-aarch64"
-nodefaults -display none -accel qtest -machine virt
QEMU_IMG      --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-io"
 --cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.gaJ11NA1
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/040.out
2020-09-07 18:29:28.000000000 +0000
+++ /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/040.out.bad
 2020-09-07 18:37:26.783967000 +0000
@@ -1,5 +1,17 @@
-.................................................................
+....................F............................................
+======================================================================
+FAIL: test_filtered_active_commit_with_filter (__main__.TestCommitWithFilters)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "040", line 867, in test_filtered_active_commit_with_filter
+    self.assert_qmp(result, 'return', {})
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 888, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Bus 'pcie.0' does not support
hotplugging"}}"
+
+----------------------------------------------------------------------
 Ran 65 tests

-OK
+FAILED (failures=1)
  TEST    iotest-qcow2: 041 [fail]
QEMU          --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-system-aarch64"
-nodefaults -display none -accel qtest -machine virt
QEMU_IMG      --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-io"
 --cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
TEST_DIR      -- /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.gaJ11NA1
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/041.out
2020-09-07 18:29:28.000000000 +0000
+++ /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/041.out.bad
 2020-09-07 18:38:32.186227000 +0000
@@ -1,5 +1,29 @@
-...........................................................................................................
+.FF........................................................................................................
+======================================================================
+FAIL: test_explicit_mirror_filter (__main__.TestFilters)
 ----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1415, in test_explicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 888, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
+
+======================================================================
+FAIL: test_implicit_mirror_filter (__main__.TestFilters)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1381, in test_implicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 888, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
line 862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
+
+----------------------------------------------------------------------
 Ran 107 tests

-OK
+FAILED (failures=2)

AArch32 and AArch64 Linux:

  TEST    iotest-qcow2: 041 [fail]
QEMU          --
"/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-system-aarch64"
-nodefaults -disp
lay none -accel qtest -machine virt
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
PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-101-generic
TEST_DIR      --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.L8FBRpgYvF
SOCKET_SCM_HELPER --
/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_helper

--- /home/peter.maydell/qemu/tests/qemu-iotests/041.out 2020-09-07
18:29:45.583104907 +0000
+++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/041.out.bad
      2020-09-07 18:45:19.385149062 +0000
@@ -1,5 +1,29 @@
-...........................................................................................................
+.FF........................................................................................................
+======================================================================
+FAIL: test_explicit_mirror_filter (__main__.TestFilters)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1415, in test_explicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
888, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Bus 'pci.0' not fou
nd"}}"
+
+======================================================================
+FAIL: test_implicit_mirror_filter (__main__.TestFilters)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "041", line 1381, in test_implicit_mirror_filter
+    self.assert_qmp(result, 'return', {})
+  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
888, in assert_qmp
+    result = self.dictpath(d, path)
+  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
862, in dictpath
+    self.fail(f'failed path traversal for "{path}" in "{d}"')
+AssertionError: failed path traversal for "return" in "{'error':
{'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
+
 ----------------------------------------------------------------------
 Ran 107 tests

-OK
+FAILED (failures=2)


thanks
-- PMM

