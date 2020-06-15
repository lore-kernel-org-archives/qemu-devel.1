Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7BBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDED20679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ3lXZUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDED20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmTg-0008Ej-3U
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmSW-00074Y-AM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:35:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23281
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkmST-0007BX-9c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592217315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vqKQQd37ScqtJU4+lEsuhPTaN9Is/ORTrI4sKw3AM5s=;
 b=OJ3lXZUmeaaRSeWf8U9/L1X9dTe24NbPLvdwLVOeUj80XMHkEQb8xushvf/KOrzw5MfW2/
 f/oMcSnKGpBojHVw0ciy4HeHQnr+0qeSEyO2Ni3KQsiQX9msCf7D6ftxsY17+yCadEWxyX
 CGMNzGCVbE78LOXYOKojzmauAr3ysvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-MPWMJjFOPSmd8KjFSCkSZA-1; Mon, 15 Jun 2020 06:35:11 -0400
X-MC-Unique: MPWMJjFOPSmd8KjFSCkSZA-1
Received: by mail-wr1-f69.google.com with SMTP id h6so6927938wrx.4
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vqKQQd37ScqtJU4+lEsuhPTaN9Is/ORTrI4sKw3AM5s=;
 b=BsbnshXYj5/ph7NjumRpH8a2baozOqd4Iks43+Hm+KJlZ7Y8suz5cCg4uM3Xqb2AV+
 VGVPN0Fw24kAhRIotDtmYA4ROpooi7T8Ww8n793OIqjGDYm66ZEMNk8A0vEBEv+U0ty0
 QF24u1c5xlWxyqCHyxJxeHdKF8hQa/KmRzz7HN3Ska+Qk7nciLS7F6y7Rfi6Vut1LYuc
 s/P8HtAeDmVNDvxCopN8DvIc7uZgaH62inuU8Q8yTSqzT4nVlVE+hlQevQh49f3Sx+NN
 C2RvAEcEj7e1L3WuMNIMiwi/QDcDeb6t+67aXzxXLQ+YlWjf6rNbOCcoEWJO1cuBNsjz
 E6jw==
X-Gm-Message-State: AOAM532IjFARwK/PkFPz18X0C6rJce+8ghHLl9v53oSY1a4D5d5YxJu7
 5/X/VR5D+qjsuOhSSNWpX2GDSnHUdPWaKuiaLWazy4eo9MH9hva8XdX7lcPKvicWe32TxellMJ6
 QH7shieJj81B53PE=
X-Received: by 2002:a7b:c041:: with SMTP id u1mr13196862wmc.56.1592217310142; 
 Mon, 15 Jun 2020 03:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw08pzTj3y/uo97r164kWLuIvVvYrrOROUoFxiC4i+34dObQC8jR2HFJwuAnI4eW/ilnON2RA==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr13196836wmc.56.1592217309896; 
 Mon, 15 Jun 2020 03:35:09 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a14sm24680117wrv.20.2020.06.15.03.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 03:35:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v9 0/5] fw_cfg: Add FW_CFG_DATA_GENERATOR;
 crypto: Add tls-cipher-suites
Date: Mon, 15 Jun 2020 12:34:52 +0200
Message-Id: <20200615103457.25282-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Daniel, can you review/ack?

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

[*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
v8: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02428.html
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
 qemu-options.hx                    |  37 ++++++++
 9 files changed, 351 insertions(+), 10 deletions(-)
 create mode 100644 include/crypto/tls-cipher-suites.h
 create mode 100644 crypto/tls-cipher-suites.c

-- 
2.21.3


