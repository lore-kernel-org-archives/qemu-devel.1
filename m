Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A7C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92562070C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ712M4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92562070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjVS-0003KV-UM
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUL-00018t-PG; Sat, 04 Jul 2020 10:49:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrjUK-0003du-6D; Sat, 04 Jul 2020 10:49:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id f2so7792376wrp.7;
 Sat, 04 Jul 2020 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MuyWjc3EjPCzKMWDQ2x+ag455dTHS4+/J8s0D1IfWzs=;
 b=eJ712M4xvrpeG0WDBqIsWoodAc0KX1IcpGrySlrkuD9AOTok/P4V/I21yqX/UEczz4
 3tSXj1WMi3HUlpJkfq2a6D2xREY05qgcqqJ19Jl7cdWzw2gv+ctBk/5poKNfTIv79Q0n
 BAVVtuIe/u6EewOUx6SzWsbiKfIGzmfWG/Yq7yydaZQAcV3k6WTSGWLLZAqkjp55Pn7+
 lBXvy8gVmzLifoWV3EcPuOxQzRn/bv2cit5TEsCXcdNiE6ar8MCWmB3dx2nr0CNajAWK
 hoBQwV5aFZPYADzkJ6K25xbFFvQMnugh8FXNfFas/L7BOnEBzAH5LJDg5p/AgO1233GU
 IUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MuyWjc3EjPCzKMWDQ2x+ag455dTHS4+/J8s0D1IfWzs=;
 b=XnKXsgTn4aE9hvx1DKRnMwaTEmTQjU2Pf4t2PmmVWUCpUx+nRJ4By33xdc2zrIlGVg
 l99QYqPqtNC2nuMMNdZ7Id43SLGcq1us7Vhlp0BK9mTHFyzomVBxaR06f7rZmn9MhlyV
 5VcFAqI/hseBJ31tbdnYZOK3K0qnIkdcIMLCnls0FOPdpKxzRMxTEkCEkHE3jt+SlMgk
 oCUVUtG7ekLn27T+ar9tnORqjhyJH8jZubbJq8bYi73RmWPgrdFlTr/rVcXwhCUqq6wO
 Le9gDT0oQH2zAY3uDoh/6b/fDi3BoHp+eYcUjtkhtNhMEiE4JwesEWLBhnUFCSI1wSkN
 G3rQ==
X-Gm-Message-State: AOAM532LDVadS6QE0dkDcdHuA45F324E0H6epYTwwnWcvWL3zR3+mT3d
 MJJ5amEF5UYq9Wb8Udd7Vj6/txZ8YLE=
X-Google-Smtp-Source: ABdhPJyYcaxhb0w6bZS0TVjPWW7MJK44YHjNK2tmtt5WThpkFwrsjrZmdAUU/9drVhDWFP6nr2M8dQ==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr42871069wrn.9.1593874193982;
 Sat, 04 Jul 2020 07:49:53 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm17135019wrm.17.2020.07.04.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 07:49:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 03/26] hw/usb: Remove unused VM_USB_HUB_SIZE definition
Date: Sat,  4 Jul 2020 16:49:20 +0200
Message-Id: <20200704144943.18292-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704144943.18292-1-f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a5d2f7273c ("qdev/usb: make qemu aware of usb busses")
removed the last use of VM_USB_HUB_SIZE, 11 years ago. Time
to drop it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/usb.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/usb.h b/include/hw/usb.h
index e29a37635b..4f04a1a879 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -470,10 +470,6 @@ void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
 bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
 
-/* usb ports of the VM */
-
-#define VM_USB_HUB_SIZE 8
-
 /* usb-bus.c */
 
 #define TYPE_USB_BUS "usb-bus"
-- 
2.21.3


