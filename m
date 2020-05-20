Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6357CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A33F2072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GK3nxaqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A33F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRj2-0006jU-Ar
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRi0-0005Bx-ME; Wed, 20 May 2020 12:36:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRhy-0002lX-Sb; Wed, 20 May 2020 12:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589992603; x=1621528603;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xuST64lSQI4MP5MnAyrlyrGzoU5swXUNK7vHX545Zhc=;
 b=GK3nxaqJn3KvTtG39E8Y52uTw6vUp5WeQ+AecLJcfHoqZr5Sph8nzf74
 wybLe9cH/Zw/xaK8TyXBtj5i2FAaCS8JKNDU0o1AZ0lSD4DJS4OZ3kGYZ
 aSs8Zkk4BTPLLPC7wbmtZ5gEedOeUvPPzi6i4H/QIvjotlIq1fimKNA0+
 gD/mQ9lNPSgnkDB808yy2fPAaBg0SnUHXn4lvDQu3lviCP87FsvTKzRDz
 gNdphoX5y5NkDx3RGsMfzfdeUIrVi4NOgy9cKliGXes67HgBPkaZPgslt
 KiAVXd98zUYryrgDyUekOvT9RT4nThCyRfLpJCf+XzE58m+de6Cf6BEki g==;
IronPort-SDR: 0Vfw5LMZpsioZjdAYZq1BDb+Mf1gILMKSg+3SeZrtk1a7GVttKzhJ0SZKNW0/Le+pNECVd6U2n
 fX5Ma4OBQUzFBZMZLdKQH96091OzyUSH2UuvgyXnk0hOtKqLj/cuTL023JCdd7uaC5aguZ7E+F
 gsgcV7Yzk5+BvJzOA4/PcxCxZJNUTllsUDAds8645sWUCyDNm4fxisPM9N6YDRFSUYDYDSLYb8
 XQIz2m1s2lYGI9Q4Mkq4FtUci0PWjyymCF2aheCEVSvfU2PnBu1haFmg1/3fHiPWRbWFEdcuEq
 9Z8=
X-IronPort-AV: E=Sophos;i="5.73,414,1583164800"; d="scan'208";a="138468207"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 00:36:38 +0800
IronPort-SDR: wfZSq2ypkXZd9OHKdf+Jvd40TQkeHj8QPzmQ4syjfKwwZKy0mK+lz4BKPJwImhjuzLlpclAywx
 wPCuqWwrkNp1QPM+rWt6nNoCUaJkGpIx0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 09:26:40 -0700
IronPort-SDR: tm166kVNQ001OILkzYpvoih8yDWiwuiyvwccTDZ5kiLQ1KAEB9COAlCxJiTeHZc2hoxf169+mb
 WLVN+up8aiUQ==
WDCIronportException: Internal
Received: from 96yhgc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.51])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2020 09:36:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 0/2]  Add support for the HiFive1 revB
Date: Wed, 20 May 2020 09:28:10 -0700
Message-Id: <cover.1589992028.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=40290bcd2=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 12:36:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, palmer@dabbelt.com,
 bmeng.cn@gmail.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Add support for the HiFive1 revB board. We don't want to break current
users so this is added as an option that is disabled by default. The
main change is the address that we jump to at boot.

v2:
 - Add a cover letter


Alistair Francis (2):
  riscv: sifive_e: Manually define the machine
  sifive_e: Support the revB machine

 include/hw/riscv/sifive_e.h |  5 +++
 hw/riscv/sifive_e.c         | 76 +++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.26.2


