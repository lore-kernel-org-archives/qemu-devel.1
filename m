Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA571206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjIZ20rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA571206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGVB-0002vh-78
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTl-0000wv-S3; Tue, 30 Jun 2020 09:39:17 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTk-0006HN-8O; Tue, 30 Jun 2020 09:39:17 -0400
Received: by mail-ed1-x542.google.com with SMTP id by13so6364355edb.11;
 Tue, 30 Jun 2020 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jefwO2hbW07igdhiiukviEIpKJ3c53PohcWtrnfnQBk=;
 b=XjIZ20rxMdAmQT37YDVF6n6ig2lyfo3d0zCRUsk/Dl/E2UymrQje2ou+pwmi2Y/n77
 jg+/sTC3B9IoMx+qmS7ab897zUmaoNOWlm2nglXI7nDmlmrLOXtSlcZxmJ2+6cPcyzQB
 pwEEEIWUflp4QMQ3Zjc5ZEGpEbTy5uUKZQpqfu9qDhNJxte2L2JNR4Zwv9Qu75D8lTDq
 K5CaxgVesNy0TetcVIjmyg9p4WT+ru7Pe42kSIuZnjL9nnYUn8WE+MERvlxCP5dD85Nn
 7GQ3Oxu1vaXnmWmA41ImfmlE3JZRPGFFy8iSUmMRL5K7P9p86SXqkt67j/+gD46bhI1G
 ueSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jefwO2hbW07igdhiiukviEIpKJ3c53PohcWtrnfnQBk=;
 b=jQ07KQJJxHolTbKPih8X5qjlIAkvqvJE4lXaICMYFJ+jmAmjOAqzgaiKPI6bQkCZYi
 Quyg1NqE5k34wKB6E+E6xjW4qqH7bKP6ze1FLiaW1xG4Cgp0JamKP4i3N7edfRFFsEt8
 Bo/3JR1o3Xrq5ZHjbjm7TN5cV2Y6RKTCyUEBbwRuy3VC8oTM0mhwzjhF135WM5do4aqH
 4l+sdg7PLnKa0tln35V5RmVXmyehmPUQAr5e87Hm96qw6yAizg0w7B8e3ztA5EnFpqWJ
 r8I6vjRXNBuwG6iRi5FdnM9jkU19mew+u0Kr/MpwC95CREDbbzEAsxjwqe61TWb+oxxR
 iddg==
X-Gm-Message-State: AOAM532ox9xjikjWevFfFAQFk0iRbPWT9zoEZlpmTxnkYzbbr7kFCEfB
 R8MDdQ/O3Xhj/OOB9Sd6VIwdL4Kc/Ic=
X-Google-Smtp-Source: ABdhPJx1SNkS47OQ7gSZkfqrZJvkZRIGdlvMKAuUVMD5AiWJpgAszoij7L3WxEW82UxNMP+rMIHCzA==
X-Received: by 2002:a50:931e:: with SMTP id m30mr23995122eda.341.1593524353801; 
 Tue, 30 Jun 2020 06:39:13 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/17] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
Date: Tue, 30 Jun 2020 15:38:54 +0200
Message-Id: <20200630133912.9428-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patches 5 & 6 fix CVE-2020-13253.
The rest are (accumulated) cleanups.

Since v6: Handle -ENOMEDIUM error
Since v5: Fix incorrect use of sd_addr_to_wpnum() in sd_reset()

Missing review:
[PATCH 01/15] MAINTAINERS: Cc qemu-block mailing list
[PATCH 03/15] hw/sd/sdcard: Move some definitions to use them
[PATCH 04/15] hw/sd/sdcard: Use the HWBLOCK_SIZE definition
[PATCH 05/15] hw/sd/sdcard: Do not switch to ReceivingData if
[PATCH 07/15] hw/sd/sdcard: Move sd->size initialization
[PATCH 08/15] hw/sd/sdcard: Call sd_addr_to_wpnum where used, consider zero size
[PATCH 09/15] hw/sd/sdcard: Special case the -ENOMEDIUM error
[PATCH 10/15] hw/sd/sdcard: Check address is in range
[PATCH 14/15] hw/sd/sdcard: Make iolen unsigned
[PATCH 15/15] hw/sd/sdcard: Correctly display the command name in trace

$ git backport-diff -u v6
$ git backport-diff -u sd_cve_2020_13253-v6 -r origin/master..
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/17:[----] [--] 'MAINTAINERS: Cc qemu-block mailing list'
002/17:[----] [--] 'hw/sd/sdcard: Update coding style to make checkpatch.pl happy'
003/17:[----] [--] 'hw/sd/sdcard: Move some definitions to use them earlier'
004/17:[----] [--] 'hw/sd/sdcard: Use the HWBLOCK_SIZE definition'
005/17:[----] [--] 'hw/sd/sdcard: Do not switch to ReceivingData if address is invalid'
006/17:[----] [--] 'hw/sd/sdcard: Restrict Class 6 commands to SCSD cards'
007/17:[down] 'hw/sd/sdcard: Move sd->size initialization'
008/17:[down] 'hw/sd/sdcard: Call sd_addr_to_wpnum where it is used, consider zero size'
009/17:[down] 'hw/sd/sdcard: Special case the -ENOMEDIUM error'
010/17:[0004] [FC] 'hw/sd/sdcard: Check address is in range'
011/17:[----] [--] 'hw/sd/sdcard: Update the SDState documentation'
012/17:[----] [--] 'hw/sd/sdcard: Simplify cmd_valid_while_locked()'
013/17:[----] [--] 'hw/sd/sdcard: Constify sd_crc*()'s message argument'
014/17:[----] [--] 'hw/sd/sdcard: Make iolen unsigned'
015/17:[----] [--] 'hw/sd/sdcard: Correctly display the command name in trace events'
016/17:[----] [--] 'hw/sd/sdcard: Display offset in read/write_data() trace events'
017/17:[----] [--] 'hw/sd/sdcard: Simplify realize() a bit'

Philippe Mathieu-Daudé (17):
  MAINTAINERS: Cc qemu-block mailing list
  hw/sd/sdcard: Update coding style to make checkpatch.pl happy
  hw/sd/sdcard: Move some definitions to use them earlier
  hw/sd/sdcard: Use the HWBLOCK_SIZE definition
  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
  hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
  hw/sd/sdcard: Move sd->size initialization
  hw/sd/sdcard: Call sd_addr_to_wpnum where it is used, consider zero
    size
  hw/sd/sdcard: Special case the -ENOMEDIUM error
  hw/sd/sdcard: Check address is in range
  hw/sd/sdcard: Update the SDState documentation
  hw/sd/sdcard: Simplify cmd_valid_while_locked()
  hw/sd/sdcard: Constify sd_crc*()'s message argument
  hw/sd/sdcard: Make iolen unsigned
  hw/sd/sdcard: Correctly display the command name in trace events
  hw/sd/sdcard: Display offset in read/write_data() trace events
  hw/sd/sdcard: Simplify realize() a bit

 hw/sd/sd.c         | 189 +++++++++++++++++++++++++++++----------------
 MAINTAINERS        |   1 +
 hw/sd/trace-events |   4 +-
 3 files changed, 124 insertions(+), 70 deletions(-)

-- 
2.21.3


