Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0223AC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AACE20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 11:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjbN8YJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AACE20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJxoD-0002ay-IK
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 07:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlV-0001Kp-T2
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJxlU-0000AQ-7r
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 07:44:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so9784515wmi.0
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v9lTKdRyWgAXgLShD6p3N0JX2tmU2Kap8fALmGmHpQ4=;
 b=FjbN8YJ/61NPb8IRHYk+tOswshfvDMH+vFGF2tVEQfN4ebDg4DXQ/9Ep609J7+l6It
 eQvyVhFuyMJJRKol3ucaDARONWEoatKlNtQkN0FTwJMlBD7hb6AwBPlijPeGkgCvgH6S
 ABzolCjZN7tBdCcnqB+88HMR/zobXGsYXy58AHYrteSdkaJmdTpHR1qyujyYIKfc/XGw
 El2Re6M31i1IBVGUWR2TQzBWgrX5p5CRonr/Pu5P3q46nt8gmbw/SoDqTXCasXzV6rEu
 bZ4xiAJ7/OO0/vEIBoJHHTRaBhgb+LrvflxHbvDs7Y/yzAag4qTD7eIouYPeDVfae30R
 e0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=v9lTKdRyWgAXgLShD6p3N0JX2tmU2Kap8fALmGmHpQ4=;
 b=tf1QgW93P8I1H6UkiQz957JuPqvUr3nWZyFVnEUzpK6pBQTsCFY3aEmbKoWBDgDrHS
 HTi3n6deDbatxNEF7enRzbQFTtiMtmmwk+oI3YfUUhG7GJsirM61zx6JMiRJ7fXeU0ZK
 Ui4MtlUFecW8G4b3FYoWd0yaXpTIG5BmqZ0pS1XI6guOYzXuFev/jZAN12inicCcsgLv
 9o8DMwzcAtrbYdpRsfmuy6HQfk+aw72iY7LnKeQ7hMuEQNIvTAJlRkbzfn7iVAUoKayD
 ncyL92xiLgnj2zi08lrRpoti/nPETSRr1Ugx6I8vaGp7KiOht1NNX0aLz4utsBgSx45n
 Uskw==
X-Gm-Message-State: AOAM530MlOEIEJdWGNAZl4VsuDvxD/q6roB+FjHCGvTbzJLun4Fz0MLX
 KoXwkvUxxZkz7z5/gr1lwUU=
X-Google-Smtp-Source: ABdhPJxswx0awIIBdWi6zxkm04w3J+qmG0J90c1L5+9PcAjhA5yy+8kww9qa7QFYtODWrprNvR4UqQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr24161783wmi.36.1600602258565; 
 Sun, 20 Sep 2020 04:44:18 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id e18sm16415708wra.36.2020.09.20.04.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 04:44:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] qdev: Let BusRealize() return a boolean value to indicate
 error
Date: Sun, 20 Sep 2020 13:44:14 +0200
Message-Id: <20200920114416.353277-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To ease error checking in DeviceRealize handlers, let BusRealize
return a boolean value, as qbus_realize() does.

Having DeviceRealize similarly return a boolean value is left as
an exercice for volunteers :)

Philippe Mathieu-Daudé (2):
  qdev: Document qbus_realize() and qbus_unrealize()
  qdev: Let BusRealize() return a boolean value to indicate error

 include/hw/qdev-core.h | 26 +++++++++++++++++++++++++-
 hw/hyperv/vmbus.c      |  5 +++--
 hw/nubus/nubus-bus.c   |  5 +++--
 hw/pci/pci.c           | 12 +++++++++---
 hw/xen/xen-bus.c       |  5 +++--
 5 files changed, 43 insertions(+), 10 deletions(-)

-- 
2.26.2


