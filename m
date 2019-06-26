Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC5EC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9B820B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9B820B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg2sh-0003M0-Tl
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39695)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hg2pc-0001rU-BS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hg2pb-0004r0-DF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hg2pb-0004qJ-6p
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 03:59:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so812652pgp.11
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=XCH2GgsIyoksdNlCCC5x+ZCA7cM41Mob0pW7J+N8gKg=;
 b=jiLX/Ny+v7Q8e2W9ypQ7pIloPVJ0gV22IqX9zXWoX1rcDgrvxET1AeJrIAPNHjYgn/
 Vl/L34u75eVMgFdWlNT6D8tyG9GSn0teyWh6+rMyF9enKSgLw6VbQ3J1SMx2EYUirntO
 isUWvhZfu+6161gqtqXdK0LqUS1aZJMjCwL9hbCp+ahfenwrn1xiDSGmWS/55xfMPtfX
 rSPNvlSlPDFnZ5+IqsNblY+fNH0w2GcwNGoE0b9UclE7Y16ukocYZH4xsg0+kN9+Vb7i
 EkdOseHHZPpwuwgA9x2DteTZmooih5d9YaGj6ZuQRwza+0L3zj1D3GJxEghMXf54QdOZ
 5fUg==
X-Gm-Message-State: APjAAAXFe2KfNh9kfr4x15JwexaleJWdgHVvNfjvuWZOLNJEAHOfFK5m
 VokHnRSQwdsV0zvH+P9ETkFuY89kC+6hyjsd
X-Google-Smtp-Source: APXvYqx3oKHjXknjr/YCF+5H/pL1JCQT/W8qrJ9xpIofBJNySturdcMWYdEyNvlWFwQ4ndG8XdINag==
X-Received: by 2002:a63:3683:: with SMTP id d125mr1679724pga.252.1561535941544; 
 Wed, 26 Jun 2019 00:59:01 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id y185sm17147727pfy.110.2019.06.26.00.59.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 00:59:01 -0700 (PDT)
Date: Wed, 26 Jun 2019 00:59:01 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2019 00:58:10 PDT (-0700)
In-Reply-To: <CAEUhbmVjExqi9dbq2yuKC7mw1GczxY36AeUAwkQz2+Cc5KWnKA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: bmeng.cn@gmail.com
Message-ID: <mhng-6c6f8a3b-57fd-4e1b-8626-6e544789ff44@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH 1/2] riscv: sifive_u: Do not create
 hard-coded phandles in DT
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Jun 2019 18:47:15 PDT (-0700), bmeng.cn@gmail.com wrote:
> Hi,
>
> On Sat, May 18, 2019 at 5:34 AM Alistair Francis
> <Alistair.Francis@wdc.com> wrote:
>>
>> On Fri, 2019-05-17 at 08:51 -0700, Bin Meng wrote:
>> > At present the cpu, plic and ethclk nodes' phandles are hard-coded
>> > to 1/2/3 in DT. If we configure more than 1 cpu for the machine,
>> > all cpu nodes' phandles conflict with each other as they are all 1.
>> > Fix it by removing the hardcode.
>> >
>> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>
> Can this go in the 4.1 PR?

Thanks, I must have dropped them.

