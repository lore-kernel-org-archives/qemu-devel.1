Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88183C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044FB206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnuf8X1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044FB206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpRN-0007UN-O0
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ6-0005hl-98
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ4-0004XM-Ur
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ4-0004TW-Iy; Tue, 21 Apr 2020 05:42:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id e26so2788462wmk.5;
 Tue, 21 Apr 2020 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uE+gBHKeiE5s7w8srdVRXCj+RV3+IpHFF8UjUpro0+g=;
 b=cnuf8X1KHLFuVHca/tJCjt43HMId4+7LwWIWB/GnXL/lLTz8KACuUfl/bk9CB6cQnF
 /eSK1iXBOm7SvhSe+9SJuplr/QE2PHUDZDgik760kOkECLDFZlx0qTH48wjYQhc+9x7t
 nleNx4GC2BsrPMx/dhzHB/b2MaM1Qh5gJDLai2cKMHBB62cEbEe8PiaIPA1m7ivgYbbl
 aPaGTDdAVXl0Vz14qX4QKBfszxMdNBPXJzo0DpD2wzxprCNwfwdQDeUe0GdJrWZivuCV
 BE99CO2Oh5ZAPEj+3AitCf2U35ISdeNFlkXd5lS8zTglpuLFd3Y28wfkLAQkY0IUE2H9
 9/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uE+gBHKeiE5s7w8srdVRXCj+RV3+IpHFF8UjUpro0+g=;
 b=JeeHoO8Cfu4AIrmHSzRTgTj5LUL6Alsok/KjgfMoziOE9JsIcb2dzni0S9xMcyNjJf
 omoHeTUd+m/Yk4sPyzser06BadmpIR5hG3Zfa1tJY4Vd0BrNQxlifp8Rq83uOX/W0Noh
 xJnfJx419sN5Rw+sjE6UeXVkqONJ1qwwBxcWI2oFiBFl0BZiQAFQE1lXIWYdKplBtBkC
 DslrKakjkD/9e3jxNzxAPQrPocBULjxnkVFVK+wrpiFJ97r7LxD69MYlSeOHcFVUpVfQ
 AlIwaiJSqGFX7Ps2zDv6Qfsdp2SgNSzP/j00XXUY20Lul3RdcyFGYchL1zJBZKxmuGzU
 3gNw==
X-Gm-Message-State: AGi0PuZc9TZ7IPsORaeIXmuOEw14QUJ4B2sKVAxYUqzBmPckYvhnD1C5
 nnTwu/bD2sl4G5Oo+k2+2M6PEaSxfqc=
X-Google-Smtp-Source: APiQypJ/z7Jlq2SG+A93Ur/nRjAZwkIA8Rf8Td1uTUK1QDy5Zdo3vXSoD3aSck3HHzJqwpV0AqjK+w==
X-Received: by 2002:a1c:96c6:: with SMTP id y189mr4252040wmd.106.1587462138183; 
 Tue, 21 Apr 2020 02:42:18 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b22sm3082814wmj.1.2020.04.21.02.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:42:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] scripts: More Python fixes
Date: Tue, 21 Apr 2020 11:42:12 +0200
Message-Id: <20200421094216.24927-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial Python3 fixes, again...

Philippe Mathieu-Daudé (4):
  MAINTAINERS: Cover the GDB Python scripts in the gdbstub section
  scripts/qemugdb: Remove shebang header
  scripts/qmp: Use Python 3 interpreter
  scripts/qmp: Fix QEMU Python scripts path

 MAINTAINERS                  | 1 +
 scripts/qemugdb/__init__.py  | 3 +--
 scripts/qemugdb/aio.py       | 3 +--
 scripts/qemugdb/coroutine.py | 3 +--
 scripts/qemugdb/mtree.py     | 4 +---
 scripts/qemugdb/tcg.py       | 1 -
 scripts/qmp/qmp              | 4 +++-
 scripts/qmp/qom-fuse         | 4 +++-
 scripts/qmp/qom-get          | 6 ++++--
 scripts/qmp/qom-list         | 6 ++++--
 scripts/qmp/qom-set          | 6 ++++--
 scripts/qmp/qom-tree         | 6 ++++--
 12 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.21.1


