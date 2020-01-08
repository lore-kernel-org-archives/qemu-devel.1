Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509F4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174702067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWoTVDsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174702067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAlj-0000Sz-VV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWV-0003wr-Hw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWU-0004PE-KS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWU-0004Of-Eg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id d73so2307213wmd.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZENGOtMS6+bKQUaERKPKm8qYGAS6+eCRE25grnCOJjk=;
 b=PWoTVDsnsWBBEB81pkQ8E/z2BjlJZNHqextjiw8AvAw47LiNz7Ge0kEnw/RictIOpq
 ZDFUfLhOD5JpKxuNrUqHCB3XtiYQ1eTACdD+nfBwGaCG8RZxLgQckLDclRZdwAda4qkw
 048jfBQyxdPatXYJJtVlOzpnIKhvJhwtM9GtO+/5xz2KgsaSpv/OUNDt90DwXmPTMKFA
 P0jxTzOKPWb92Kdnm7PtXASf4aelwR9z2qrcqh7F4WKw94pYysbz3I0qb/TTvQfYhpoD
 /rt3hOF90EBXeQkhPuGIfF8E2f2CWt1C3dYd2Jq+xemHsvnKcALZFdEpe0Z8grVzyXLy
 jNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZENGOtMS6+bKQUaERKPKm8qYGAS6+eCRE25grnCOJjk=;
 b=g6Q3RcAp82k4c+CnazdoPfwBhbJ8tF8FQol4/Fvy2XaeU20eG3b2EmlgmNUkx3TaMh
 MUVjN7UwM0RoDZ/iZgfyFnZG4ycYZQkZ2VLEj+VAok+js2ULalOj8sM9HwG2On9zP1ka
 mmyG93NbAYfS2yqVd74Z1x2EeMZY/LZIkrx0CrA+IoD6UeYg4X2J0gtEOcDIJQqxUXsY
 Y0ozjxbgmXGWYt3KB0fiV15xxLCVfCngkJe4/wggNe2NvL/09Cagx1chq9veboY/RTut
 f/xLYGTHbOSxFQniU/z3q130jpyOn1jimMQSFHjx0fwbf2YibXTjKvrTGvp8DlSEUmMz
 kmrg==
X-Gm-Message-State: APjAAAWuK3ry/3sS1G76jRgwOC63TZFDVmeKzkQMnJd2sgzFICR44U1O
 k8Da+WL3IeOEPMjiq6igWZir2zJf
X-Google-Smtp-Source: APXvYqwnv/cZtv7N/ojW3GZ3gVip8CNh+hKTEDwS47sKLhKzwdgn94qwPeFQvMK2TJamHGFY7G3j6Q==
X-Received: by 2002:a05:600c:507:: with SMTP id
 i7mr3795819wmc.135.1578486797347; 
 Wed, 08 Jan 2020 04:33:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/38] hw/rtc/mc146818: Add missing dependency on ISA Bus
Date: Wed,  8 Jan 2020 13:32:37 +0100
Message-Id: <1578486775-52247-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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

The MC146818 sits on an ISA bus. Since it can not be used
without it, select ISA in the Kconfig.

Fixes: 82f5181777 ("kconfig: introduce kconfig files", 2019-03-07)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191224111628.3551-1-philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 45daa8d..3dc2dd6 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -17,6 +17,7 @@ config TWL92230
     depends on I2C
 
 config MC146818RTC
+    depends on ISA_BUS
     bool
 
 config SUN4V_RTC
-- 
1.8.3.1



