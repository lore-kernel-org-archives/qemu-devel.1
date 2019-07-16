Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A9EC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C13721721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1GYy5rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C13721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIcZ-0008Jo-V8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60111)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYk-0000Ji-Hi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYj-0003My-CK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:38 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYj-0003M4-4l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id x1so4842042wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M6lsGMl+nf2V5Rsu715+jo/F0NLVYFfe6LEKAl/IYr0=;
 b=I1GYy5rS1/RgdW1mKn+ddrtlAJ6e25MD2A6560TtYHDv1sVMVHcy3Ximv2SGQHaXaF
 Ren6b9kmYY8dj6b6dyAtNJcpSCvD/qDRHzoAItgOSyv29RxeJVoN8l+ysZs5j9f5Evpy
 8xwP9tcbDzIf1eg4jBSbgWnbucgtmO0S1YrI/Aqqs6m8UudyJASkuH8rhfOiwoUvTfV4
 AnF/vZC312CTAmH4Ik5Fbg9nf0Y4t//NmsnXwQwINnueTyrC4G/YcALXl0nYtrT1EwAW
 o58eX7Pi/9BoLFRzh24Lc2ql5Po9TLf4wcK3Y6ZPEyQYPAvvObVZmBFiTSQIa/nOnaVi
 Bx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=M6lsGMl+nf2V5Rsu715+jo/F0NLVYFfe6LEKAl/IYr0=;
 b=iebRbngW8RxnvFkCld0ooaxSjIUr2LylEBpigZm+6DQ0/WIvDp+6lU6SPIBtD1CccM
 oIXPk5ZNZFrGYTsWMiV1+j5ettxewJ0js21u2pxvTdqKs3uCuKmc5SFAveaagQ8BLmmM
 yH6GXsxwguvd1Le5TIR6Tws2MCAxFMrRnqaZovfRiB6V4cd0h05Ce3uRxQtSqzSkVmDv
 b2Og/osqd/YPAPACff4m3aMTrPeviWCPTNAO7Wz5rOJVMrQoaSNl+H0qsu2RYB9j8BDH
 Wha46WFQAbhFIQPo0L0nP16J/kDpeKh0UHInH+0joUas9NossceOF9sG8KDL/LgC1cGu
 PqDw==
X-Gm-Message-State: APjAAAWN5RPja9aBp5eAYsvR8AuI40Wa1ZsfpW/dMfnGke/jzZkVluCp
 NDCZRKiK/SXfn3laivENVqKtA1NpIRI=
X-Google-Smtp-Source: APXvYqz4VCrSaQiaJ/T+kXJ9ZTamS+hhncOzdCedJoONSn2EDmj84M1UwTRq9wgrxoxv9Xby8d1ihA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr36367130wro.307.1563264695955; 
 Tue, 16 Jul 2019 01:11:35 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:14 +0200
Message-Id: <1563264677-39718-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 16/19] hw/usb/Kconfig: USB_XHCI_NEC requires
 USB_XHCI
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

TYPE_NEC_XHCI is child of TYPE_XHCI. Add the missing Kconfig
dependency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 495c6f2..555e093 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -40,7 +40,7 @@ config USB_XHCI_NEC
     bool
     default y if PCI_DEVICES
     depends on PCI
-    select USB
+    select USB_XHCI
 
 config USB_MUSB
     bool
-- 
1.8.3.1



