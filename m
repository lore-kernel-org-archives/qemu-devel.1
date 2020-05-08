Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E324AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF74206D3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="HTptYX1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF74206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWvLs-0004ws-NO
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 01:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWvKy-000496-9C
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:14:16 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWvKv-00055F-Gd
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:14:16 -0400
Received: by mail-pj1-x1041.google.com with SMTP id hi11so3723713pjb.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QOtqGyEJpUTLx+cPS0nOVZY9irhcSsfmy5lGrFkJCF0=;
 b=HTptYX1Hb3ash1icIcePvl0oCcOy0gYXHbanffUMJyLCWHaMyxYWvd1Py1NmI3q+rq
 cnKbqjpTwU6LchnHxaNLFzN6QIuIgVSipmWJhLYK5F2Bk8cntD5VBnuJMEANzkYkljEO
 k92aufH7qA5asTwSlmpRUJAWXAO4v9pMw4VEkAcyhJE0QMj+8PhKYEwX94mb53dF8RwC
 ICY1nuGOIlXCSrMvQtqfdhzjtpJP5+hhPngTcO/WZPrYBuPi1MZhSE403Gi/aFU81ANQ
 EQqzxmvJfcnUrO5VA/mh2ZK8l7bP0HQ2SDyYEnS874oW2XCsLfn42Soxo2k+VRyVzZA3
 Dy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QOtqGyEJpUTLx+cPS0nOVZY9irhcSsfmy5lGrFkJCF0=;
 b=hWVgi06pAHVPMLBfziGP9py7eGn9HHBqELOcfL1Wli9ho2XWt5xys2pOMIICu8AKul
 ocvQUqiQH73wrnYjPJlTvh2KvlAiDX+PcjDTA71brHCgBe+m/VqPv+Y6vSUKno+S2bVM
 DGP9e08nRPkrSdXkNnNFJnDj5ByWhG0BKdDLblBO0BgNPZk/NYZBTbws8q0ff8MWJ0cY
 EHZeN/YzJ8TMPgPTRvFMAsi30F9zmSj8W+IQ4/mbKRKzqWFF1rbLFzbn9ARxss11PJO8
 2c8N+q3ult/bcXbbrgqTSYJkfOE6PFPdrGyfejlorayYMaO0AV9MnzNFrlUIhBiLaggs
 aUqQ==
X-Gm-Message-State: AGi0PuY8TGzs2ejYozOW/vwchngJkO603DW8Rqem4pdX68rSt54izz38
 fxBT2jiYs6tY/Kk7ZtO/SEuszQ==
X-Google-Smtp-Source: APiQypKx40PLa/wSDNMk728RDnadleRWSE5SZgiVvXSPjKwL5r2bJEbkI3gcP7tSD0O0he2ub8W2kw==
X-Received: by 2002:a17:902:7249:: with SMTP id c9mr692589pll.23.1588914850742; 
 Thu, 07 May 2020 22:14:10 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id b15sm477050pfd.139.2020.05.07.22.14.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 May 2020 22:14:10 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, lifeng1519@gmail.com, dimastep@yandex-team.ru,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 1/2] io/channel: fix crash when qio_channel_readv_all
 return 0
Date: Fri,  8 May 2020 13:14:40 +0800
Message-Id: <20200508051441.8143-2-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200508051441.8143-1-fengli@smartx.com>
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Root cause:
From `man recvmsg`, the RETURN VALUE says:
These  calls return the number of bytes received, or -1 if an error occurred.
In the event of an error, errno is set to indicate the error.
The return value will be 0 when the peer has performed an orderly shutdown.

When an error happens, the socket will be closed, and recvmsg return 0,
then error_setg will trigger a crash.

This unit test could reproduce this issue:
tests/test-char -p /char/socket/client/reconnect-error/unix

The core file backtrace is :

(gdb) bt
    #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
    #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
    #2  0x00005555555aaa94 in error_handle_fatal (errp=<optimized out>, err=0x7fffec0012d0) at util/error.c:40
    #3  0x00005555555aab6d in error_setv (errp=0x555555802a08 <error_abort>, src=0x5555555c4280 "io/channel.c", line=148,
        func=0x5555555c4580 <__func__.17489> "qio_channel_readv_all", err_class=ERROR_CLASS_GENERIC_ERROR,
        fmt=<optimized out>, ap=0x7ffff423bae0, suffix=0x0) at util/error.c:73
    #4  0x00005555555aacf0 in error_setg_internal (errp=errp@entry=0x555555802a08 <error_abort>,
        src=src@entry=0x5555555c4280 "io/channel.c", line=line@entry=148,
        func=func@entry=0x5555555c4580 <__func__.17489> "qio_channel_readv_all",
        fmt=fmt@entry=0x5555555c43a0 "Unexpected end-of-file before all bytes were read") at util/error.c:97
    #5  0x000055555556c25c in qio_channel_readv_all (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>,
        errp=0x555555802a08 <error_abort>) at io/channel.c:147
    #6  0x000055555556c29a in qio_channel_read_all (ioc=<optimized out>, buf=<optimized out>, buflen=<optimized out>,
        errp=<optimized out>) at io/channel.c:247
    #7  0x000055555556ad22 in char_socket_ping_pong (ioc=0x7fffec0008c0) at tests/test-char.c:732
    #8  0x000055555556ae12 in char_socket_client_server_thread (data=data@entry=0x55555582e350) at tests/test-char.c:891
    #9  0x00005555555a95b6 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
    #10 0x00007ffff5e61e25 in start_thread () from /lib64/libpthread.so.0
    #11 0x00007ffff5b8bbad in clone () from /lib64/libc.so.6

Signed-off-by: Li Feng <fengli@smartx.com>
---
 io/channel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/io/channel.c b/io/channel.c
index e4376eb0bc..1a4a505f01 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -144,8 +144,6 @@ int qio_channel_readv_all(QIOChannel *ioc,
 
     if (ret == 0) {
         ret = -1;
-        error_setg(errp,
-                   "Unexpected end-of-file before all bytes were read");
     } else if (ret == 1) {
         ret = 0;
     }
-- 
2.11.0


