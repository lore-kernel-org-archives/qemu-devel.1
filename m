Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49456C3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1883F2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 01:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLXuYRiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1883F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Pwn-0002r3-6q
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 21:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2PvU-0001zR-1b
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2PvS-00088S-Nm
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 21:05:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2PvS-00086Y-GZ; Mon, 26 Aug 2019 21:05:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id u16so17042123wrr.0;
 Mon, 26 Aug 2019 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcLEecb3y6+euf7Mop9NK0ebM4GP3zquDMP+2Ky43Yk=;
 b=cLXuYRiOqyCC9gs1NBMlnw53bwK7nENxC5+cmgX/gAw3pqF8zqlWXIvQRCpgMAHvuy
 fccGHv9uG9qlk/0ISWb6SP2DjQGgngOzEf6SaEj6vchI/qczsYEskkmHPLKHsnLRhbXx
 JTHwh1Czy20VmVieEHxKd5k2t6JqrU2ZPPCQfIG3ep5eJULT7a/U48NG6wiz50o6DGTf
 feachkXiAf3ygDIqN8+9U4kZ3ziKH+JFfBwB58xAIThW0aG+nIPt+upCVP2t0b0Qu3Io
 R6esaKvHWxiOg6SHi6DH7FwuwQRmeTLY4POqjjbtKAIxKHMu4YGD7D8vYRMmOF7peGxX
 Xpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcLEecb3y6+euf7Mop9NK0ebM4GP3zquDMP+2Ky43Yk=;
 b=h8pjFEil+uedFD3PNtlO3vZSYjwYtxoAUBtu1bq04AKhQMf42AaPZF36tC8hghB65b
 uYch0xAWvuLbxZJz6iQ1oZ14615vPEPDdKaAWJiw30ZuOJLP4Oeix9b6M4rm+QAYsFcb
 /zRGtRwW5BSujRA24Vx68FgvRgsBrSYfjR9pJYMPnlpQpe23jioZvVIjPXvCO4rfCWP/
 OWnezLc7Qcre0GxhXdUGI+Tv3rMaBbcrc0XpYPwt5F1wOAFeiJQpBbtHGakA2+6AX88S
 sUIpoeJ3ABmLxCs1O/OXnDUQ0527Z1GqpOv8YMa1R+XdkJxY7pJLEAp6KCPvkUwyblcW
 cyTA==
X-Gm-Message-State: APjAAAVRS6yqPNIy+hVOFom/dlfT2CPC2iSIKq9ffOwb2hugbtVaXEYq
 2QKuZrAte3CFHmywcvNjOVxMoIkMH1c=
X-Google-Smtp-Source: APXvYqzJigMSh7BtUcK3LdT0F+ppxshfpw/fy48bgUzt5w37IykiKGPbE41iCuBvXyhK/QVKZJJTxw==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr21552639wrr.194.1566867932319; 
 Mon, 26 Aug 2019 18:05:32 -0700 (PDT)
Received: from sparse-local.redhat.com (93-172-125-206.bb.netvision.net.il.
 [93.172.125.206])
 by smtp.gmail.com with ESMTPSA id v7sm14161572wrn.41.2019.08.26.18.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 18:05:30 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 04:05:26 +0300
Message-Id: <20190827010528.8818-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 0/2] Optimize alignment probing
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When probing unallocated area on remote XFS filesystem we cannot detect request
alignment and we fallback to safe value which may not be optimal. Avoid this
fallback by always allocating the first block when creating a new image or
resizing empty image.

Tested with all formats:

    for fmt in raw bochs cloop parallels qcow qcow2 qed vdi vpc vhdx vmdk luks dmg; do
        ./check -$fmt
    done

Changes in v3:
- Allocating first block works now when 512 <= size < 4096, storage sector size
  is 512 bytes, and using block_resize with O_DIRECT (Max)
- Fix return value on errors if qemu_vfree() modified errno (Eric)
- Improve comment about using allocate_first_block in FALLOC mode (Max)
- Remove unneeded $(()) in _filter_block (Max)
- Add _default_cache_mode and _supported_cache_mode to new test (Max)
- Fix disk size in vmdk tests

v2 was here:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg01265.html

Changes in v2:
- Support file descriptor opened with O_DIRECT (e.g. in block_resize) (Max)
- Remove unneeded change in 160 (Max)
- Fix block filter in 175 on filesystem allocating extra blocks (Max)
- Comment why we ignore errors in allocte_first_block() (Max)
- Comment why allocate_first_block() is needed in FALLOC mode (Max)
- Clarify commit message about user visible changes (Maxim)
- Fix 178.out.qcow2
- Fix 150.out with -qcow2 by splitting to 150.out.{raw,qcow2}
- Add test for allocate_first_block() with block_resize (Max)
- Drop provisioning tests results since I ran them only once

v1 was here:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00821.html

Nir Soffer (2):
  block: posix: Always allocate the first block
  iotests: Test allocate_first_block() with O_DIRECT

 block/file-posix.c                            | 51 +++++++++++++++++++
 tests/qemu-iotests/059.out                    |  2 +-
 tests/qemu-iotests/{150.out => 150.out.qcow2} |  0
 tests/qemu-iotests/150.out.raw                | 12 +++++
 tests/qemu-iotests/175                        | 47 ++++++++++++++---
 tests/qemu-iotests/175.out                    | 16 ++++--
 tests/qemu-iotests/178.out.qcow2              |  4 +-
 tests/qemu-iotests/221.out                    | 12 +++--
 tests/qemu-iotests/253.out                    | 12 +++--
 9 files changed, 135 insertions(+), 21 deletions(-)
 rename tests/qemu-iotests/{150.out => 150.out.qcow2} (100%)
 create mode 100644 tests/qemu-iotests/150.out.raw

-- 
2.20.1


