Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1547C4321B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31BD2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o02vdxRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haRmD-0001e6-QC
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 17:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ali.mezgani@gmail.com>) id 1haPwr-00080v-EA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ali.mezgani@gmail.com>) id 1haPwq-0005J4-Bv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:27:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ali.mezgani@gmail.com>)
 id 1haPwl-0005Dx-8j; Mon, 10 Jun 2019 15:27:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id s15so456953wmj.3;
 Mon, 10 Jun 2019 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:subject:message-id:references:from:to:cc:mime-version
 :content-transfer-encoding;
 bh=OfbsNFVwuZJcrP6HY83smkRTXaZ90KkPSNbUmAkVhYU=;
 b=o02vdxRLqV0x2TL0X9wjPfitgiU+GqQIAirNhHRAP0CpcCNvL0RpV/7ol1JVYOS+KI
 6mKzjSzVgxPDAWuM6OmKfsKCt8/rdt1FaTFZwq7iSfeWkk1riI6wp2/4uoa1XcGqbfPj
 pBX9A3XH1coDj06At5RTQBqCGS1hoh+JyRzrlsz2SNjE/J75dW2kGtSPJTAoXZGyIkB/
 F9Z4I7XUWw5Gh8FD0/YB5T2P1I5E4JVWvDTYCoKJoXlCZFvuMOWmFi8DfFuXH+2bpuTt
 0r4qZOpja0WXmhIXMrNRXDZ4P3yobvLI5o70y2MNoOS/8rF3UNoluVnN+lU0oslsoKp0
 sREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:message-id:references:from:to:cc
 :mime-version:content-transfer-encoding;
 bh=OfbsNFVwuZJcrP6HY83smkRTXaZ90KkPSNbUmAkVhYU=;
 b=VAUB2kUUppwIw4SYlVQDcVxt9UD/WzaTE6F8fLESMDMJ5ZtvbtRc6QEXjhPN579s5Q
 l96ZdJO95bMZkLMAOGkBq5oM7281Uce2EL3rpIipEbCdFrOwy5IELwbOUI+7y5aLVYVL
 FqS8LWFoVTVlcwov8cIyMB09VZlE5v9N0Os7KirRUAU6U8z42ChFZOF/6FHTSdF5ZlMz
 KjETrdTnYT+nb/Yrs/21Ac6KzAyHHOKQjoZa2kHWYkj13FKIrL8Xj4aw/MIyS67pz9iY
 OUCeLHA7ejVKD2rgeNtZOQp7nKddQiZYGScnj2SuTLDfNhdVhUkJlGfjdkcCOXNcTmfM
 DW+g==
X-Gm-Message-State: APjAAAXSmbH6Y7M1FctkqS3lU5IEM681+ANxLJJHvrztkXxHQmTz2oFd
 2VF00ntm7QsiorMWXWbQfmU=
X-Google-Smtp-Source: APXvYqx7T22ARwou+/g2DEP9+q6Qz0p5SkDXHqyEvLGWpW6k0m88TXN6E6YHnGlowTnYsU6EpJJdCQ==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr13625368wmb.123.1560194828485; 
 Mon, 10 Jun 2019 12:27:08 -0700 (PDT)
Received: from [192.168.1.220] ([41.250.232.80])
 by smtp.gmail.com with ESMTPSA id 88sm19573484wrl.68.2019.06.10.12.27.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 12:27:07 -0700 (PDT)
Date: Mon, 10 Jun 2019 20:27:01 +0100
X-Priority: 3
Message-ID: <-2xywm9-ifb5yxlyz8y68ukj0nxy24qv-dgwbua-uu49fa-7xmm95-lpocej7h67y1tkkit4-31nus5-2bayju4z2jwk-kie60g-zanq099a87cdol5jfg-f5bb5a-yxekc0-x2g2ruj2xqm3-y3jyo2-un0xhw.1560194821347@email.android.com>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-29-peter.maydell@linaro.org>
 <da80c3ea-5a33-e7e0-209e-89a8413c8f06@linaro.org>
 <CAFEAcA8etr7_rmQsQcUY+cPHZEZna-An+r5TPJtMb4OQO-6Dsg@mail.gmail.com>
 <b9ac8354-6bb2-0080-f597-706b4b94009d@linaro.org>
From: Ali Mezgani <ali.mezgani@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-Mailman-Approved-At: Mon, 10 Jun 2019 17:22:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 28/42] target/arm: Convert VMOV
 (imm) to decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

