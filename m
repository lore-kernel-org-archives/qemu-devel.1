Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77807C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4B320659
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T10mTuHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4B320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJjPr-0004F4-FZ
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 15:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anselmetaf@gmail.com>) id 1iJjOo-0003hg-5l
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anselmetaf@gmail.com>) id 1iJjOm-0003pU-CP
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:19:25 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anselmetaf@gmail.com>)
 id 1iJjOm-0003oV-8E
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:19:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id i16so12105133oie.4
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=y2+CJpUj74/kWjA1e8DlG6+e9+bjuGwNQzeH9YZxlws=;
 b=T10mTuHfVEtQT56uiL5Q5+bRLN/LH8kLAjLE5zJVADVN7xkITLqZ815WFPSqQcGBsE
 6nHvKK3TWKNryatlgcdpg+ZZJrk64w6ZV60lL3bBaVRGqfowCz7mpfX/OvE3yElNZtGZ
 fcU5FGWfTFr2jrIt7OWKaj5OAg9iuOMVpa+vpMWX000Raxo0dwwMt7YKtjpmKKBPSIRw
 bRAVUnxsdvePbehx6XwTcbtUOVtpejRkQToQeHAapl+LDgUcYkqPHajBMaADz4YI/WOX
 /e8wK223U4qItV5K7EGMsjox4HmfZfK5ZCUziBLBEpX4SvZiB/gZlGJWM0ldx24GBKGR
 96Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=y2+CJpUj74/kWjA1e8DlG6+e9+bjuGwNQzeH9YZxlws=;
 b=Me2e6zqFoKYwtL5ENt3/eFPA1X75cY+lE6lP3OI463gMOCaFvNraIuQrL7RU6/EWD9
 vrOjql2QFJYMjzugMZ138tJUn4BDxW4Hh+dxzBbMnzeeizn6d+s/JrarTRmTO9j8XCqC
 oWMNyKQ50t2odgsc9GdLQBW63bqbzi//z7Van/Qj3e/Jt1Baud4kFuZdB/5K9eKDSCL3
 NAXZehAECWeaH01WhLLOdTmlL+boIa7hfZuJ6937UfGggb7bL46mvi7giNY7OgF6ZgU1
 uo5MHE8gf3HgkFWqecIG7iSqn8y/ulGGetyCRbXLpxTPZ0+PDc+kif8xssWj77wVg8XC
 uZ4g==
X-Gm-Message-State: APjAAAXxsI1/Ou6jzwG8LDWkWJ7hDXqpmOTBLRDVjrD5Pfayh+AOjUEt
 df/BqEvHM/fFqyCJk+23kYofps7IaYkN/sKc5HnHoxcT
X-Google-Smtp-Source: APXvYqwYzj5pOrpfaP16fKaiIbfJbYigBPs2txSIVc0x332IzvJ0ZiEcieH1dYYOPJHmpaFbEh2zbqpeCERjCJuj0d4=
X-Received: by 2002:aca:817:: with SMTP id 23mr22266179oii.5.1570994363231;
 Sun, 13 Oct 2019 12:19:23 -0700 (PDT)
MIME-Version: 1.0
From: anselme taf <anselmetaf@gmail.com>
Date: Sun, 13 Oct 2019 20:19:11 +0100
Message-ID: <CAOpAi0G-rVqysFFW2WxyEUi37wkUM+DrT02+JTgJZEbceejo8A@mail.gmail.com>
Subject: Need help in Qemu source code
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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

Hello dear team
I'm working on Qemu's source code, mainly on Qemu's CPU. I need you to
enlighten me on a number of points
1- How does Qemu emulate its different processors, Can I have a
diagram that describes how Qemu emulates?
2- How is the Qemu x86 CPU implemented?
3- Can I bring out a diagram?
4- How to display the TLB, the registers, the cache ...?
5- How are implemented and where are the data structures of cache,
registers and ALU?
6- How can I go about it if I have to inject faults into caches,
registers and ALU?
Thank you,

