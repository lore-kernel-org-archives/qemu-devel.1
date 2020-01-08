Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076DAC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C405120678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ+1NK+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C405120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipE4L-0003Fb-RJ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <afscoelho@gmail.com>) id 1ipE0i-0007xn-Vv
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afscoelho@gmail.com>) id 1ipE0a-0004kq-H0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:16:43 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <afscoelho@gmail.com>) id 1ipE0W-0004j3-N9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:16:36 -0500
Received: by mail-qk1-x743.google.com with SMTP id z76so3150544qka.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BJ2O4PQRw1ys8DhPlVU2A3mHoRVTkwiCzLu+4EEMMFE=;
 b=tJ+1NK+OC5v7dBp0vRQzFhCsJlYYvbNLFixpC1XWBxAwTjexFIsNf5WdqZk58O56ZL
 ggliuwXgwhevjdCr8++rzegHixitU6lElOJyX0YegvVmDLpGKnXACnH0O3lW+cL+BB6F
 EJ/U+cTFxinrVvoEQl6PcjmqJ9fCVbKiGu/oFkNUTqX8iUs9lDrL3RZq4RXfBNLc1Y1M
 SWFKrnCcd4oIlXEitvjwcjrAv5njNAyjhTruzL3w156HLN8DySJUn/pDQh4A1wW5yggs
 T384v6+myea8Lb38FrjH9qwC9qGv+oR30ESOVwUUUQsxK+dbniaVRrpU27ox99gaQ2ZK
 teQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BJ2O4PQRw1ys8DhPlVU2A3mHoRVTkwiCzLu+4EEMMFE=;
 b=Y/kiy/iYTpkLd9rabEHlZWmWG/udCJU8oBymddmrwgSMY6SiU0WoosfoOI5muDc3LO
 AAmb1243X9hJ9ha90qN0KsIOHHAFFpdoxpcJ8cn2q1Ys+ska92uTCd+1meXd/DYn7Hy5
 a7lOArrvbnzmiP5BgMMpsK1LVNyZSU3cpfZEeM640eI7wE+8rYnIKHhgx47Jqq76I/rQ
 C5IKu11z05VIQgLydc/fOBy10H9mj3XAY70j+hDSMi478PzsdiA1QVn8JJENK7c8LzH2
 mFgzEr/iS1yqUy3UO9EW6hNoyXP2ESU9ex7Np14FYOoXUPCeF3Bhs71X1y5ZFt1NHf6c
 tS9w==
X-Gm-Message-State: APjAAAW2tW88zN9qQL5v2yJynV2u8ApiWS+ulDyZRvCz+K1b8v+xZqxE
 HIX3ocdRVF9HHDsFvwmT9Pm1Z7v3
X-Google-Smtp-Source: APXvYqzVv+fvPqtOarR35xAn7Isza8NAP+NZElfa8j5nllAz89hwN33V+8CuHF4Gz1zmRFveavuWRA==
X-Received: by 2002:a05:620a:947:: with SMTP id
 w7mr5052259qkw.432.1578500191483; 
 Wed, 08 Jan 2020 08:16:31 -0800 (PST)
Received: from frodo.corp.eldorado.org.br ([200.168.210.66])
 by smtp.gmail.com with ESMTPSA id u5sm1578200qkj.127.2020.01.08.08.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 08:16:30 -0800 (PST)
From: Andre Silva <afscoelho@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Date: Wed,  8 Jan 2020 13:16:18 -0300
Message-Id: <20200108161618.221116-1-afscoelho@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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

Signed-off-by: Andre Silva <afscoelho@gmail.com>
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


