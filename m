Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22EDC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCE22073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYgqCxHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE22073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58PO-0002Xo-P8
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582e-0007ua-NJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582d-0003Hw-Mr
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582d-0003GV-GU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id z7so1969081wrl.13
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=t9tzjIw7N1XSr73asGVBDssmnE7SvvmIcOpn2v7YIf0=;
 b=pYgqCxHezS+bau4Uy2dCB/kdEHpdBTpGWw7LN21n53skMgZDXegbAEJJuX04zW/O8k
 jZ8bIaHbosJPn1etS5bhDxrPyqe1h5tCFxG15K05MuXQ3T33sd2MXFlumuDFeqNSprrZ
 J6J7uikWIHZSJM5fnJkMKZTq9eHwjRqvnHjqK86nOEkKO6v7WFkpBuiyWkgkuHKk7vYE
 cr01YsvDeE3vuoM71hncxeDOuBLw9A0VMdPmEjSmKa9Xn85pmxGZ6umgtOht5FIBYDQk
 k3PRvZ3AYMaqvLbUu5Tv5T/R8q8/ZtWmrPtJ/x4Sv8cf4vy+nN8NBQ364sSr/0qaCJDy
 UYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t9tzjIw7N1XSr73asGVBDssmnE7SvvmIcOpn2v7YIf0=;
 b=JFE2wgoJQhAIez0hbbnUCogKcgDnrjBnVr7AM3gKb7wgBTPBXqEUAJFIsojGSYS1vs
 RJ4RlMXfBWkpqE/X0zaqBAiHV5HYaYnB/XWaiZ0wRsfRxFvhH4nBK40HWb5F17n3dpxs
 Rp+/sl/fUYSINf62nqdpLwlhuLJD+ZAGvwZekFdlecKK/1ju5o33khkYXKvLtkHcqZIW
 Yi2TTYB9q52sLGKtAMaUCycefa/NMmj+2oqR7sV5+Wl/IEP5bsW3fIp+VVktDnudIqA9
 iDESWDwVSwuH4k6+FLTvzfXSB9qycnoa14I4UT6APeoXuj8zbZpYnnvDa5ftUz6qCksv
 AzRw==
X-Gm-Message-State: APjAAAWJiDlc1lcc3olrKpdQ6q3zwXf9rGz/v0cWMkrEEETFKYq9TPwE
 ldoVkTCpD4R78xjPs3sVSMMVF3AhEFBz0Q==
X-Google-Smtp-Source: APXvYqwBJ3SNO1TXs9p7aO+hm5weDGJo1uV9jBq/0aO+cerqbTqkQ/FWDQO64m5y9QpKBG+1FBsLnA==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr48553137wrm.293.1582290506138; 
 Fri, 21 Feb 2020 05:08:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/52] hcd-ehci: Introduce "companion-enable" sysbus property
Date: Fri, 21 Feb 2020 13:07:24 +0000
Message-Id: <20200221130740.7583-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

We'll use this property in a follow-up patch to insantiate an EHCI
bus with companion support.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200217204812.9857-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ehci-sysbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 8d4738565e5..b22fb258be7 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -33,6 +33,8 @@ static const VMStateDescription vmstate_ehci_sysbus = {
 
 static Property ehci_sysbus_properties[] = {
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),
+    DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_enable,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


