Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AAEC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED150206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rq+2qMsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED150206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8WQ-0003PF-3V
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8VY-00025c-Nf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:40 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kD8VX-00026E-2W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:47:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id a8so734372plm.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ZDsCNyj6WhZAOI4rsJioOTLR6n+cb2uPbSrQX9rvh4Y=;
 b=Rq+2qMsY7ox6cgTOMCLe8fsuOhoyDlCEdJodfaSg8cuI+uG1QAlrDFT9RqKiIqncgH
 AWIQPN2F48bvC18Yjm8EXKKttd1VPuzf/Bn4Dcqo0CkyglpbyTjuNob42L8oIuWPOql/
 9fnbQAOdfp+MXL36LkbtPBXLf9TtV1ttdd2ClmbTlZe2Q+pDNyMyx3czw6z+La7RrHuj
 1e2vcodwpIoLipygFrd68Zo89U5nn3eJ2YcCO3t4ocpx0FQxnwPuU1ehZRUwSclF9Pey
 X1t7Gows7fcEU8qqFCGa/8MPrMecvSdPP5Xrfutx6svZD6h7csDmnHHpBOl9YEfFHUBi
 s19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZDsCNyj6WhZAOI4rsJioOTLR6n+cb2uPbSrQX9rvh4Y=;
 b=mKEdd88Rl6xytMng5H3YCOXgE/5APpOB7PTarzcSyMikgqDFiZqbbxWpey1AzgRF8E
 3p/xlqFQQfI5gb2RH/COIxdCuFk8lFUHdzer7ECJDXawVG14nukQtps1deVY292QxeiI
 ypncOWWft3JcP+axHRWQG5VyR0CR2Qg9au9MvaQnoR9MOc/rjVLr7zJLWueS9ZLrjE5j
 p40bhIaKdcosR5G5k1jgx7vwFBpsPWUeownV/72GLhAoGo3ro9nAoV83YyyRDKjvZf/0
 9Pp4Lxm3Dpt7tvOdfGyujV8k/vIn5rJlldyyaI81HzSuTE+lgqGmAgxDX4lZK7z+6Cxe
 rPaQ==
X-Gm-Message-State: AOAM533ZDhvn3xn3gj2VDW8t/LUnB9ROpU8WRobC9joDr/c0fzdpzPkx
 qTF8d100OVQ50Hg8hxJCJ+KcbQ==
X-Google-Smtp-Source: ABdhPJwpxAj4plms/efop/+9Zf8UwUqvxO8y9Diwu3+gsjM0KlBvjIm6imUgbmkBZAjTL7D+QXbC+A==
X-Received: by 2002:a17:90b:34e:: with SMTP id
 fh14mr2196202pjb.186.1598975257318; 
 Tue, 01 Sep 2020 08:47:37 -0700 (PDT)
Received: from localhost.localdomain (111-241-104-82.dynamic-ip.hinet.net.
 [111.241.104.82])
 by smtp.gmail.com with ESMTPSA id e17sm2485344pfm.60.2020.09.01.08.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:47:36 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v5 0/2] Add file-backed and write-once features to OTP
Date: Tue,  1 Sep 2020 23:47:09 +0800
Message-Id: <20200901154711.18457-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=green.wan@sifive.com; helo=mail-pl1-x644.google.com
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based RFC v4 to fix:
 - Change the patch order
 - Add write operation to update pdin to fuse[] bit by bit 
 - Fix wrong protection for offset 0x0~0x38
 - Add SIFIVE_U_OTP_PWE_EN definition
 - Refine access macro for fuse[] and fuse_wo[]

Summary of Patches 
 - First patch is to add write opertion to update pdin data to fuse[] bit
   by bit. Add 'write-once' feature to block second write to same bit of
   the OTP memory.

 - Second patch is to add file-backed implementation to allow users to use
   '-drive' to assign an OTP raw image file. OTP image file must be bigger
   than 16K.

       For example, '-drive if=none,format=raw,file=otp.img'

Testing
 - Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/riscv: sifive_u: Add write operation and write-once protection
  hw/riscv: sifive_u: Add backend drive support

 hw/riscv/sifive_u_otp.c         | 80 ++++++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u_otp.h |  5 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.17.1


