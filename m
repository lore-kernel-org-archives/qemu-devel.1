Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6473C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252C821D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnoT5gTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252C821D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQLa-0007ae-6U
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJd-0006Gw-Kv
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQJb-0004zN-Qd
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:39:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k18so7004708wmj.5
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=RfWDFfP5NQFYF/OWOyH7NoAM1wnLLe8g0PU+7Q5DaDY=;
 b=tnoT5gTZmPhTaXzsMEMOlOa9GZvOJdNPlqbVKavVb83QF/VrmJlOFWMYbHKyAEXt6F
 ADMQw+owMybjELutCTSa7eqYD08EKOjAmFVdE8i/yDPdCtVHTBB1EXPXzC7PYEQS4T0Z
 4ijfp8fqAnYXKCFFe7PzWdWxKdDc1aeITOhAYtfcrAY+jChU/+ruLfMtGRAr6EC8r8Ij
 LEfIQJflpLYLhvVXMgu6Aymzmfeh77cKnMYp7l7ApjB72kYNIxvYcTWd39Oh/Rdk0Zu7
 fvfKe0IfLk+ZkEwNqz2njedEr92eN/h83ZFCEECOFYkOkCReWrpmI99gJB31OoKE5kK6
 q40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=RfWDFfP5NQFYF/OWOyH7NoAM1wnLLe8g0PU+7Q5DaDY=;
 b=HusxyLLgSRzQTjvl3FjEnbTncw8T97ViI3QfJ55qbL6dlLDqiTTEqMIVNcsKZcB8y5
 v9ZAyymhG2fi/V++I9CjxNW8b3n6Bl+4a3CN6JL7KETCia2RXegojg9pYMMOCWJidsP9
 mh9riOcWOhi9JXkxDmTOiT8oU2ze9vh62XNMkX9RpPsOLMsgIcPvoUi3qa0BAnRN9+kP
 s0iEQ7UnQqLcLj+h4SW84QMnDNxMU6iXsXrzu6gBKTVCX3j34hWdWrUqBz8YC8SiLRHk
 wWDuM8mq9PlsWDVca4mrNEK+0+2L+3YXuRhU/kEs2M/VS9CEUiyg8SpmPH3BRwFS4aUQ
 mYsw==
X-Gm-Message-State: AOAM5333PhH7MW2UAe1Gjwn67BrBgQ5H31R/Ngj9Z6Kx/Q1ovZD8KGcD
 GanCWCGXzZrklISpGzO+Kw0=
X-Google-Smtp-Source: ABdhPJyb7Ny3ck6168AzGpOpqQcx8+3fLBLpiK7nPhG3cEEgRxKyeVNgPbdcAhV/rD8YX8YfwjwsTg==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr8929091wmf.185.1603571941962; 
 Sat, 24 Oct 2020 13:39:01 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x64sm11525838wmg.33.2020.10.24.13.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2020 13:39:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] pci: assert that irqnum is between 0 and bus->nirqs in
 pci_change_irq_level()
Date: Sat, 24 Oct 2020 22:38:58 +0200
Message-Id: <20201024203900.3619498-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Respin of Mark's patch:=0D
https://www.mail-archive.com/qemu-devel@nongnu.org/msg749459.html=0D
=0D
Supersedes: <20201011082022.3016-1-mark.cave-ayland@ilande.co.uk>=0D
=0D
Mark Cave-Ayland (1):=0D
  pci: Assert irqnum is between 0 and bus->nirqs in=0D
    pci_bus_change_irq_level=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  hw/pci: Extract pci_bus_change_irq_level() from pci_change_irq_level()=0D
=0D
 hw/pci/pci.c | 11 +++++++++--=0D
 1 file changed, 9 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

