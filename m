Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF59EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6E320774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9rfgwyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6E320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiCx-0005Ce-J4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihit-00035x-6p
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihir-0008OU-Dc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VZXf0Oku6s6cxv3JpR0warJ560x4jEaK0gVpAk5rV/E=;
 b=U9rfgwyrLfncbSm+ROSX9eayirLuH7uD6DsnPGpoKpPFU+JBRiI2mp2IVZGNIl7Fge7nJe
 Mjeg0P1AHsmFQwIf5Zo7+g3ORpxef+mRIxaNHlcpX8BBv9Ud6cKgWX10m26XQWT4rxXCiI
 BQLkj2EazHc8MOznwSTB0IRpUO7n570=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-7B5L_5AHOGC10ENUuItZKA-1; Tue, 09 Jun 2020 13:07:30 -0400
X-MC-Unique: 7B5L_5AHOGC10ENUuItZKA-1
Received: by mail-wr1-f71.google.com with SMTP id w16so8831760wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VZXf0Oku6s6cxv3JpR0warJ560x4jEaK0gVpAk5rV/E=;
 b=phfh8VYVLLcChp8w7OvA26vWk3G63Msd5YjpmaIHikFuqk+lk35xKRKuxUeJyBu7XI
 mqM3NMMwS0HkvUyKeDqssWci3gLeNut80Y0xNavpu7XJa3BMYUlLR9tJ3TY6EJEn15du
 9ccAP6BQw52zv1b1L5FRhZQFjGRUmJ3xndbUBkDDoAFMlqe9dto1uRirZ38NC1cV8DU0
 xJpCcIielReM94+uKjNDoRQakXYPdLtaDcvYTB86u27iF7aNc8imbTBuU63cpDDipog/
 X1N6Y6mYQGPgxqp7xs+W5LwGNNostMTPagN9TfAFgNBMAXc6JiQ50Whznk/bJwSSDqjm
 L3IQ==
X-Gm-Message-State: AOAM5303iodfRW5V4uEodNk4dv4yMicUuXyZU4+kXZ3lrAImRHPYEg9D
 Rgek6dg/8L4Gi4EYBhRiUNPmw91JR73wMY/Sp8rje6n6HydK5HioMe9sq9bDjXUVqi9BjL5YiL2
 nYsohwhLE/NL1F1k=
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr5429291wrx.411.1591722449838; 
 Tue, 09 Jun 2020 10:07:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgnL5k2nOrkFpDjwOZkUV7qL2y61P+vVY1RHPZqnVGxw5GUJ70w/4hv4nmwJxXfD2nLW5UQg==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr5429270wrx.411.1591722449669; 
 Tue, 09 Jun 2020 10:07:29 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n1sm4068361wrp.10.2020.06.09.10.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:07:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v8 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR;
 crypto: Add tls-cipher-suites
Date: Tue,  9 Jun 2020 19:07:22 +0200
Message-Id: <20200609170727.9977-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series has two parts:

- First we add the ability to QOM objects to produce data
  consumable by the fw_cfg device,

- Then we add the tls-cipher-suites object, and let it
  implement the FW_CFG_DATA_GENERATOR interface.

This is required by EDK2 'HTTPS Boot' feature [*] to tell
the guest which TLS ciphers it can use.

** Unresolved item: **
- Should a generated fw_cfg entry use a specific global order?
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02309.html

^ Gerd can you help?

Since v7:
- addressed Laszlo review comments
  (changes describe in each patch).
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

Please review,

Phil.

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
v7: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08050.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05448.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04525.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04300.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02965.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.html

Philippe Mathieu-Daudé (5):
  hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
  softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
  softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace
  crypto: Add tls-cipher-suites object
  crypto/tls-cipher-suites: Produce fw_cfg consumable blob

 docs/specs/fw_cfg.txt              |  13 ++-
 include/crypto/tls-cipher-suites.h |  38 ++++++++
 include/hw/nvram/fw_cfg.h          |  52 ++++++++++
 crypto/tls-cipher-suites.c         | 146 +++++++++++++++++++++++++++++
 hw/nvram/fw_cfg.c                  |  36 +++++++
 softmmu/vl.c                       |  33 +++++--
 crypto/Makefile.objs               |   1 +
 crypto/trace-events                |   5 +
 qemu-options.hx                    |  38 ++++++++
 9 files changed, 352 insertions(+), 10 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

-- 
2.21.3


