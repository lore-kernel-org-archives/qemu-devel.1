Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BECC33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75FD206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaVCRw83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75FD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBeJ-000888-0v
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afscoelho@gmail.com>) id 1ipAu8-0005kb-5t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afscoelho@gmail.com>) id 1ipAu6-0006vT-V1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:57:44 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:46834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <afscoelho@gmail.com>) id 1ipAu6-0006v1-RO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:57:42 -0500
Received: by mail-qt1-x842.google.com with SMTP id g1so2628108qtr.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3iNdSV8zBFGK8UymqmkBvvTKOdXx9yjzt+CxLIC0Pqs=;
 b=GaVCRw83ANe0r1TjBqf1Z/pqwW8nPFOZLf0CHdQArynxRwFM82e9IkdV3T62geGk3c
 YPm0DfUou+ThHxAF382LIo+iDCpGWYTfVXuxSyx1heYRnVRs9GJNvfDgS0q2gtWwbeos
 Yx9YW3RDIk4a+CAc5Ha/+4r1sus6+ciKY/3NBaEUMOx6D2DWbdhxoUTAHXIp6EYF2kVZ
 PmMHYH02pEVp3byemxCNHN7FGe2xZU+2VN2IgY0+N33+EPJiSfAyaBM3EN93fi1F3zOU
 UUGFWXdpbCSx8X21V5/vzrYdNv8Q2T6K7z03/x5uUcMtFG+qpEVwerIJhXnLT3+88UJc
 IJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3iNdSV8zBFGK8UymqmkBvvTKOdXx9yjzt+CxLIC0Pqs=;
 b=RFmW6h19lacYAmI9hjMdnDpbKnW8pwIFZhABW7bqOURExU6jrlT8gANeRorGjVFh+N
 x+rfGLuphMCAFWfaI2DBl6vI+0120FiDIoFtw+VRNASdpJqevx/Jq98q1eLZj7oy+1YF
 UDSKy4QoPRSi/nMy7bwF3Er/C8Rd2ylrXrPJV/w0Pi3Sb5G+C17PyX6i5NPYbrtxtLj2
 5Z8mNtu79iok+oMbpoz+Qar0K4wV3PgZ57w8J2IMTrQjHuaFyV9C3pwG2560Y6aZbWfS
 UUcM8/WCM0bSkXxcfWMJT35wYTvHo3yViIbCSz30jrDCyYKtbBfKcDu8OosAjjmv4rlp
 l56g==
X-Gm-Message-State: APjAAAVvCGboiq0kLGMK8FnOV5BJ7iFtLRqhFONOBvZm7HYGnLE23IEj
 lBjJgEG3t4efZeoP5hp84o1pSs44
X-Google-Smtp-Source: APXvYqxSUT79y/p3Hx0kj2szVxaAdtHYAiG0eqfJVKo2GDqeubPL1Z9kPtk6oi9y+I6OYXNjLqgunQ==
X-Received: by 2002:ac8:747:: with SMTP id k7mr3452010qth.120.1578488262108;
 Wed, 08 Jan 2020 04:57:42 -0800 (PST)
Received: from frodo.corp.eldorado.org.br ([200.168.210.66])
 by smtp.gmail.com with ESMTPSA id z6sm1283615qkz.101.2020.01.08.04.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 04:57:41 -0800 (PST)
From: Andre Silva <afscoelho@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Date: Wed,  8 Jan 2020 09:56:58 -0300
Message-Id: <20200108125658.208480-2-afscoelho@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108125658.208480-1-afscoelho@gmail.com>
References: <20200108125658.208480-1-afscoelho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
X-Mailman-Approved-At: Wed, 08 Jan 2020 08:43:53 -0500
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the bswap function calls after reading and before writing
memory bytes in virtio_pci_config_read and virtio_pci_config_write
because they are reverting back an already swapped bytes.

Consider the table below in the context of virtio_pci_config_read
function.

Host   Target  virtio-config-read[wl]
               swap?                   virtio-is-big-endian?   extra bswap?   Should be   Final result   Final result ok?
----- ------- ------------------------ ----------------------- -------------- ----------- -------------- ------------------
LE     BE      s(x)                    true                    s(s(x))        s(x)        x              No
LE     LE      x                       false                   -              x           x              Yes
BE     LE      s(x)                    false                   -              s(x)        s(x)           Yes
BE     BE      x                       true                    s(x)           x           s(x)           No

In table above, when target is big endian and VirtIO is pre 1.0,
function virtio_is_big_endian would return true and the extra
swap would be executed, reverting the previous swap made by
virtio_config_read[wl].

The 's(x)' means that a swap function was applied at
address x. 'LE' is little endian and 'BE' is big endian. The
'Final result' column is the returned value from
virtio_pci_config_read, considering a target Virtio pre 1.0.
'x' means that target's value was not swapped in Qemu, 's(x)' means
that Qemu will use a swapped value.

If we remove the extra swap made in virtio_pci_config_read we will
have the correct result in any host/target combination, both for
VirtIO pre 1.0 or later versions.

The same reasoning applies to virtio_pci_config_write.
---
 hw/virtio/virtio-pci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..4ba9e847f3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
         break;
     case 2:
         val = virtio_config_readw(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
-            val = bswap16(val);
-        }
         break;
     case 4:
         val = virtio_config_readl(vdev, addr);
-        if (virtio_is_big_endian(vdev)) {
-            val = bswap32(val);
-        }
         break;
     }
     return val;
@@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *opaque, hwaddr addr,
         virtio_config_writeb(vdev, addr, val);
         break;
     case 2:
-        if (virtio_is_big_endian(vdev)) {
-            val = bswap16(val);
-        }
         virtio_config_writew(vdev, addr, val);
         break;
     case 4:
-        if (virtio_is_big_endian(vdev)) {
-            val = bswap32(val);
-        }
         virtio_config_writel(vdev, addr, val);
         break;
     }
-- 
2.24.1


