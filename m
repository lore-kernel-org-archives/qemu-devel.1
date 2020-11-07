Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80678C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9482068D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLXvwVqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9482068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMBb-0005a6-MJ
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9o-0004BA-4L
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbM9i-0002jX-Ge
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604747592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RuR8yw1X/lPYjyaH82aeYWhe3hzgR86aMLlU3agp3bM=;
 b=HLXvwVqgihYs6b/Tj2+uXHugWYXBobXFdy7xpFDhMXDB+0nr6o0T/0JuauN0npcd3AaK0Q
 drVin124TDc5SkzeiZM3hj+OVnApWRCwOu7Zi2unoLd8FfbUL2jm+FYFu53wCIR97ZZtMH
 ZlPI3wUtXesyKcIzQtc31murMvJqw6k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-3Xyf1NndO4Synl50MbXuvg-1; Sat, 07 Nov 2020 06:13:11 -0500
X-MC-Unique: 3Xyf1NndO4Synl50MbXuvg-1
Received: by mail-wr1-f72.google.com with SMTP id 67so1613088wra.2
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dzcsBx8+y3kEbH/02iaA51V5RU4aFyUqBoV6HQRSKo8=;
 b=F6tuJf9nBKBuHIlvJ4kMpJhjUrt+CkF4g19fhkYekG9/0phMSrlKmEr4usDS9g6LyN
 bLeAzYu4MHAn8g9beR5+61rF8FWh+ICyC6hjKd+HVLkTfgQrcMWty+1z73nB3g7sBlI1
 7gmWDMREwAq5vCvIHvGnxiL0hHLeIkjuLbfleIBY882Ft2EKsiFMGF6LVVZughKyvYV5
 2CYEMvDU9my/HFjzNZzdJvKKjrnoRZvdS+k7fD3P0GMOlGKo7yeOmMFom53qauy8iiXW
 LL+GVaGiezzAtTqW7stca2jWLoPZEuAk3Egg3NoGliMrLEVNs+OXTaT6EYlUHXfpC8oc
 o33g==
X-Gm-Message-State: AOAM533e3sNH6w29JTiA1GjBmTCKDlK6lSjDeLhxWwuSyYs9y9pbwnSz
 mnyaaE0WcPyP/wgLMt5VzRdlOKPeLD6vTIsHEtqrIpvgmkZiEjztbsoi1oOMJaZSDrECMQJgOxK
 +I0OsNg2OZrPY8hA=
X-Received: by 2002:a1c:6856:: with SMTP id d83mr4551212wmc.13.1604747589839; 
 Sat, 07 Nov 2020 03:13:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxArzCdxY+DpMOVu8iZBABlWGg78swtXF0OxPL63bC7tMqaTt/PPyIIXToWI/RMiIkz0BSelA==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr4551192wmc.13.1604747589608; 
 Sat, 07 Nov 2020 03:13:09 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o7sm6421219wrp.23.2020.11.07.03.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:13:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/5] hw/usb/hcd-xhci: Fix xhci-pci devices
Date: Sat,  7 Nov 2020 12:13:02 +0100
Message-Id: <20201107111307.262263-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:12:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix few regressions introduced while introducing xhci-sysbus.=0D
=0D
Cleaned a bit code style while here, patches included for 6.0.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  hw/usb/hcd-xhci: Make xhci base model abstract=0D
  hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on USB_XHCI_PCI)=0D
  hw/usb/hcd-xhci: Rename "base-xhci" as TYPE_XHCI_COMMON=0D
  hw/usb/hcd-xhci-pci: Use OBJECT_DECLARE_SIMPLE_TYPE() macro=0D
  hw/usb/hcd-xhci-pci: Rename "pci-xhci" as TYPE_XHCI_PCI_COMMON=0D
=0D
 hw/usb/hcd-xhci-pci.h    |  6 ++----=0D
 hw/usb/hcd-xhci.h        |  4 +++-=0D
 include/hw/usb/xhci.h    |  1 -=0D
 hw/usb/hcd-xhci-nec.c    |  2 +-=0D
 hw/usb/hcd-xhci-pci.c    | 18 +++++++++---------=0D
 hw/usb/hcd-xhci-sysbus.c |  2 +-=0D
 hw/usb/hcd-xhci.c        | 11 ++++++-----=0D
 hw/usb/Kconfig           |  4 +---=0D
 8 files changed, 23 insertions(+), 25 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


