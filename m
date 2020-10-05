Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F301CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8FD2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEFxyN+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8FD2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPOBF-0006H4-I2
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8o-0003RP-TG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPO8m-0001pY-Ai
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601895286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W5oSV3fSW9ps9rV2v6Nd7VuQOUigTcSM57Y2eKxjzWk=;
 b=cEFxyN+PP7e7NpbU/A6qNQEaTomaC8UgO/x++ZB5j0zjxaHwaz16SqdgJwGQjHKv4K6Dh/
 W8aGkuggS+OWMmM3Nz7oDIfGL87+aM50C1MNDTROtMFRD9/j05wokOfBAqAzKIseaOkll+
 eWmwT2XfDHNNvqXDk3K3D8cB0xXLjb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-O7obgI4KMrGBlH6U309B7Q-1; Mon, 05 Oct 2020 06:54:45 -0400
X-MC-Unique: O7obgI4KMrGBlH6U309B7Q-1
Received: by mail-wr1-f70.google.com with SMTP id i10so3835316wrq.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W5oSV3fSW9ps9rV2v6Nd7VuQOUigTcSM57Y2eKxjzWk=;
 b=sqaOERjx07EU1IOeet+lAU+evWXmPT4rzNN3il4/kkfYbqrb9Wozou5y4E4YJKqbhE
 95TZhZ9W2VbxsN25Uhun+rr6qNXU8BGw9Yrq6VplBYeMlONYjCSaod6PZcezabI4fEHS
 0GmJjmmvH/AtPeS1rEqtey71n5eI9jR5yFaU2pn8b26x3RWp1f39spgpYaeqIMSGKQLS
 Jta/HokhAb2sFsVmUGY7AJKVu69gaHQ5uvaa2cXnFKxHJhWG19Ph11ed32aJJDZ+bOOa
 OSClaERFw1Pxb/5/6+f0eZzYNOd9dQxCjsZXi2SAW6ju2EBu+kURGRvtjWW7O2tdyZsm
 jhDw==
X-Gm-Message-State: AOAM532FBgbHCDLwxQ4lNd0Qkf0ZgNn3y7YLkPXf+WAFRHfAKgbbm+Ol
 u8T08S4qvAar2EQhWlGDKT7MImaUOCfJDjRO078Jq+Tw1kp4+eqYXezr5mmhdzqcB2U7StLBea7
 a4pPGZCvj0drJ3NI=
X-Received: by 2002:adf:eacf:: with SMTP id o15mr17983813wrn.12.1601895284178; 
 Mon, 05 Oct 2020 03:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjHZnC2XayDUw93gFjexETESqMcfHdVUBYXiTc38MqO0oCIm+V/v/Ptc7ZWUDdvhVTaFRrzw==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr17983802wrn.12.1601895284013; 
 Mon, 05 Oct 2020 03:54:44 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id m13sm12888756wrr.74.2020.10.05.03.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] qom: Fix missing interface in qemu-storage-daemon
Date: Mon,  5 Oct 2020 12:54:39 +0200
Message-Id: <20201005105442.2093105-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempt to fix the issue reported by Kevin.

Introduce a trivial test, but there is currently no
framework in place to test qemu-storage-daemon.

There might be better fix to this QOM issue,
I went for the easiest one I could figure out.

Philippe Mathieu-Daudé (3):
  qom: Always register FW_CFG_DATA_GENERATOR_INTERFACE
  tests: Only build socket_scm_helper when a softmmu target is available
  tests: Add a trivial qemu-storage-daemon test

 hw/nvram/fw_cfg.c            |  7 -------
 qom/fw_cfg_interface.c       | 15 +++++++++++++++
 MAINTAINERS                  |  1 +
 qom/meson.build              |  5 +++++
 tests/Makefile.include       |  5 +++++
 tests/qemu-storage-daemon.sh | 10 ++++++++++
 6 files changed, 36 insertions(+), 7 deletions(-)
 create mode 100644 qom/fw_cfg_interface.c
 create mode 100755 tests/qemu-storage-daemon.sh

-- 
2.26.2


