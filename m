Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5016C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C9E2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgF1udmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C9E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7gp-00018Y-Eq
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bY-0002jN-Uv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc7bX-00058N-2E
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4vy7YKrTr41FWUBuaAtEPJPa7MSgwtys8JkH9N608no=;
 b=NgF1udmToHH8LHbG6r+ud1+N7kAuqwIWBv7s3POTWolY+OY1onNOYPO0x9cUw25L9tWooH
 lTspDqhORubri5Aa1I1RZPJFU6PbBBwrs5S4K1EcV9PeY6zPyreo564HN8kxOtLdU8csK5
 oNjzy6eQEpM1/1scQM7oc2eYmiyqRM4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-u0osC8RvPPG40CPIyZ3Uew-1; Mon, 09 Nov 2020 08:53:04 -0500
X-MC-Unique: u0osC8RvPPG40CPIyZ3Uew-1
Received: by mail-wr1-f71.google.com with SMTP id y2so1722663wrl.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 05:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GVZWVqeq+QMOxkIFc3Z0mw66pVG83i8zFZ8TZYNpLX0=;
 b=X3xOF2100oxGJQTySmwQ9dQBVFWyBrKJ3HQvRsujuY95y/sEDHpOA+ihpJw04duy6M
 gSj5uJS67w+roN1FmaohRnaxuwewmx4rTGCbui+8PRUVSpmzjvgZH+BRPQQzNNzz2oYh
 AOsdqn3DxFDbjMNynmBBQA6/TXYNgSfStAnnkNnemgiu/epqF80q8BaxWeihSCLSllUX
 /j7if2UPH4sv/+0bGZQFl2pIhD3ltstq69ps2h5HS8CfAn+u3bufF8pdpX6H9symxA82
 ZEvRejD/wF6uizgH+86G3WMzrYnwrf7YjD6PomUn/KfyJsEsKc2NQm9eXo8EBLvOe/jI
 PW4w==
X-Gm-Message-State: AOAM531XJny1/Rad9MXRKyTMi/d9ABrVDtftBytVJFG7xau99K8QoYIW
 fDMVuZWmMv7+Hus8IFkfr/PZmaX/GL9BNCiaDDXpDKKBGi+PUj/KUGwAH72TflP2Xw0P14G3BEk
 1Lk1JXUJstITv5KA=
X-Received: by 2002:adf:ead0:: with SMTP id o16mr19256440wrn.292.1604929982302; 
 Mon, 09 Nov 2020 05:53:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygIqG+GvvvTDkBaWmeSgAeD6eIaesvfLy2j0nSBg8cgt8wGyZIrrU+j8Ha7fdeM/bHEfbQ+A==
X-Received: by 2002:adf:ead0:: with SMTP id o16mr19256424wrn.292.1604929982135; 
 Mon, 09 Nov 2020 05:53:02 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i5sm6616598wrw.45.2020.11.09.05.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 05:53:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 0/4] hw/usb/hcd-xhci: Fix USB_XHCI_NEC device
Date: Mon,  9 Nov 2020 14:52:56 +0100
Message-Id: <20201109135300.2592982-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a regression since xhci-sysbus introduction.=0D
=0D
Since v1:=0D
- Do not declare TYPE_XHCI abstract=0D
=0D
Cleaned a bit code style while here, patches included for 6.0.=0D
=0D
Supersedes: <20201107111307.262263-1-philmd@redhat.com>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  hw/usb/Kconfig: Fix USB_XHCI_NEC (depends on USB_XHCI_PCI)=0D
  hw/usb/hcd-xhci: Restrict TYPE_XHCI to hw/usb/=0D
  hw/usb/hcd-xhci-pci: Use OBJECT_DECLARE_SIMPLE_TYPE() macro=0D
  hw/usb/hcd-xhci-pci: Rename "pci-xhci" as TYPE_XHCI_PCI_COMMON=0D
=0D
 hw/usb/hcd-xhci-pci.h |  6 ++----=0D
 hw/usb/hcd-xhci.h     |  1 +=0D
 include/hw/usb/xhci.h |  1 -=0D
 hw/usb/hcd-xhci-nec.c |  2 +-=0D
 hw/usb/hcd-xhci-pci.c | 16 ++++++++--------=0D
 hw/usb/Kconfig        |  4 +---=0D
 6 files changed, 13 insertions(+), 17 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


