Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43309C742D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D75205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLOiorYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D75205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzzg-00022m-MD
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 14:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlzzX-0001dX-1b
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlzzV-0003Fw-2w
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:09:53 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hlzzU-0003FT-UT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:09:53 -0400
Received: by mail-ot1-x32c.google.com with SMTP id n5so10344724otk.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ABzziioYLWj5hBqNKqPa5SS+TDw12paohexyEV4n10g=;
 b=HLOiorYWitEByaF4q3Bj2E/LKgKkwLQ+/eAdKMkBDk70Ej5cdBTmtM7nD7tRmn0eoI
 nslbM4axZ5Ga5L4cK3HmyYC7SyDEbyMwgmIFhBrMQECbBswyb0mHsFAdWJg54+t+Fo8T
 Ylsl2NimDXHJXfQSop1AV7L2UjyfmzPNGCZFz3MGya2ZPq4SI19kRZqGDiEdmbWtnsc6
 rkhs7ki2zvNl8newUomBth6CfHwo5WZU3SOXLsBWb26KWGBIDGNoI1FRrzNWdcWflwB3
 MFnk0XW3ee2FYJwi4fN4miZqbXVkY6zldZy5acFgjUC+J5WNC/WoTnC0XEV3E7hs3Fpf
 idXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ABzziioYLWj5hBqNKqPa5SS+TDw12paohexyEV4n10g=;
 b=rNcdWhSbRyKH6IQ/aFjCnZLYjGpRdR4Gigq96GRyCCcIuzKe+/rgQDUcBcBUrhYYf0
 7cIybXMYaGlp1XTOvGDQlwm5n0jq2zfHcYNOREIth0bFI2qZ9JLkWMPrerx9s555689J
 iEIYKGbkRr9hosiUNnt39bPskQfofzbE2/PKe0h1K0lOzY9kAnKLPSAtA0O/KigjpoO7
 94Duj+ghTIAV07uESiKO9Zdfs1S9awof6b+QtgYvWu0tD5w5ryjx4yakjMW4fj2kRk8x
 7g48ABrnb8/sTQj9+eBCGxPrDO7//ank/I2X4KyB8egFFrjD9ASzx6OV/UddjcFJCD6U
 IDUQ==
X-Gm-Message-State: APjAAAXWCH2MS/S4q9QqzOOtIw2dlHiHcy6KEn3AcMJknRYvswKO6ZRQ
 Bwg2oL8Jy0DAwJux48z2KVknvgkTaFBS8u+O6bU=
X-Google-Smtp-Source: APXvYqw63lq9i9U46ijVt5TsuN8B/EZWJYTcxiyiVJsinAqru3RvtE5sNKt6AvFN5FyyTxvfR7CRoT7u6tpBD0yfNlY=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr1494799oti.341.1562954991352; 
 Fri, 12 Jul 2019 11:09:51 -0700 (PDT)
MIME-Version: 1.0
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 12 Jul 2019 20:09:40 +0200
Message-ID: <CAL1e-=ixrEhBeakGDW8xJVBBzRkZTR4d69w38HHmvxVUzOCkSw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: [Qemu-devel] [BUG] nanoMIPS support problem related to extract2
 support for i386 TCG target
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

Hello, Richard, Peter, and others.

As a part of activities before 4.1 release, I tested nanoMIPS support
in QEMU (which was officially fully integrated in 4.0, is currently
limited to system mode only, and was tested in a similar fashion right
prior to 4.0).

This support appears to be broken now. Following command line works in
4.0, but results in kernel panic for the current tip of the tree:

~/Build/qemu-test-revert-c6fb8c0cf704/mipsel-softmmu/qemu-system-mipsel
-cpu I7200 -kernel generic_nano32r6el_page4k -M malta -serial stdio -m
1G -hda nanomips32r6_le_sf_2017.05-03-59-gf5595d6.ext4 -append
"mem=256m@0x0 rw console=ttyS0 vga=cirrus vesa=0x111 root=/dev/sda"

(kernel and rootfs image files used in this commend line can be
downloaded from the locations mentioned in our user guide)

The quick bisect points to the commit:

commit c6fb8c0cf704c4a1a48c3e99e995ad4c58150dab
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Feb 25 11:42:35 2019 -0800

    tcg/i386: Support INDEX_op_extract2_{i32,i64}

    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Please advise on further actions.

Yours,
Aleksandar

