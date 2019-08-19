Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71594C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB8D214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="boTVdzNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB8D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq2g-0003Eb-6v
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1hzpU0-0003yS-13
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1hzpTw-0001m5-Qa
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:46:31 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1hzpTw-0001hb-CW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:46:28 -0400
Received: by mail-pf1-x443.google.com with SMTP id d85so1968238pfd.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ikavlIOQOEnel5CO+3gZOR2OAKyiRO+kaAZwrxJfrzg=;
 b=boTVdzNxiFK/APPvyrHAKGZ+XUFBxDu06Oq1BPKodzjO7RWbVQ3rsBBbveHGuCGHHT
 h15V2eZ+2XhEvWL+O/3gwdHxun6T5BJaSVTkeFcyide3xd15zyPFayBoYCTxiQDRqled
 4+RE2P538/o28ox8JLgfY+1+++SIKyg6g4HuGidcqcLIembnD2nIOIk1XPw1fM8vBRQH
 W4DP3floDjhOP/tMlE93YXNysrbobHKh4qp7XOMPtdA1q3xGfGJuwwl++63wUrechVmc
 S8tTQFB/OH1e4ZovT2iCKAfyTb1X9yhcX2tP6Hgnzna3PQ6j1tS6DVcHOoKlQ8f5Kf8i
 bcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ikavlIOQOEnel5CO+3gZOR2OAKyiRO+kaAZwrxJfrzg=;
 b=h6J1tVa7BkVRJ0NI4shi0ZYdNFSDYw4Zoh0wrVc3qI/AP9tRtBp8W/T5blK+i5558F
 x2tWW6yHy3vx9DAFVWicwCeN3LKvZ7cTA132ztcJvCuKLJgmH60TG2NjGrQ4oZGKzOS9
 W/F1EDfHCk3tZOyPz2kQaBbV+mYVMqVPgCpxD3xGbmo8BD1L8XG0vG25MA3a3fTnGOTs
 NjTCDtWYskzJUsFCShtOKntgMS5QRdamzsPty22Cp6GOchRAd/dQwm7xD0O+d7ycinCP
 HGgu6VBaS/NggcIfpkpauaGPVCURUwuKCtwfQQNGvhYBchxPxxXloMEtkM539eh+Dn7V
 kKKw==
X-Gm-Message-State: APjAAAUVrxoxlXW+nLuLQ5+9au2CGbXfzGbTWj39AQR6+BO2iva47IjZ
 xauREi2iG+AdvL/+D06BkKxxoxZmykT29TpEcSo1Hg==
X-Google-Smtp-Source: APXvYqxRx6oUNp1G9JHtrYWLK+lg+ZxfFHsYR09xUd7U/+vXBqqUJxFeCPikTgVX0o5Z79OgQi3+vUv/kfGUwpI2+pg=
X-Received: by 2002:a62:7513:: with SMTP id q19mr27647688pfc.192.1566251184064; 
 Mon, 19 Aug 2019 14:46:24 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 19 Aug 2019 14:46:13 -0700
Message-ID: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
To: marlies.ruck@gmail.com, qemu-devel@nongnu.org, riku.voipio@iki.fi, 
 laurent@vivier.eu
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

I have also experienced issues with SIGRTMIN + 1, and am interested in
moving this patch forwards. Anything I can do here to help? Would the
maintainers prefer myself or Marli re-submit the patch?

The Go issue here seems particularly sticky. Even if we update the Go
runtime, users may try and run older binaries built with older versions of
Go for quite some time (months? years?). Would it be better to hide this
behind some kind of build-time flag (`--enable-sigrtmin-plus-one-proxy` or
something), so that some users can opt-in, but older binaries still work as
expected?

Also, here is a link to the original thread this message is in reply to
in-case my mail-client doesn't set up the reply properly:
https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html

Thanks,
Josh Kunz
