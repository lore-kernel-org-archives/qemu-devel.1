Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1EC468BC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 00:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAD620868
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 00:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAD620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZP5Z-0002aC-2I
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 20:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51992)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hZP3W-0001QM-Ub
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 20:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hZOpl-0004Lr-6w
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 20:03:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hZOpl-0004L1-18
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 20:03:45 -0400
Received: by mail-pg1-f180.google.com with SMTP id h2so1959171pgg.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 17:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=UfN5Ps3CxtjSBHqQrng8JFYxHCePUVvB/RK4caGxegE=;
 b=TC5v43d5uYKlVTbj8eQeJSLRbkMpWh34yRBR41GWq5N5+sI2bKA/zbXses2mZR6/LY
 rAgzs3PCfC9mhHM7tdrSu/4DiPVCVZZk+QavwrLQI+DconitJrWmRR1IYo+8Pw1nODhZ
 5RYGsudXy2kzfRDDhTmIuRqTFA8UECqJEN9TgGd9P5hjXqyEvFUwGMRSGBd1DcsrdtYB
 wiAOQ5dMh2rx2JgeAY2p+QJRRD95feJ5mFcI5tzzGfDwqpFQp2set4owa5YeS1RHUdy5
 yH8uDUgrC1IaNfU5LdgO5s5nXWIsnGrSyrQZOtMxjtf+M/9ocegg1E0brJAPRMP24wvI
 FrMQ==
X-Gm-Message-State: APjAAAVxxtoNt/FtsDCspMFPnMyHUznfOCpLPVYistnJYAapqBBkaOp6
 qg7boHIkF9DrNufaaJI/BIq0rItRWmj1hQ==
X-Google-Smtp-Source: APXvYqxLOtjJ8txr5e2SZBJiTpv+o2h73W6IxX0mMTiNexNGwOmP1HUhyrT8RbAz6kTAYlR1vSzFqg==
X-Received: by 2002:a17:90a:778c:: with SMTP id
 v12mr8092548pjk.141.1559952223220; 
 Fri, 07 Jun 2019 17:03:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id t25sm2849200pgv.30.2019.06.07.17.03.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 17:03:42 -0700 (PDT)
Date: Fri, 07 Jun 2019 17:03:42 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 16:16:54 PDT (-0700)
In-Reply-To: <CAKmqyKMs4nt0eddFkXHG9vOdxnj=yB8jx8s9NivNiwvVg8TObA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.180
Subject: Re: [Qemu-devel] RISC-V: Include ROM in QEMU
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu, onathan@fintelia.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 06 Jun 2019 16:22:47 PDT (-0700), alistair23@gmail.com wrote:
> Hello,
>
> As a test of the waters, how would the QEMU community feel about
> including the RISC-V OpenSBI project as a ROM submodule?
>
> The idea would be to have OpenSBI (similar to ATF for ARM and a BIOS
> for x86) included by default to simplify the QEMU RISC-V boot process
> for users. This would remove the requirement for users/developers to
> build a RISC-V firmware. The goal here is to allow people to just
> download and run their kernel as easily as they currently do for x86.
>
> We would make sure that it can be disabled! That is users/developers
> can use their own (or none) if they want to. The idea here is just to
> simplify the boot process, not lock anyone out.

I like it.  My only question is about the mechanics of doing so: are we just
going to assume there's a cross compiler in PATH?  I guess that's less of a
usability headache than needing a complier and a firmware.

