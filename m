Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C853EC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC3E20844
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC3E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklic-0002UL-VO
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hkli9-000244-Ro
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hkli8-0002DD-Uz
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:42:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hkli8-0002Ce-OJ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:42:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so18734116ljg.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 01:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=cPf0d2wTAJY5YS4rWQhBSWq2io4ceTTFA1ysSpT6pqg=;
 b=Ts69HUiOj+nC5fFq3kKnv+PVdcpWhcarIXVT6Q1s9Lbrd6LthP0w6VsMf/ubT3gfhM
 SyWDVzQRLDXazYOCTP9lVJf+kpgoIbZmjAsgYLg74tlR08TTHrY97qe67QJ57fJ60/1D
 tNeXdT9pgiGw0irmpNhQNdbRDmUnHKGt01jfqVUaJPk+LYJRX4wAYl+LaBfLH+3XqcX0
 Qta/C8qk5Aq7g219vUDRIjQOu4poka9q/9Sw+mJtWgIMuKZuwhAhY79vddNlqHzJAuDb
 gCvbiprZ1YhJvH+J+4Suu/FR06XF7tClPNEF+60zJb2PxRAZ8qL6XYAwCrx5QIMK8vjQ
 zPMw==
X-Gm-Message-State: APjAAAWHtFUeG5TJHhuC81p3E7obOAevVIdpLKQEXiRkAfaLoCegqsLF
 jriCqayZRtZDDwYOZjtUiUMBXg==
X-Google-Smtp-Source: APXvYqy41qd1KxNUxB0gp728wcOiPWqEsZwHMWTood2xWsRLj592Dh28zy75OlUnpgC3o8UBLU21Lg==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr13355936ljj.137.1562661771152; 
 Tue, 09 Jul 2019 01:42:51 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id z25sm1909232lfi.51.2019.07.09.01.42.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 01:42:50 -0700 (PDT)
Date: Tue, 09 Jul 2019 01:42:50 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Jul 2019 01:42:46 PDT (-0700)
In-Reply-To: <CAFEAcA8Bf4Zt4U6p3uMsn8cwv+=7ZHxOt7y2FZzB8TYkyo8AHA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-115240ce-f484-4ad9-ad3a-2103abfb1579@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
Subject: Re: [Qemu-devel] [PATCH v1 0/2] RISC-V: Add default OpenSBI ROM
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
Cc: qemu-riscv@nongnu.org, codyprime@gmail.com, anup@brainfault.org,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 stefanha@redhat.com, pbonzini@redhat.com, alistair23@gmail.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 09 Jul 2019 01:37:08 PDT (-0700), Peter Maydell wrote:
> On Tue, 9 Jul 2019 at 09:35, Palmer Dabbelt <palmer@sifive.com> wrote:
>> I haven't looked at the code yet, but as the last one was fine it's probably
>> OK.  My only issue here is the timing: it's after the soft freeze so if I
>> understand correctly we're not supposed to take any new features into 4.1.
>> That's kind of unfortunate because it's somewhat unobtrusive and super useful.
>>
>> Peter: would you be OK taking this some time later this week?  I'd want to dig
>> through it and then bang on it a bit first.  If not then I'll queue it up for
>> 4.2.
>
> The first attempt at putting this into master got onto the list before
> freeze, so it's OK. Plus this clearly will only affect users using the
> riscv boards, so it's a limited-scope change. So I think we're better
> off putting it into 4.1 rather than not, assuming you're happy with
> the level of testing it's had.

Awesome.  I always test stuff myself a bit, but with any luck I should be able
to get a good look at it over the next few days.

