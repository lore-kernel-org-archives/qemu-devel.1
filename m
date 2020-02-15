Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2027EC35242
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A00207FF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 00:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E34dWmd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A00207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2l5j-0001Nc-2o
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 19:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2l4q-0008Ai-8J
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2l4p-00035L-9Y
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 19:12:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2l4n-0002yu-52; Fri, 14 Feb 2020 19:12:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id 70so5721885pgf.8;
 Fri, 14 Feb 2020 16:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=GOmxZa8W36fyEtyV9Vzyxm6an40ZPWmlRGIMTwNafzg=;
 b=E34dWmd9FdfydzEKXmiuQT6Lamd0tow4bOesbRs+EjzzysxoiZN/BukqNzeDiCPZgB
 DXQAX2JnoZfFIsR5uZCMqDW+LhiCGDa7f1DAT594vRiEf3CUKLiZLfD+L4yAKNXr+mFY
 Ej14udPrE4BFgRswwx9AP9Qmd8Z9vs1e5M/hookZ9aWiYl6Mdm+h+J1L5UAUc35Pa/rN
 ZriOFoSKMPyu8LEwDBlsZIfaJ5gRY5Exj9t2HyvsMikGBrDXG0tFAVhQ7qYExDPPrSnE
 USgPIkwyq++yr8LtTbxUF4bnbJHaWt4BKcjPhdb49EHV6OjehmGpqzVRRub0dW4I7gT8
 fZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=GOmxZa8W36fyEtyV9Vzyxm6an40ZPWmlRGIMTwNafzg=;
 b=K86kgU6ozTOBcySHXXu5nfxQK5Dg+dMNP4R9Ymh6YSeJhg+ovnLkczxE5niGV574B+
 Jy0vAz/X2ThPBsEB4u7BPTM5HmzOawfT+goeJ1ylKfJ0pjNkbzOwToWpcDGKRAwnQyhg
 rCN7PtDAsiwzYP9dSdCp6uNzE7IUAkF0L8GfrIoeKwPj9t5EjIDBCyswVXeFirnfaEcv
 23teOYSetxAJp9zJl7Gh9nGLQeG1O9feDLh8OnLUdEYrAz/inE+h7hvWmtbGnj/oSvh8
 BizEyniYNbXxV4nVO70OOg32gKzQRqghM4CVBtezwgl9LwReVOFAncrGapjJFcWcXJLU
 w9Nw==
X-Gm-Message-State: APjAAAW6/Wb4dojLFP4DFELi8GE15mf7B87T/Ybd2DELe3SjKWv/Dizz
 g4EItQwEFMrcWRd9DyjDnT0=
X-Google-Smtp-Source: APXvYqxmYR7+uIKOTT2K5CzHAhtnalA/HsdGneion7hrlYqrsJ7Xdw/IyxGxrT60IySiPsU8p1c1xg==
X-Received: by 2002:a62:d15a:: with SMTP id t26mr5875886pfl.187.1581725571958; 
 Fri, 14 Feb 2020 16:12:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id l12sm8082854pgj.16.2020.02.14.16.12.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 14 Feb 2020 16:12:51 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/3] arm: allwinner: Wire up USB ports
Date: Fri, 14 Feb 2020 16:12:45 -0800
Message-Id: <20200215001248.2642-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instantiate EHCI and OHCI controllers on Allwinner A10.

The first patch in the series moves the declaration of EHCISysBusState
from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to
AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it
outside its driver.

The second patch introduces the ehci-sysbus property "companion-enable".
This lets us use object_property_set_bool() to enable companion mode.

The third patch instantiates EHCI and OHCI ports for Allwinner-A10
and marks the OHCI ports as companions of the respective EHCI ports.

Tested by attaching various high speed and full speed devices, and by
booting from USB drive.

v2: Add summary
    Rewrite to instantiate OHCI in companion mode; add patch 2/3
    Merge EHCI and OHCI instantiation into a single patch

----------------------------------------------------------------
Guenter Roeck (3):
      hw: usb: hcd-ohci: Move OHCISysBusState and TYPE_SYSBUS_OHCI to include file
      hcd-ehci: Introduce "companion-enable" sysbus property
      arm: allwinner: Wire up USB ports

 hw/arm/allwinner-a10.c         | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-ehci-sysbus.c       |  2 ++
 hw/usb/hcd-ohci.c              | 15 ---------------
 hw/usb/hcd-ohci.h              | 16 ++++++++++++++++
 include/hw/arm/allwinner-a10.h |  6 ++++++
 5 files changed, 67 insertions(+), 15 deletions(-)

