Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C29C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6977D2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="c0i/V82r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6977D2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTAGg-0001TB-5G
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iTAFA-00008p-1s
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iTAF9-0005zJ-1S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:27 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iTAF8-0005w9-Jt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:48:26 -0500
Received: by mail-pg1-x542.google.com with SMTP id h27so4630335pgn.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=kXUfIwaLzekBgu4rO+8d58TXD+81bPyPI2S5oCzPGYs=;
 b=c0i/V82rl872oRDRzsNny1HZCiTCIFzzt34/kJGvhuWfp/u4Pojwib0Qj0Y1mz1PzT
 qfFU8q0hTw4m8desBU9Xg+C1pJH39AEfvaOOW4buCSWF1XBM2HiWYF6wnam/MuMdX4Dd
 Vj9mEAXPxl8zhK04wLxmxhQ/hcrCooDBCRuSrKT0d4RGs5VvQw0Ae2ALK2unR3/pSSf5
 zy8iJGYR992HIDa+xqa+PazYKMN/rDle7YcCo0w2YDJVCSMe59uDwPm/lU0egiinRk44
 GfDgux5drYFXQEzCqNZga54mnm5VdKXp155vD2nPkfzYDsZp/Vfj2Tg44rKHyv/w6HjC
 8YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=kXUfIwaLzekBgu4rO+8d58TXD+81bPyPI2S5oCzPGYs=;
 b=TwmBZebJAYyCpKaiSvwgRIIlLLcSgYiDL3cTN4Iszvmv6KNykG6Bkn/w/8kHXJJ1Jh
 VO2UMvGw1aPfFsyhsABr6mrVkf0gkZXpKtRobj7lEp1DFfLolM+4rBj5wfzuQAr61EfD
 wCRjgFRI7PZAjOEQS1ZjemFKciXnLMS23Twc0KrvEg2CXdnvNfeO+aiuApN744eXwutV
 SkELD3oyDfHl0WxzDixQ1AzF+4q1J5EKPVEVq/TW+fschuQPBzZt+/gdxD+IDQClCxkm
 XAp6KdY/BMV2s6TNuxRE+UTbVYiwAnsupNooevi4Zv0NE5bA0DGp8q0JRCWBdBaftwNr
 pw1A==
X-Gm-Message-State: APjAAAXwRk/u39T5j4X6JVd97w5JhYgWytx6HstI3dSxSVwhYAwbiawj
 E2Zwp3KDXIYtknBW0OBUMkFkkw==
X-Google-Smtp-Source: APXvYqyO8pvXTpDi0TvMfvPWDtSTnfeh/2tIOLJK7JEiHeE41SJeRQ+aQhz25QSrx9lMGQ1k1TyYFQ==
X-Received: by 2002:a62:1841:: with SMTP id 62mr13763325pfy.108.1573242504332; 
 Fri, 08 Nov 2019 11:48:24 -0800 (PST)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y123sm7120494pfg.64.2019.11.08.11.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 11:48:23 -0800 (PST)
Subject: [PATCH v2 0/3] device_tree: Allow for and use string arrays [Was:
 RISC-V: virt: This is a "sifive, test1" test finisher]
Date: Fri,  8 Nov 2019 11:47:55 -0800
Message-Id: <20191108194758.17813-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Device trees commonly contain arrays of strings for compatible nodes.
We recently extended the "sifive,test0" node in a backwards-compatible
way, but QEMU didn't contain an FDT function to set 'compatible =
"sifive,test1", "sifive,test0";'.  I've converted over the code from the
ARM virt board that was doing something similar to be a helper function,
which I could then use for RISC-V as well.

I haven't tested the ARM change, but I have tested the RISC-V one.  It
appears to parse correctly in Linux, and a DTC treats it the same way as
it treats the string arrays it compiles -- specifically:

    $ cat test.dts
    /dts-v1/;

    / {
        string = "stringa";
        strings = "string1", "string2";
    };
    $ dtc -I dts test.dts -O dtb -o test.dtb
    $ dtc -I dtb test.dtb -O dts -o out.dts
    $ cat out.dts
    /dts-v1/;

    / {
            string = "stringa";
            strings = "string1\0string2";
    };

and

    $ qemu-system-riscv64 -m virt,dumpdtb=out.dtb ...
    $ dtc -I dtb test.dtb -O dts -o out.dts
    $ cat out.dts
    ...
            test@100000 {
                reg = <0x00 0x100000 0x00 0x1000>;
                compatible = "sifive,test1\0sifive,test0";
        };
    ...

Changes since v1 <20191107222500.8018-1-palmer@sifive.com>:

* This is now a multiple patch series.
* The hepler function has been added and used by the RISC-V virt board.
* The ARM virt board has been converted to use the helper function


