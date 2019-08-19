Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC305C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E46204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E46204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzm4W-0000py-PO
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hzm3i-0000M2-Pe
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hzm3h-0002RV-S1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:07:10 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hzm3h-0002Qy-Nk
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:07:09 -0400
Received: by mail-qt1-f174.google.com with SMTP id j15so2881301qtl.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bzcsCdo1VQleuN6Y+oIPil7cZdGgN6N13tD4bwPyKoo=;
 b=apdG7P3t/GUajYC9+35MX+TNKPmV0IJ5+nnHo6/V6Sg29Blv2AzreT1eBoRaM4udxH
 OPgML5jTFrfZO2v+cWwP/6pPmC83062Dkv2NYQfsDDe7vRw4wd51fxZxoC+46gp4DD05
 vEgs3uBDdBAH/gJrKGSdai7pQcKNei0gXlYwJ9qYFN6mKvv/j/Biej2nHg0TPu2kQt/0
 fBlx/uQBfuCB++lQ7owMoJxVyWflUQpjytQ1ElRH17c0aLL92Sh6cQw8TacEwSvb2PnI
 VKE3N8/2cTRCTmCkAicaxxe38720+VQ4RjSduDZDN70utD2wQUsO/h4Benrzi6IokHgN
 V+EQ==
X-Gm-Message-State: APjAAAU4VbBoLvWtMSltR2qyNPKUBLxmyhwC6HcjvYHxNnGlXbYA1FZj
 0yApuiXp1hUUgghoKhsLRDtxgNFZV+e8OkZ9euc=
X-Google-Smtp-Source: APXvYqwApQaCL7JPPu3Pi+g9OpIe+SfwAuMWCtMgzLWPsGfv3UjL8Mt93aOS1ndOMjQU2pa6s+Bwv1JaWW/ouWbX6TI=
X-Received: by 2002:ac8:3364:: with SMTP id u33mr22595096qta.115.1566238028541; 
 Mon, 19 Aug 2019 11:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QVKV4mv6xJS0Oyx0GZ3QtLM+NhQGhyK24WqpuBFmg129A@mail.gmail.com>
 <20190819105711.ea79a7962ff9efcc7054e396@danny.cz>
In-Reply-To: <20190819105711.ea79a7962ff9efcc7054e396@danny.cz>
From: Paolo Bonzini <bonzini@gnu.org>
Date: Mon, 19 Aug 2019 20:07:02 +0200
Message-ID: <CAHFMJ7teOmtBGrhrh85fr0M-BiStNqpFZ4RXr4LgwYg4sS668A@mail.gmail.com>
To: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.174
Subject: Re: [Qemu-devel] Patchew s390 QEMU build issues
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The machine has been reinstalled, I'll leave s390 builds for QEMU
disabled until I'm back from vacation.

Paolo

