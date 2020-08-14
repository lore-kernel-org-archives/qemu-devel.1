Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9429C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CEA20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gyoug52D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CEA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bcL-0000ce-0O
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQh-00048t-UC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQf-0007fN-2Q
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418137; x=1628954137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PnPVgupWkcTye0mgiZsmJRw6xGGap8+1yaKVcLcBTOY=;
 b=Gyoug52DF1m2i9cbYaqC/xstcWc1lLoIY47QeBtZZDFRS8OtsNEOBha/
 0zFJipnQ+xj4FCxf2704RJSrEmbOVNg3vQy7xiD/kB3jbbnNQab9+6hRD
 qZdqDwz6voUWGUBQSQwFDYvDhUx+8VsXJQsHjB2Sp0LdhsYjNctdjlRpE
 8NcX4Y206qvGuxsq0n9LGsg1wxDp+ajsEGerdGUa7umyhmPGPY+uPphW4
 3iSn66z3a5/VipYFhzbOLgJKtwTjVms5Fg0EsHDCQKDJgQvfkucPZHUbm
 3ubjH9XbWRa1BMM2jKHPZSQlanlJ0sm3akEuSHFcwP6o2RM8OAIOh7qeU Q==;
IronPort-SDR: W3Ss87R/KrhqAM9dLDjxeGFjQMZeQiKcjlyx2U20swwzeu8kpT95UpMLW/kCZE8aKgI+9bm7UB
 UeuNUQ51xBMSjWRh5SS1BWbu6cKwUg5idMwJEpVdlz3hmJ1RYFEU1PbXW8fnSLzDqqMzIBGN0y
 QR9ICGdsDOfCtbIG82wj5Edb6xzxDXXL9LiNO8ydfwYTlPXGRCPEw6EiRH5Ig55sgd4zjc+q99
 Q+9E2l2s7doGO+ChuxUy9NVghZPhFlKo3mKgl3llg+Kv561X9kmKqvA2G3jiK0Rr+x39/E2b9r
 Vh8=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994829"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:14 +0800
IronPort-SDR: 8Io5ky9Oszt9gDALyh8ONq3Hr4iktZNu0npzNEajKGAp5Ys1Ueymz7p9+pesUKOQwOk1X4w5ca
 a+0R18cwQvbg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:18 -0700
IronPort-SDR: PUHFSyTpCSZjZoG3+cUmWTJeSgxrEZaJecTzmkuwtW0+MJyLpNgvDKkFul2bXTPY3BdbLbnQ3o
 tX/fA6Bc3TDw==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:13 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/20] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Fri, 14 Aug 2020 08:04:56 -0700
Message-Id: <20200814150506.2070566-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now we need to ship the OpenSBI fw_dynamic.elf image for the
RISC-V Spike machine, it requires us to create symbolic links
for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596439832-29238-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 2acc4d1465..790b21d4a5 100755
--- a/configure
+++ b/configure
@@ -8545,6 +8545,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.27.0


