Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46204C8300A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 21:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D2520BED
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 21:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwmyTiJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D2520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtxS-0007Rh-8P
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 17:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jTtwQ-0006aL-Lw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 17:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jTtwQ-0002dl-Cn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 17:08:26 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:46334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jTtwP-0002dR-26; Wed, 29 Apr 2020 17:08:25 -0400
Received: by mail-il1-x144.google.com with SMTP id x2so3845586ilp.13;
 Wed, 29 Apr 2020 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZKmOmQWNchllpHFerOMahyJhCu0arGhsHrYxlR6EX4c=;
 b=uwmyTiJcU07ADDWwjp3rkygnprTqrHo+V3T/o+ElES3JaY0y62+OhMc3e9cEqbdrR7
 tjoJwBoDiIaafma6vu73/oGlvM3o1pG4ZAXieDbkKhB3cb6YQZrag0wt9creGZOycVMA
 hxa9vrPJwTITT2aLNX7oLWV1QKl34D+PeHawaWsB42kNcNuIGUeLb0uw8izQ1f3u47Dh
 2pVz+Msvcgn2jeBr2mvBXCG5/4QK9jPGOCnbbzqxK5UXAfY0CZ6OVDhFVyiHvaHW/cfr
 WUV3Pxc+hoRjqbV4/0fBdNWV9uwhxNCeGTH7vngtr9bpYENFe728dBX3SF92NogqROQB
 Ak8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZKmOmQWNchllpHFerOMahyJhCu0arGhsHrYxlR6EX4c=;
 b=A954ULbnfnc7kaM2wdrOti0YQmR7k0AP62QmJjkK41AzgqTcFYU+5KF6dJ0HzyEWZ5
 6ifCNc/LzqwzV/3EaQDqgvUXXIOOKgqJvBuA07OmuhC//GZs32bGwK37vRuc2Zqjrex9
 wNdCyx+Ir1zVADqnjgoLCOkYcqHHwTg1cYG6MbbidT8JVh2EfTdBHzfcjH/L+aAG1S16
 D1oat6jIM3SLc2m0pBnCNqknqn5anS83SSjIIjfehgGvUqDBA8g0sXZfiJBgw8vD9is0
 4vs0uemdlvJbW4lBRFKfCQuU2kDlLm3is+56JcTJwfvYvY64w+y17yMIy0i8Pe+aZnO7
 dk6Q==
X-Gm-Message-State: AGi0PuYqX7dnLEqkkbo+7AuakOTHrmA9I98kBcjGeHyiqdD4cqQbo10Q
 BCyocTy/MwxbYLqu/lwwy7aGuxiMSm7DMHXAl2k=
X-Google-Smtp-Source: APiQypJtddMFTCos2prusOH04+xx+NYH48XpL4J4Uc0d+4ED1CxEwAmBGgjDBGCss6MeaU4NAc097PRJjX4WDUE1fj4=
X-Received: by 2002:a92:5b90:: with SMTP id c16mr293446ilg.276.1588194503547; 
 Wed, 29 Apr 2020 14:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
 <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
In-Reply-To: <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Wed, 29 Apr 2020 22:08:12 +0100
Message-ID: <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=josemartins90@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Your change just made it true for whenever virtulisation is enabled
> (in which case we don't need it).

This is exactly my point. As I said in the commit message, the spec
clearly tells us that "Interrupts for higher-privilege modes, y>x, are
always globally enabled regardless of the setting of the global yIE
bit for the higher-privilege mode.". HS is clearly a higher-privilege
mode than either VS or VU. So, if virtualization is enabled, HS level
interrupts must be considered enabled independently of the state of
the actual sie bit in mstatus_hs.

