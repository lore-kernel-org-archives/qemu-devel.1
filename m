Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EBFC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C245D22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nesdw3H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C245D22314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itaYu-0007nx-Fk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWW-0005sj-Ot
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWV-0001hd-64
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWV-0001hC-0h
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:35 -0500
Received: by mail-ot1-x343.google.com with SMTP id m2so396277otq.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NgG8/oXKPfzZ5PXrBgXiek8H6KwYdNE5o1J3M+0kzq0=;
 b=nesdw3H5n0bL3sOhbpvgZPUFftlI4XTCVnaOvTRmsc/qmmROUO3pCvBx7cTIcW+gAw
 z0lYHdGYIGJwslSbwsEbxo8ib6XU82uvliMED1lyje5672kvjSm3hJOzXNUnMbNm6yML
 uNwAar+VbHwWOFizNBzhCcVuS29ijFB1ZA9lB9S5GG55PBii2DWM7pjJjUT749IG77m1
 PEotE+uyjLeX4bk/Vhq3ObdXp5bP6PoBXlnIHQ0ok7L/5Ey7n+1e9L8hjOyBKsm4Yipd
 m9K+DAU1B50e2uLVrsA1kTkYV/AB2x2dzCYFvNQgJMQARo0f7rublsgIxVwnHhmQW4nN
 aCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=NgG8/oXKPfzZ5PXrBgXiek8H6KwYdNE5o1J3M+0kzq0=;
 b=iN5v+15nxeiTofEdKwWA6HPv+1q5A8eYqh2auvQNBo0P9Xb0sCVFVNDXyqoVxd8gOF
 G/2PQw6xfse3tKCW5EbEpZsbbawVnQq1xh/O0yv5NI3IxrMURlvyuCSMNE3fpPUnXzT8
 LxZf6qwgAUSgXn+Pb4KSYR+jG/VBerz/aWOa7DfZ9C3wTmwbIomBQhE2fuYphETUTFDJ
 DufEmQCScTsZd2bDX7Er4hvSlidwVuHYeW52hZa609s83yvKzEiAuSYiRqAnesxVc6GX
 EdJ2ma11cTqh1/zAjvWx2mDmIr/aHoUNjPiZ2/IfGnlB+NqzGLmhoEkqGmR97Qt2oZdY
 Z/9g==
X-Gm-Message-State: APjAAAWhni/uxSSWwWwapqJTMmRG3UAhIzZ4Je4wbW8fme6076UCSlHE
 M3Zd9qkoANDTdq4Bz3utohdrNEY=
X-Google-Smtp-Source: APXvYqwxCwUo84AzXy8wf2MuxJIHXr2/uAggIAofwlylYEv/cWXIqlD7TrtY/BQ18U15+geV1tSdaQ==
X-Received: by 2002:a05:6830:154a:: with SMTP id
 l10mr370134otp.44.1579540054023; 
 Mon, 20 Jan 2020 09:07:34 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id 101sm12570617otj.55.2020.01.20.09.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:33 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id A6E88180055;
 Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 5/5] i386:acpi: Remove _HID from the SMBus ACPI entry
Date: Mon, 20 Jan 2020 11:07:25 -0600
Message-Id: <20200120170725.24935-6-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120170725.24935-1-minyard@acm.org>
References: <20200120170725.24935-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
on enumerated buses (like PCI in this case), _ADR is required (and is
already there).  And the _HID value is wrong.  Linux appears to ignore
the _HID entry, but Windows 10 detects it as 'Unknown Device' and there
is no driver available.  See https://bugs.launchpad.net/qemu/+bug/1856724

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c             |   1 -
 tests/data/acpi/q35/DSDT         | Bin 7879 -> 7869 bytes
 tests/data/acpi/q35/DSDT.bridge  | Bin 7896 -> 7886 bytes
 tests/data/acpi/q35/DSDT.cphp    | Bin 8342 -> 8332 bytes
 tests/data/acpi/q35/DSDT.dimmpxm | Bin 9532 -> 9522 bytes
 tests/data/acpi/q35/DSDT.ipmibt  | Bin 7954 -> 7944 bytes
 tests/data/acpi/q35/DSDT.memhp   | Bin 9238 -> 9228 bytes
 tests/data/acpi/q35/DSDT.mmio64  | Bin 9009 -> 8999 bytes
 tests/data/acpi/q35/DSDT.numamem | Bin 7885 -> 7875 bytes
 9 files changed, 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7b8da62d41..ab73a8f4c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     Aml *scope = aml_scope("_SB.PCI0");
     Aml *dev = aml_device("SMB0");
 
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
     aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
     build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
     aml_append(scope, dev);
diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 77ea60ffed421c566138fe6341421f579129a582..1f91888d7a485850cf27f152e247a90b208003dc 100644
GIT binary patch
delta 42
xcmX?ZyVsV>CD<iouN(sdBf~~6V@W}2z4&0K_yA{5gXkvyU|%PL%@LCMtN{E}3u*uW

delta 52
zcmdmMd)$`GCD<k8xEuomWBo=hV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlKHFvhbs+g

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index fbc2d40000428b402586ea9302b5ccf36ef8de1e..eae3a2a8657e9986d8ac592958503c0b516faaef 100644
GIT binary patch
delta 42
xcmca%d(M{2CD<k8oE!rK<ARM`#*%{4dhx+d@d3`B2GLFY!M;ugn<FF}SOFEN3{C(5

delta 52
zcmX?Sd&8E?CD<k8h8zO}qx?oLV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hk`1f?g02lt

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 6a896cb2142feadbcabc6276b59c138a7e93f540..53d735a4de25c4d8e23eed102fcd01376168c5b3 100644
GIT binary patch
delta 42
xcmbQ{*yG6M66_MvqrkwxSh<nQSW-}0FFx2QKET=2Ai9Y^*w@KmbA+TFI{@^p3o8Hs

delta 52
zcmeBioaV^o66_K(O@V=d@yA9kV@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl6LF>e&h`+

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 23fdf5e60a5069f60d6c680ac9c68c4a8a81318e..02ccdd5f38d5b2356dcca89398c41dcf2595dfff 100644
GIT binary patch
delta 42
xcmdnvwaJUiCD<jzNR@$s(P<->v8151UVN}qe1Nm3L39&;u&<NB<_O6r+yL|Y3#R}8

delta 52
zcmdnwwa1IgCD<jzMwNkq@!&=-V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
Hl25n+d}a-&

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index c3fca0a71efa7b55c958a49f305389426fbe7922..9e2d4f785c54629d233924a503cfe81199e22aa0 100644
GIT binary patch
delta 42
xcmbPa*I~!y66_MfA<w|TsIrl(PEt@>FFx2QKET=2Ai9Y^*w@Km^J2+-Rsi7S3kU!J

delta 52
zcmeCMn`Fo366_KpB+tOWxOgL1ouss?UVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB1MB9Q
HlKHFvWcdvU

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 2abd0e36cd1344cbca3fa4ab59c5db2ea326d125..baefa611acadce4c6da5babdaafad533d19358e6 100644
GIT binary patch
delta 42
xcmbQ{(c{7866_Mfqr$+z_;Dkbv8151UVN}qe1Nm3L39&;u&<NB<_O7sTmba|3%CFP

delta 52
zcmeD2nC8Ld66_KprozC$Sg?`HSW;S5FFx2QKET=2Ai7C1*w@K`Bi_T)g@;XmfpxQ=
H<UTF{S(^;F

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index b32034a11c1f8a0a156df3765df44b14a88dbb4d..aae0ea2110a54b02f772d99e66df0730d74b43d9 100644
GIT binary patch
delta 42
xcmdn!w%m=&CD<iIU73M_aqUJfV@W}2z4&0K_yA{5gXkvyU|%PL%@L9}IRW`53)%nx

delta 52
zcmZ4Pw$Y8tCD<jzP?>>&QD-BUv81%BUVN}qe1Nm3L3ER3u&<K=N4$rp3lEzB1M6l#
H$(x)2UJ(r1

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index d8b2b47f8b47067d375021a30086ca97d8aca43f..859a2e08710ba37f56c9c32b0235ff90cedb1905 100644
GIT binary patch
delta 42
xcmX?Wd)SuCCD<k8up9#e<Eo8Z#*%{4dhx+d@d3`B2GLFY!M;ugn<FGkSpgBb3@iWu

delta 52
zcmX?Xd)AiACD<k8tQ-Raqvl2~V@YXMz4&0K_yA{5gXkv7U|%N#j(87G7aleN2G-4f
HlBKKwec25x

-- 
2.17.1


