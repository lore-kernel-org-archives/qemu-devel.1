Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3473B2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWHFoL+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3473B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNRr-0005KG-AJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1jCNO4-0000YJ-8p
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1jCNO3-00074w-Az
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:32 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1jCNO3-00074g-7J
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:56:31 -0400
Received: by mail-qk1-x742.google.com with SMTP id z25so1021249qkj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1VSF7YAtLh+8LFVIeTwCMtUaSmVrA9/zD3UEqGOwfDU=;
 b=nWHFoL+VTAwwfalpjOc31nwWzR4h++PjFNO2zoscIhQ+SooUhd3IeUiwdBZzvJ5ktX
 ewhlwk4BSr6Nl44hvabDFqlfk2V40OozBCsJ6087uwkIAxB/nNpvNnaVWhuqW03cYGm3
 suij1NKFigGeEAsBPXtEXygNCwJYRUOnIIKryRJSWuQFZ4mOrOwwRlI+ADT6EQqD4VND
 jQBE9c7MpoY30ZtdIRSmh7t2j95hq+9ropSOqyHZdXbl9/SeSkdN5+X8FHJhxtVQjdYc
 blCfN20vZz7luRFsLAzmt3TycofSazVyfxYHiCh9aOTDz9qPF/lZ27bTdFgeog7ARTF0
 MAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1VSF7YAtLh+8LFVIeTwCMtUaSmVrA9/zD3UEqGOwfDU=;
 b=iIWhPbSChxccS6Urh3RlmCt1dEeCPWbhzNz6ay5ze8V3F65gDf3Kj5GYVg27PZB/02
 /UWu7ax9Tfud3L2xFRr3faS8HsxMPehEGHo48ZYEsTm36ivOdXv0UXqtgvZ1uboIu6YX
 lHhF+Zr5C38wwteDxurNDRwWa07z87ECwBTiINkQhzJ/jurwGLQh0of1d3ba4DD63kn5
 LTc+TAu8ywQ6i88z8ZSNRsqVLMv7odlVNtyiMOgLRuuATsaB1gp1kVP4HjJtFlDSqLJV
 B5/CIRlkk+y2kZ1sggUuszQcVJdTkKBlEjVNo1umEo+xN1IMI91tOhWG7ud9VHzkNWxG
 la2w==
X-Gm-Message-State: ANhLgQ0Cz1rJVstfEejqeNod7Qld0nEy9/JeqqIgIh6ALSxWV0Vj7JNN
 quYwFnJ0d9c+n8TCQNXRl1Y=
X-Google-Smtp-Source: ADFU+vvFXLrl/y9HypBnN3hxEjBTPTibISr/pCh+D4pmLsT8nul7nxM4m/9rRhk1wGNfUwpqq9+mHA==
X-Received: by 2002:a37:992:: with SMTP id 140mr7719156qkj.36.1584017790665;
 Thu, 12 Mar 2020 05:56:30 -0700 (PDT)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 u3sm8001236qkc.4.2020.03.12.05.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:56:30 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4/4] usb-serial: Fix timeout closing the device
Date: Thu, 12 Mar 2020 08:55:23 -0400
Message-Id: <20200312125524.7812-5-jandryuk@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312125524.7812-1-jandryuk@gmail.com>
References: <20200312125524.7812-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: qemu-devel@nongnu.org, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux guests wait ~30 seconds when closing the emulated /dev/ttyUSB0.
During that time, the kernel driver is sending many control URBs
requesting GetModemStat (5).  Real hardware returns a status with
FTDI_THRE (Transmitter Holding Register) and FTDI_TEMT (Transmitter
Empty) set.  QEMU leaves them clear, and it seems Linux is waiting for
FTDI_TEMT to be set to indicate the tx queue is empty before closing.

Set the bits when responding to a GetModemStat query and avoid the
shutdown delay.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

---
Looking at a USB dump for a real FTDI USB adapter, I see these bits set
in all the bulk URBs where QEMU currently has them clear.
---
 hw/usb/dev-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index ef33bcd127..5389235f17 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -332,7 +332,7 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
         break;
     case DeviceInVendor | FTDI_GET_MDM_ST:
         data[0] = usb_get_modem_lines(s) | 1;
-        data[1] = 0;
+        data[1] = FTDI_THRE | FTDI_TEMT;
         p->actual_length = 2;
         break;
     case DeviceOutVendor | FTDI_SET_EVENT_CHR:
-- 
2.24.1


