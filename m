Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E59C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 13:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C131218AC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 13:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNV4HLli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C131218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6bFe-0006r1-IN
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 09:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devtoe82@gmail.com>) id 1i6bEz-0006SQ-Ko
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 09:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devtoe82@gmail.com>) id 1i6bEy-0002uR-OW
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 09:59:01 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:36773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devtoe82@gmail.com>) id 1i6bEy-0002tu-JP
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 09:59:00 -0400
Received: by mail-ot1-x332.google.com with SMTP id 67so8438008oto.3
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=OnZl2j9qzKqaeCr/bkgfQfxp51EWMBFEP2mivWmXABA=;
 b=ZNV4HLliRhUM0mCs573VOE+HXgioWyoBbirOfWdesF9DiXYXm5PulPxz9UW6+ZflJW
 TthdnE4LvrCMxl79ZU7vg4BP8UR+5/4qiF5bnhdR640ENE1bkyeCG3CIahOuDLI9UydE
 8/LuDHRn7b66ltt8epnN5uwkOkmXcolhtvIoVQha3oGQ34I7j/QBOKLO3TtWXCFWV9md
 2jZNJ2VB7HvucqdyiQeu9Faf9an0AtNN6BX9pJw3D89zmv7PhzYojSQFRLAw3Abj7+RF
 uCRgCUt/ltDNn/IUg1D8ctuL8tN+xHrNxFR79j5+oCZsyjOpsGoaBDy8iOFN/XEXhgpD
 nHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=OnZl2j9qzKqaeCr/bkgfQfxp51EWMBFEP2mivWmXABA=;
 b=FHaLd59w/bAYaDBJZN1yQPFMPSMMoGj1NlXUxRWClje88XcuJcLvGIY+etUlNlbM+a
 nMZZMws50VgYmp2LPEgQJaiaX8yyCAPNlYSjJ+yHt3tqSserd/JTS0uyBVHR+bxZt8jy
 f74eCjQ4zHHc9ehek4Jg+0xjnBsQKxyyIWk/5KmkmHSS27ojxN6sFNn7TzfhgJj+XLiF
 nfTLGH+Y95aIJpMl2oQ2mZ4YrLbmvV74rD0UZIS4mcA6CVbYFHQ2yddHJJl0OHtK5Rrg
 9Vvg5A/RZcF6yI94wR3rHI6tO8BoN5Cnksg8fkgatPDHXvm5HXx5m4K3VnCcr+t8P4po
 YtjQ==
X-Gm-Message-State: APjAAAUejSN8q+1CeX0dRlnr8yNseaZt/lSslsuH+LyiUoG/Ir7umDs0
 EGwoHGoK5rhAbv0eGRmTHK4zLzTUMMl4VXv+lC/gMjnB
X-Google-Smtp-Source: APXvYqxRPHIWeBGrdWgnnMuPdDLwKMX9tNEWT3GebDUohaCR+eNseGpo8e1Tw/nwINJqb41nmnqJh4fcGvCmKM4VYCo=
X-Received: by 2002:a9d:6952:: with SMTP id p18mr12051640oto.217.1567864738990; 
 Sat, 07 Sep 2019 06:58:58 -0700 (PDT)
MIME-Version: 1.0
From: Toe Dev <devtoe82@gmail.com>
Date: Sat, 7 Sep 2019 16:58:45 +0300
Message-ID: <CAN+O=T+HN6ueMMq-Dt2X1mB2e8a9BdEFg3gnkgcNAcKHw78UEg@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Greetings qemu folks
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

I am new in QEMU developing and I have general questions about QEMU source
code as I could not find any guidelines about it.

1) I have no success running qemu in nographic mode.
   The internet says using chardev driver to redirect kernel output to host
OS...
   what is the right way to do that?

2) My main target is to output a lot of this to console cause I new to qemu
and I want fast                    feedback on stuff like this. I try start
qemu with -D option but the log files never have been              written
by qemu, but either no success.

3) What is the right way to do logging in qemu for development purposes?

Best Regards,

Yali.
