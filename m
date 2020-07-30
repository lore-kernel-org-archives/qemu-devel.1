Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543C222B48
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 02:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9k0t6eR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543C222B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ykR-0008Jq-Je
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 22:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.n.huhn@gmail.com>)
 id 1k0yji-0007Yk-Dp
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 22:56:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif.n.huhn@gmail.com>)
 id 1k0yjg-00010p-Fc
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 22:56:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id q76so3600676wme.4
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 19:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=je+6b8E2cDEw2VievIHp/3ty1EbLbxkNjcOvLSlJz84=;
 b=A9k0t6eRY7nZuKtA2NkPGxDlWFV8/pyvjBo+f+0i7MfmGiqj09bvN30djhsVGhE7ij
 pPPwUqFUOkjCSYB9l+MeBde9SQUmgv3oQX4iyo/Ua7CHKhuNCM7HGVDB6Ii2/6qaIq+S
 /mwpBYXkN4q+BICT0BcxkpNYr2FJ5s0HPv4bD4QKmvZp3un9MGE22OraLoo58i7iNeRm
 j8H2T+F46LzlmiZsrFMF7wAEw/KRZTBRPR+BO5FJATRJGK5A11u88/OBOWrdeXklRaP+
 b6/Lw0zNXr6lH0Q6owj7BpawGX7w02VmDSu15Mg9E9/sRkgNKhN/Ob5HFqvCnjUiXLqT
 un8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=je+6b8E2cDEw2VievIHp/3ty1EbLbxkNjcOvLSlJz84=;
 b=KzIax6K4VOqPg/Eh8qZRocUdubGSr3HNzNACGzX/rTwnWpAyANasnr7zNoT452YmTS
 fT15UEOiXRPkCDp0ZQGAyj6K62zww0jMDCYnSATXh4Yg5nWsSozjGbqiiN12LoBmKCP0
 BI6lTRcqO+SW8P3MKr+VhimGOJrxUfPnDoZGP52vjE/i+eDEb/vOSpu00mcxs7SFrraf
 u8zUUuQhP91JCXTg5xFE+fwkhzZI+o1CLZUUEhTFInUwBUFKIKYrFevuh+dqzm6apPTg
 0uznaL7b80M0FZi+dqEaeGaVLqpKD6rMRsYE8wltazEP41RKpAk3ny90rDKudUht8VFZ
 Za/g==
X-Gm-Message-State: AOAM530JpDlAn6WKXCeH/Sy+fnZ/9EQPGyCG/gqR2D9Lk/EZ54WerE1d
 zX3JUFD8bMX0b9Cgabw3NRZ2sTFb
X-Google-Smtp-Source: ABdhPJxsdNwckfrc5I3LW+wOBdjgQhaaU5XgLoKYov6M72SCpGUPu1TMEBy8W/rJBf/mUE86z0KUdw==
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr8947011wml.163.1596077757883; 
 Wed, 29 Jul 2020 19:55:57 -0700 (PDT)
Received: from lhuhn.localdomain
 (24-148-42-188.s4794.c3-0.grn-cbr1.chi-grn.il.cable.rcncustomer.com.
 [24.148.42.188])
 by smtp.gmail.com with ESMTPSA id p25sm6958025wma.39.2020.07.29.19.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 19:55:57 -0700 (PDT)
From: Leif N Huhn <leif.n.huhn@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] linux-user: Add support for SG_IO and SG_GET_VERSION_NUM
 raw SCSI ioctls
Date: Wed, 29 Jul 2020 21:55:47 -0500
Message-Id: <20200730025548.237905-1-leif.n.huhn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=leif.n.huhn@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Leif N Huhn <leif.n.huhn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi. This is my first time trying to contribute to qemu. This patch
works correctly for architectures with the same bit-width, for example
32bit arm host and i386 user binary. Here is an example with the sg_simple2
executable from https://github.com/hreinecke/sg3_utils

32-bit ARM native:

  strace -e trace=ioctl ./sg_simple2 /dev/sg0
  ioctl(3, SG_GET_VERSION_NUM, [30536])   = 0
  ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_FROM_DEV, cmd_len=6, cmdp="\x12\x00\x00\x00\x60\x00", mx_sb_len=32, iovec_count=0, dxfer_len=96, timeout=20000, flags=0, dxferp="\x05\x80\x00\x32\x5b\x00\x00\x00\x48\x4c\x2d\x44\x54\x2d\x53\x54\x42\x44\x2d\x52\x45\x20\x20\x57\x48\x31\x36\x4e\x53\x34\x30\x20"..., status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
  Some of the INQUIRY command's results:
      HL-DT-ST  BD-RE  WH16NS40   1.05  [wide=0 sync=0 cmdque=0 sftre=0]
  ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_NONE, cmd_len=6, cmdp="\x00\x00\x00\x00\x00\x00", mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=20000, flags=0, status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=4, info=0}) = 0
  Test Unit Ready successful so unit is ready!
  +++ exited with 0 +++

i386 binary on 32-bit arm host:

  strace -f -e trace=ioctl qemu/build/i386-linux-user/qemu-i386 sg3_utils/examples/sg_simple2 /dev/sg0
  strace: Process 690 attached
  [pid   689] ioctl(3, SG_GET_VERSION_NUM, [30536]) = 0
  [pid   689] ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_FROM_DEV, cmd_len=6, cmdp="\x12\x00\x00\x00\x60\x00", mx_sb_len=32, iovec_count=0, dxfer_len=96, timeout=20000, flags=0, dxferp="\x05\x80\x00\x32\x5b\x00\x00\x00\x48\x4c\x2d\x44\x54\x2d\x53\x54\x42\x44\x2d\x52\x45\x20\x20\x57\x48\x31\x36\x4e\x53\x34\x30\x20"..., status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
  Some of the INQUIRY command's results:
      HL-DT-ST  BD-RE  WH16NS40   1.05  [wide=0 sync=0 cmdque=0 sftre=0]
  [pid   689] ioctl(3, SG_IO, {interface_id='S', dxfer_direction=SG_DXFER_NONE, cmd_len=6, cmdp="\x00\x00\x00\x00\x00\x00", mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=20000, flags=0, status=0, masked_status=0, msg_status=0, sb_len_wr=0, sbp="", host_status=0, driver_status=0, resid=0, duration=3, info=0}) = 0
  Test Unit Ready successful so unit is ready!
  [pid   690] +++ exited with 0 +++
  +++ exited with 0 +++

However when I try i386 guest on x86_64 host, the cmdp bytes in the
first SG_IO call are zero, incorrectly. I assume that is because I need
to write a special ioctl handler. Is that correct? Should I be calling
lock_user(VERIFY_WRITE...) to copy the buffers over?

Also, is the current patch acceptable as is, or does it need to be
reworked until the ioctl works with different architecture bit-widths?

Thanks!

Leif N Huhn (1):
  linux-user: Add support for SG_IO and SG_GET_VERSION_NUM raw SCSI
    ioctls

 linux-user/ioctls.h        |  2 ++
 linux-user/syscall.c       |  1 +
 linux-user/syscall_defs.h  | 33 +++++++++++++++++++++++++++++++++
 linux-user/syscall_types.h |  5 +++++
 4 files changed, 41 insertions(+)

-- 
2.28.0


