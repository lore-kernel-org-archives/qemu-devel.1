Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49621C32792
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 01:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143FD20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 01:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLhdHah0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143FD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF7D8-0006N6-5s
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 21:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <harrynjit@gmail.com>) id 1iF7CQ-0005yi-1X
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 21:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <harrynjit@gmail.com>) id 1iF7CO-0001AW-UC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 21:43:33 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <harrynjit@gmail.com>) id 1iF7CO-0001AH-QC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 21:43:32 -0400
Received: by mail-io1-xd42.google.com with SMTP id n197so43584140iod.9
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=EGN9BdRgnGW8/+ZJvEnOjum98A56x3p1yBpV8CkMJzk=;
 b=PLhdHah0u9NhzPKw2+ujPtrG7dO6edVBgwlENIcNVzefxYIeC84mq1/SzOyy6FkYNl
 PE75pj9BfLKNpe+/nEtqHffVsl1Yeg+a/KhWsCrRwjDvGDcbcNoWudeeFgATBo9PPOda
 Opq4/x65eKnJevI9v1v+OdV2BO6lxXH87UD9uP2K0Fgc0AzfOvG/MibQtNH9QZAm53Tq
 85l40+XOePFOJ2Yin1VBLzk5UzH79HQmjkqeD3/EcCxoHlnSgP+ovdcw8uAd19onRTTb
 v1uwoyRZ/Cx6w8I5xv9KznquWCaSjxg9JDNDEAWonqtS8DnGg4lnIsItdrwqsWLaY1kQ
 aQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=EGN9BdRgnGW8/+ZJvEnOjum98A56x3p1yBpV8CkMJzk=;
 b=R7UHr4xtSHeizGaaMst0z1HvnO19KayJOKrBjb2PBLF9xAZOvzlgxDISph1VVf7YwC
 3M6CukFA5cpbenmGtS6sPVlGwlodWlEReTNYIpJT1SV7ctHPWskMKOU10gBTaBgKVK4x
 mYJlLc0ZC00FjWi2Ko/3soTJ1tuv0BsRoGDx8vNi8HJJsIgzsjwF5wMY+9pPpvKQX0S+
 tTbCFBYM4Ybg/G6MA/wD6dUNboY4Z5/9M93wcSTQZxo5vZ/cBVYiqBlY0/1WR/HZnUQ7
 afMTqhCNbnftEdaYHKZaE/oTVZVOPJjjZTRdBd6v5U83Pyt7fCwayRmG/8ogHIZD7svX
 tqag==
X-Gm-Message-State: APjAAAWMGz+jdD4CnEXRrLo+evYNv+QZWf+mqn4wJDb+xQ7z3KZmzDGb
 STeK23i7NflayMg34LrWqZXoEx7CESiTBUaXQOw=
X-Google-Smtp-Source: APXvYqwYVSV54eJ7AA0C2w6HU1DmX7uCAUjLFBm4MtKh4Yq0bsmHjX763Yprdman9iloHLF44Jp0Za6aj8z2VqT+yfg=
X-Received: by 2002:a02:c958:: with SMTP id u24mr21773929jao.113.1569894211434; 
 Mon, 30 Sep 2019 18:43:31 -0700 (PDT)
MIME-Version: 1.0
From: Weiwei Jia <harrynjit@gmail.com>
Date: Mon, 30 Sep 2019 21:43:33 -0400
Message-ID: <CA+scX6k8679-YUDc+OH5q8mCHUpr9E2u=Fs-3ZtF7kFqRiL9Ag@mail.gmail.com>
Subject: About the idle driver for calling MWAIT in QEMU/KVM Guest without VM
 exits.
To: mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: gsomlo@gmail.com, agraf@suse.de, kvm@vger.kernel.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael and Paolo,

I read your patch[1] about better MWAIT emulation in the QEMU/KVM
Guest. As shown in [1], you mentioned that you were testing and would
post the idle
driver calling MWAIT in the QEMU/KVM Guest to avoid VM exits. However,
I could not find that idle driver. I appreciate if you can post the
idle driver and how
to use it in the QEMU/KVM Guest. Or, you may want to give me some
suggestions about how to use MWAIT in the QEMU/KVM Guest. Thanks much
for your help.

[1] https://patchwork.kernel.org/patch/9674991/


Best,
Hary

