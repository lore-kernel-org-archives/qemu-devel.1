Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D260C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344E92146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQd0tjG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344E92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9k6-0002A4-Ah
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1iD9gZ-0007hv-Pn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1iD9gX-0004ea-S3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:58:35 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:36207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1iD9gP-0004Wh-Q8; Wed, 25 Sep 2019 11:58:26 -0400
Received: by mail-lf1-x12c.google.com with SMTP id x80so4626961lff.3;
 Wed, 25 Sep 2019 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LPybhqcg4KYl7tTtB1VIz8o+ZmRqaHgcq/IiuizZPX8=;
 b=sQd0tjG2HMr3X7tN9CZ3ISpFHawJPMemD0F1vvvce8OLc8tlSLmSOt2KEPxajaFAA1
 dMH1IgWt2RrXBytuYA2B7lhABZa3guXBwtMW8uUEXnVhjieFv0xPappdgNWhK0UwkxNs
 7WPhbmvQsTlJ+6JbXDi/56D2iPU++Z7mw+9mewDHtnuFxtuq/EqsuPhX1z00irygzSNX
 k3RNoKcfdEQDUqillARIE9kiIbcEQVGW06wKVPl6fZ2U4miw/tgfxgB0diMy21whaCHD
 LeVgwKdZ4lvBCTcYtcleuVq9loUVbbG6DXKnixlOFiSM6xY+YOAyWrRMIpe1cl/Hx/Mc
 FHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LPybhqcg4KYl7tTtB1VIz8o+ZmRqaHgcq/IiuizZPX8=;
 b=PCVszIHclculYNNxzztsr3bT9JPGgjcTxy1siq+A+U18lx7McL+c6w9ErlVB8VdLq8
 /o4I2ByuuqSp0yipldJ+F6bvzvLfYJ26VyX/BUupyAtD4HkAFuNY1IM6/gEFKSe3HqON
 mzPGMRt8VZ6wlwzpF4RAVpLKN89obn286pqsGGTbv6GbQSE/RjwKBuS759QDBBAwuDHc
 jci+B4jhe7gvI96x0HUCGa3gMTS5+XXm6cEcVo5whM7ewu5MN2s8RBd+BRQVrAflxooF
 E7a5qgTsj3CW457KPriGc4TTuVXTTI7E8WdcKprXoobCwfCQamUPacSj82zOG2TUnABQ
 C8zg==
X-Gm-Message-State: APjAAAU8OiLZJriyWP/yQP6cPzR2ObaR2vgF7ICJJoGepqBJ1SVSmKow
 keMtWD3yQte6wxua3n1QdAJXtbP/nOlk/yfdUV0=
X-Google-Smtp-Source: APXvYqwNsils0i60s7gLgDtteD5RoKACXD80SnQrZgwyF4kYczgoOFQVZ4x34FH0wtJ8CFQWlYAN70CvtlI7m+gml/s=
X-Received: by 2002:ac2:4427:: with SMTP id w7mr6686285lfl.143.1569427103391; 
 Wed, 25 Sep 2019 08:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
 <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
 <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
 <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
In-Reply-To: <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Wed, 25 Sep 2019 11:57:22 -0400
Message-ID: <CANnJOVFkUAS3mP4y0mu+jCajy9m4hDK389xpZz4wza1t0Bvo_g@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12c
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> The specification is very clear: these bits are not part of ppn, not
> part of the translation target address. The current code is against
> the riscv-privilege specification.

If all of the reserved bits are zero then the patch changes nothing.
Further the only normative mention of the reserved bits in the spec
says they must be: "Bits 63=E2=80=9354 are reserved for future use and must=
 be
zeroed by software for forward compatibility." Provided that software
follows the spec current QEMU will behave properly. For software that
ignores that directive an sets some of those bits, the spec says
nothing  about what hardware should do, so both the old an the new
behavior are fine.

Jonathan

