Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3647D206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxLKUJwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3647D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmiq-0006UD-D6
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmhx-0005TX-NY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnmhv-0003dr-H6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592933258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t2F+AcWEb4clUdxV3QmHayEZG+Q2SVmpDbgPn5tA3NU=;
 b=BxLKUJwGMZkkSMA11ja/fky6Oyp9/3djMjAWRjGmHYTlBdpQ0Zf1ybHU/hRmJTd17XCY22
 U4yELHDRK480nz6Z9XDkcsX6m5o0nlmG2EBNxyX7HQKwq/5K0amnEXAiwuwXxS43QSAsMh
 UOej6qjK6bv7WOA2nj0N78ALaOcYZzQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-GxA6a_4EP_iUY3-2gvn3Lw-1; Tue, 23 Jun 2020 13:27:29 -0400
X-MC-Unique: GxA6a_4EP_iUY3-2gvn3Lw-1
Received: by mail-wr1-f72.google.com with SMTP id r5so16379914wrt.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t2F+AcWEb4clUdxV3QmHayEZG+Q2SVmpDbgPn5tA3NU=;
 b=kVuNgJ2MGB0F5QgaGvNZq9XEA9Fz9xkWmuctftYWeoAPoRShWRNtQTrvM1WRpW9BKr
 W3hzHTpyXxaUAXyzWsJJb0a8bMI22jAtLtGy+8ldBcVeYj0+Oa9G1tPXprziQQCnX6ci
 /djdbap/Va0Wk3h8hHSMYd/jFyD9Tr2mz17Wbpv55U7OdxBzdw/MdcOGShvXLA6YoKIl
 18+lOXlHW1WecsWnO3+oaE9ibHDH1bMaJK7s9TVPE8Ns+fNnbKdM/2Ekf4elTGhuSZGI
 4V4M97IJIia5U22Rn/FcNyGp6JlIAneCKkXpyN+nhq9rWvIECGxztKpxaJzd9unau9sN
 zZZQ==
X-Gm-Message-State: AOAM5332e9wXRJ032fR+ti9vlLKEr+jHXXGNl5/28WaC0usdve0icXDR
 Zuu2wn9iAAbu3pW0isNRFnoJRKmABSgzybNfInDeUbQA0gWwhnVtEo3WSs/f52HV5q0zowZ6U7b
 XeKxIfVdZMJ+25EE=
X-Received: by 2002:adf:de0a:: with SMTP id b10mr23863955wrm.72.1592933248378; 
 Tue, 23 Jun 2020 10:27:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzT4bljQk/haHjbpzNdi/UfAt+A+ITJICLP6Ox90UYpRt4nJGRpD2+nDuuVl0fDIUTqiTZ79Q==
X-Received: by 2002:adf:de0a:: with SMTP id b10mr23863931wrm.72.1592933248065; 
 Tue, 23 Jun 2020 10:27:28 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u20sm3457005wmm.15.2020.06.23.10.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:27:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR;
 crypto: Add tls-cipher-suites
Date: Tue, 23 Jun 2020 19:27:21 +0200
Message-Id: <20200623172726.21040-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series has 3 parts:

- First we add the tls-cipher-suites object

- We add the ability to QOM objects to produce data
  consumable by the fw_cfg device,

- Then we let the tls-cipher-suites object implement
  the FW_CFG_DATA_GENERATOR interface.

This is required by EDK2 'HTTPS Boot' feature [*] to tell
the guest which TLS ciphers it can use.

Since v9:
- intent to address Daniel suggestions, rewrite of crypto/* code
Since v8:
- addressed Laszlo review comments (reword/typos)
Since v7:
- addressed Laszlo review comments
Since v6:
- addressed Laszlo & Daniel review comments
Since v5:
- Complete rewrite after chatting with Daniel Berrangé
Since v4:
- Addressed Laszlo comments (see patch#1 description)
Since v3:
- Addressed Markus' comments (do not care about heap)
Since v2:
- Split of
Since v1:
- Addressed Michael and Laszlo comments.

Phil.

$ git backport-diff -u v9
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[0139] [FC] 'crypto: Add tls-cipher-suites object'
002/5:[0052] [FC] 'hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface'
003/5:[0010] [FC] 'softmmu/vl: Let -fw_cfg option take a 'gen_id' argument'
004/5:[----] [--] 'softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace'
005/5:[0018] [FC] 'crypto/tls-cipher-suites: Produce fw_cfg consumable blob'

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
v9: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04046.html
v8: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02428.html
v7: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08050.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05448.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04525.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

Philippe Mathieu-Daudé (5):
  crypto: Add tls-cipher-suites object
  hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
  softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
  softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace
  crypto/tls-cipher-suites: Produce fw_cfg consumable blob

 docs/specs/fw_cfg.txt              |  13 ++-
 include/crypto/tls-cipher-suites.h |  39 +++++++++
 include/hw/nvram/fw_cfg.h          |  43 ++++++++++
 crypto/tls-cipher-suites.c         | 126 +++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c                  |  35 ++++++++
 softmmu/vl.c                       |  37 ++++++---
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 ++
 qemu-options.hx                    |  37 +++++++++
 9 files changed, 326 insertions(+), 10 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

-- 
2.21.3


