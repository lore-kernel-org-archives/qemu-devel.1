Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E626C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CB020678
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsiMy9Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CB020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXeF-0000gh-Nm
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFXdJ-0008RU-PE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:01:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFXdG-0000d0-Vd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01BGDK3HD9Q1mCmU41Qr2ddMGjZkx0CWJKAO5SFUz8I=;
 b=hsiMy9GwwjJyuPFmrgTpLKqwWNMg92Er4mNhur6w0DCJaNkXWufrTSPEeiNCNlkysmRhaW
 F11EGZzpEpHto2wh+Yfq1pShpMsDWYljXPtSkjzmIBMaLkp+AdwF+PdXUuEyXCM8lQVeyI
 ZKx+ly/DW1ixQdkueO2bA7x/9o2aI/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-bLsv0JIjPkOUnKyQI1VrUA-1; Tue, 08 Sep 2020 03:01:30 -0400
X-MC-Unique: bLsv0JIjPkOUnKyQI1VrUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 250E71005E6A;
 Tue,  8 Sep 2020 07:01:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-55.ams2.redhat.com [10.36.113.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7DC71002D40;
 Tue,  8 Sep 2020 07:01:27 +0000 (UTC)
Date: Tue, 8 Sep 2020 09:01:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/64] Block layer patches
Message-ID: <20200908070126.GA8175@linux.fritz.box>
References: <20200907110936.261684-1-kwolf@redhat.com>
 <CAFEAcA_woBi7gMG9vK7heTwc-uCee8q3O44Mq3icHvCk2bYNNg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_woBi7gMG9vK7heTwc-uCee8q3O44Mq3icHvCk2bYNNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.09.2020 um 22:22 hat Peter Maydell geschrieben:
> On Mon, 7 Sep 2020 at 12:09, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit 7c37270b3fbe3d034ba80e488761461676e21eb4:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200904-pull-request' into staging (2020-09-06 16:23:55 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 4cc0ec9b1b8830f7d1fcf5dfded19ef070f98eaa:
> >
> >   block/nvme: Pair doorbell registers (2020-09-07 12:47:57 +0200)
> >
> > ----------------------------------------------------------------
> > Block layer patches:
> >
> > - qemu-img create: Fail gracefully when backing file is an empty string
> > - Fixes related to filter block nodes ("Deal with filters" series)
> > - block/nvme: Various cleanups required to use multiple queues
> > - block/nvme: Use NvmeBar structure from "block/nvme.h"
> > - file-win32: Fix "locking" option
> > - iotests: Allow running from different directory
> 
> Fails in make check on iotests 040 and/or 041, various hosts:
> 
> s390x linux:
> 
>   TEST    iotest-qcow2: 041 [fail]
> QEMU          --
> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-system-s390x"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-io"
> --cache writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/ubuntu/qemu/build/all/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/s390x qemu01 4.15.0-72-generic
> TEST_DIR      -- /home/ubuntu/qemu/build/all/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.5Tpl6u2SCo
> SOCKET_SCM_HELPER --
> /home/ubuntu/qemu/build/all/tests/qemu-iotests/socket_scm_helper
> 
> --- /home/ubuntu/qemu/tests/qemu-iotests/041.out        2020-09-07
> 14:29:45.468466636 -0400
> +++ /home/ubuntu/qemu/build/all/tests/qemu-iotests/041.out.bad
> 2020-09-07 14:43:41.494989911 -0400
> @@ -1,5 +1,29 @@
> -...........................................................................................................
> +.FF........................................................................................................
> +======================================================================
> +FAIL: test_explicit_mirror_filter (__main__.TestFilters)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1415, in test_explicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 888,
> in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Device 'virtio-blk-ccw' can't go on
> PCI bus"}}"

Max, any specific reason you specified the bus in device_add?

This seems to fix it for me. Do you agree with the change?

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index cdbef3ba20..203ed58868 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1376,7 +1376,6 @@ class TestFilters(iotests.QMPTestCase):
         result = self.vm.qmp('device_add',
                              driver='virtio-blk',
                              id='virtio',
-                             bus='pci.0',
                              drive='source')
         self.assert_qmp(result, 'return', {})

@@ -1410,7 +1409,6 @@ class TestFilters(iotests.QMPTestCase):
         result = self.vm.qmp('device_add',
                              driver='virtio-blk',
                              id='virtio',
-                             bus='pci.0',
                              drive='source')
         self.assert_qmp(result, 'return', {})


> +======================================================================
> +FAIL: test_implicit_mirror_filter (__main__.TestFilters)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1381, in test_implicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 888,
> in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/ubuntu/qemu/tests/qemu-iotests/iotests.py", line 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Device 'virtio-blk-ccw' can't go on
> PCI bus"}}"
> +
>  ----------------------------------------------------------------------
>  Ran 107 tests
> 
> -OK
> +FAILED (failures=2)
> 
> 
> freebsd:
> 
>   TEST    iotest-qcow2: 040 [fail]
> QEMU          --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-system-aarch64"
> -nodefaults -display none -accel qtest -machine virt
> QEMU_IMG      --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-io"
>  --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
> TEST_DIR      -- /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.gaJ11NA1
> SOCKET_SCM_HELPER --
> 
> --- /home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/040.out
> 2020-09-07 18:29:28.000000000 +0000
> +++ /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/040.out.bad
>  2020-09-07 18:37:26.783967000 +0000
> @@ -1,5 +1,17 @@
> -.................................................................
> +....................F............................................
> +======================================================================
> +FAIL: test_filtered_active_commit_with_filter (__main__.TestCommitWithFilters)
>  ----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "040", line 867, in test_filtered_active_commit_with_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 888, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Bus 'pcie.0' does not support
> hotplugging"}}"

This one I don't really understand. Why "pcie.0"? Do FreeBSD hosts
default to a different machine type? The default should be the "pc"
machine type, which has pci, not pcie.

> +----------------------------------------------------------------------
>  Ran 65 tests
> 
> -OK
> +FAILED (failures=1)
>   TEST    iotest-qcow2: 041 [fail]
> QEMU          --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-system-aarch64"
> -nodefaults -display none -accel qtest -machine virt
> QEMU_IMG      --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-io"
>  --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/usr/home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
> TEST_DIR      -- /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.gaJ11NA1
> SOCKET_SCM_HELPER --
> 
> --- /home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/041.out
> 2020-09-07 18:29:28.000000000 +0000
> +++ /home/qemu/qemu-test.6pxNB5/build/tests/qemu-iotests/041.out.bad
>  2020-09-07 18:38:32.186227000 +0000
> @@ -1,5 +1,29 @@
> -...........................................................................................................
> +.FF........................................................................................................
> +======================================================================
> +FAIL: test_explicit_mirror_filter (__main__.TestFilters)
>  ----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1415, in test_explicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 888, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
> +
> +======================================================================
> +FAIL: test_implicit_mirror_filter (__main__.TestFilters)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1381, in test_implicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 888, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/usr/home/qemu/qemu-test.6pxNB5/src/tests/qemu-iotests/iotests.py",
> line 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
> +
> +----------------------------------------------------------------------
>  Ran 107 tests

I guess this is the same problem.

> -OK
> +FAILED (failures=2)
> 
> AArch32 and AArch64 Linux:
> 
>   TEST    iotest-qcow2: 041 [fail]
> QEMU          --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-system-aarch64"
> -nodefaults -disp
> lay none -accel qtest -machine virt
> QEMU_IMG      --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-io"
>  --cache writeback --aio thre
> ads -f qcow2
> QEMU_NBD      --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-101-generic
> TEST_DIR      --
> /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.L8FBRpgYvF
> SOCKET_SCM_HELPER --
> /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_helper
> 
> --- /home/peter.maydell/qemu/tests/qemu-iotests/041.out 2020-09-07
> 18:29:45.583104907 +0000
> +++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/041.out.bad
>       2020-09-07 18:45:19.385149062 +0000
> @@ -1,5 +1,29 @@
> -...........................................................................................................
> +.FF........................................................................................................
> +======================================================================
> +FAIL: test_explicit_mirror_filter (__main__.TestFilters)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1415, in test_explicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
> 888, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
> 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Bus 'pci.0' not fou
> nd"}}"
> +
> +======================================================================
> +FAIL: test_implicit_mirror_filter (__main__.TestFilters)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1381, in test_implicit_mirror_filter
> +    self.assert_qmp(result, 'return', {})
> +  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
> 888, in assert_qmp
> +    result = self.dictpath(d, path)
> +  File "/home/peter.maydell/qemu/tests/qemu-iotests/iotests.py", line
> 862, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': "Bus 'pci.0' not found"}}"
> +
>  ----------------------------------------------------------------------
>  Ran 107 tests

Probably solved by removing the bus like suggested for s390x above.

Kevin


