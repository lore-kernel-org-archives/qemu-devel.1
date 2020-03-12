Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80469C5ACBF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8092071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STyjMiVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8092071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOC3-00069O-7T
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCOAl-0005ZN-BG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCOAk-0007Zb-2t
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:46:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCOAj-0007Ym-RG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:46:50 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so3225651oic.9
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tvy1HAcSfNOmu/rEWk+d+j4tX5uloDVFgFUMIgdufNM=;
 b=STyjMiVtw2ZR08mMzboQBygWB7CRRi9p9zaF9zIJIC2eKX6IBPl5Uz7Owlx0Vu7MEK
 unp/O9UEGlxb/wUryQj2H5exeTxEL3HCZjZdZVheAPN4AaxSiOp0zQStJ1bYwrbMCt66
 P6AL3KYGzddOCDGVY4i8qGcJNTvbsvyfPOn1r1nlaAnOZODBjRKXetCtwFucLlWhg9Ma
 TG3IETRaL+S82jghejfjTk0U8sZSitSYVkOZn4lkmaDbOMj47AnjcdUkCrsaAkK8DByo
 VhD5RYshnJ6Y1FLUeWhWae53K6ojmqfj7e45qmN/4h27w7URORM4gPXCZXMhBoMtyU5I
 eB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tvy1HAcSfNOmu/rEWk+d+j4tX5uloDVFgFUMIgdufNM=;
 b=m+AzprrgBooyhqMC23586Ik64sNLzceE0jm3/xWFXCCvbJmO44qX5IwxzgmEaNy9is
 qR0XBA+nBE6WjUFZkRjlkWYIErv/ttRsirk72VCN/c601Cpb83axXh7jkZWdrsPWE6yB
 6RxSjJ3JFt4TuAijckiPa/zFJCMz0IO115aQRQkUbRyt+xb4u7Ecn2D7dPGZVJIbSbEm
 sq4SzsScq6FWXM4Zgc8zrUlNRBTcLVB7lZsej6rrUE3+muk9rU6LymWOEec37ywN410S
 fu8IiWDY0NmYZgt65q/trPh2EDQjZoWgS0CsgwuxqPJ2D8YKYIaegx3yyHnRBOqOA1Dl
 IlXA==
X-Gm-Message-State: ANhLgQ2zzL8mPp+Wxs2h/g1iObB57CYiQCjsZAnweA1oDFnIqn2h5WMg
 +w7xMLtiD1jr/Rotl5A4IkHsa6KdsZQZDR2Z7SQKOw==
X-Google-Smtp-Source: ADFU+vtk7o6ZJBLet0vU2UwwvPpxSkgdSyGjAsg/vEY43fHW8xzhOHd3xiGj7AmAUqJInRS5ZPfVTlhvnmmkslkvW0I=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr2560373oib.146.1584020808896; 
 Thu, 12 Mar 2020 06:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200311154218.15532-1-kwolf@redhat.com>
In-Reply-To: <20200311154218.15532-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 13:46:36 +0000
Message-ID: <CAFEAcA9uFFWfAaqtMD4BOu78aVoCae7+g61hFPzpSH7eHx=D6w@mail.gmail.com>
Subject: Re: [PULL 00/13] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Wed, 11 Mar 2020 at 15:42, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit ba29883206d92a29ad5a466e679ccfc2ee6132ef:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20200310' into staging (2020-03-10 16:50:28 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 8bb3b023f2055054ee119cb45b42d2b14be7fc8a:
>
>   qemu-iotests: adding LUKS cleanup for non-UTF8 secret error (2020-03-11 15:54:38 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Relax restrictions for blockdev-snapshot (allows libvirt to do live
>   storage migration with blockdev-mirror)
> - luks: Delete created files when block_crypto_co_create_opts_luks fails
> - Fix memleaks in qmp_object_add
>
> ----------------------------------------------------------------


iotest 030 hung on x86-64 Linux (Ubuntu):

petmay01 11801  0.0  0.0  34668 26112 ?        S    11:24   0:03  |
                   \_ make --output-sync -C build/alldbg check V=1 -j8
petmay01 15277  0.0  0.0   4628   792 ?        S    11:25   0:00  |
                       \_ /bin/sh
/home/petmay01/linaro/qemu-for-merges/tests/check-block.sh
petmay01 15344  0.0  0.0  14172  3360 ?        S    11:25   0:00  |
                           \_ bash ./check -makecheck -qcow2 -g auto
petmay01 27902  0.0  0.0  14172  2128 ?        S    11:25   0:00  |
                               \_ bash ./check -makecheck -qcow2 -g
auto
petmay01 27903  0.0  0.0  52660 16400 ?        S    11:25   0:00  |
                                   \_ python3 -B 030
petmay01  1728  0.0  0.1 1011792 51604 ?       Sl   11:26   0:01  |
                                       \_
/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
-display none -vga none -chardev
socket,id=mon,path=/tmp/tmp.QBQTAAybTi/qemu-27903-monitor.sock -mon
chardev=mon,mode=control -qtest
unix:path=/tmp/tmp.QBQTAAybTi/qemu-27903-qtest.sock -accel qtest
-nodefaults -display none -accel qtest -drive
if=virtio,id=drive0,file=blkdebug::/home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/scratch/test.img,format=qcow2,cache=writeback,aio=threads,backing.node-name=mid,backing.backing.node-name=base

I had to manually kill the offending QEMU process; resulting
output in the log:

--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
 2019-07-15 17:18:35.251364738 +01
00
+++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/030.out.bad
  2020-03-12 13:44:
43.101182680 +0000
@@ -1,5 +1,27 @@
-...........................
+........................E..
+======================================================================
+ERROR: test_stream_pause (__main__.TestSingleDrive)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "030", line 93, in test_stream_pause
+    self.pause_wait('drive0')
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
line 927, in pause_wait
+    result = self.vm.qmp('query-block-jobs')
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/machine.py",
line 405, in qmp
+    return self._qmp.cmd(cmd, args=qmp_args)
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/qmp.py",
line 215, in cmd
+    return self.cmd_obj(qmp_cmd)
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/qmp.py",
line 198, in cmd_obj
+    resp = self.__json_read()
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../python/qemu/qmp.py",
line 89, in __json_read
+    data = self.__sockfile.readline()
+  File "/usr/lib/python3.6/socket.py", line 586, in readinto
+    return self._sock.recv_into(b)
+  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests.py",
line 383, in timeout
+    raise Exception(self.errmsg)
+Exception: Timeout waiting for job to pause
+
 ----------------------------------------------------------------------


thanks
-- PMM

