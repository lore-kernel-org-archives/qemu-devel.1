Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959DC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958FD208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958FD208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoO1-0007Kj-RI
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <th.huth@gmail.com>) id 1hfoKx-0005iT-KJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1hfoKw-0004Dn-DN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:30:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1hfoKw-0004CY-4g
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:30:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so18594830wrt.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 09:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6xPkbnECwZtV2J2603/yIrcgJrGP/eSXDsDSxdGWShc=;
 b=rt2gQ19pJnJp+lZbRBtJIsTXzdUDIMpOXImeswqAGJ3nXZsn19tNNJ5Ts7i5bw7TYE
 rctFEGyYcZnyExD6/08vfW+iv5YcfV2XmuzgiJeGZ78ujDw0m9wCE+tyLc/Vmt6Bc+Yh
 9V5mcm3SNsIKO3V4UzL/K1K0NCIwpUSRelsVpCJoXSGjXHPyRa4VJTH/0xLW4puv7PMl
 B8Fa3+aQ3Tm9z12YALcG84wCdn3V5um08JhbI8dZjuIgBC7UfjkM/Wvo+8sFAlHZbfDJ
 NCPAQddHRPezeG3Y25jeC5UfgGjPaHCcc3g9gW4YKbKfbnivodCXD07cI3ZzWSH3wOfA
 Slmw==
X-Gm-Message-State: APjAAAWDKe3z3pfGtM1HMq0PZgMCbscrAGRGvNoxGssw4+1Cb92nNyEd
 m4MOFIC9o/m0Td+RQgb3gLM=
X-Google-Smtp-Source: APXvYqxbngM3DdffkeOnyxu16XYKje1ZZeh9qX90NAhsISOC/L8l1mlkDcgzyUeswq5q5Swfeh1LWQ==
X-Received: by 2002:adf:edcd:: with SMTP id v13mr36827591wro.210.1561480224342; 
 Tue, 25 Jun 2019 09:30:24 -0700 (PDT)
Received: from thl530.multi.box (p5791D9D1.dip0.t-ipconnect.de.
 [87.145.217.209])
 by smtp.gmail.com with ESMTPSA id r131sm2089906wmf.4.2019.06.25.09.30.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 09:30:22 -0700 (PDT)
Date: Tue, 25 Jun 2019 18:30:19 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190625183019.3cb231d2@thl530.multi.box>
In-Reply-To: <20190619221933.1981-11-laurent@vivier.eu>
References: <20190619221933.1981-1-laurent@vivier.eu>
 <20190619221933.1981-11-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v8 10/10] hw/m68k: define Macintosh Quadra
 800
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Thu, 20 Jun 2019 00:19:33 +0200
schrieb Laurent Vivier <laurent@vivier.eu>:

> If you want to test the machine, it doesn't yet boot a MacROM, but
> you can boot a linux kernel from the command line.

I gave the patch series a quick try, and was indeed able to boot the
Debian installer with the q800 machine, so:

Tested-by: Thomas Huth <huth@tuxfamily.org>

