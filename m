Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4EC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 21:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016CC20731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 21:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yee5QKs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016CC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUH44-0006zL-T2
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 17:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jUH2X-0006E0-St
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 17:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jUH2V-00087o-5d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 17:48:16 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jUH2O-0007rd-1N; Thu, 30 Apr 2020 17:48:08 -0400
Received: by mail-io1-xd41.google.com with SMTP id b12so3121933ion.8;
 Thu, 30 Apr 2020 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R7CYPxPrtqSpJXFUByK/VjZUUxaG6Orno5eFE4pEZZs=;
 b=Yee5QKs9kgC2BARvckJuYcdfUsuxEtrpbdsuyCPLzv+Z7N1VhIETxV5ili/xtJNa7z
 SVHU1e/RvEdlkzSc55/bpUtA8DoNyL0dp/yKTogdr7IEbUuykRAVhuS3pk7hy2jV3hcG
 jn+O5EmsePUxvlDKf/aocAN2AECK//8gpAzQ7WoSainK5m3aqLeXUoaWyk9jJm9CT6zb
 zSi0zteeFG7y3yLlH95X1AghC+v/HqVq3D9Ew4xCtH/1bbZaz2ClIKYT6Pr2qPWcXI1C
 WLEctSzGHuIYOMwo76+3QTOsKwVcfdopvQwR7AAHOcHDg0oPuWqvAqa1JTt1PhEydaAt
 c/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R7CYPxPrtqSpJXFUByK/VjZUUxaG6Orno5eFE4pEZZs=;
 b=gEa3H+AzzFBr7IzNvaJqXMsRvebhbbugFWNNeYoloXPaFssS0EGH8gXdBGInFIBnGp
 jetlbAo1UOBdRiwa8heuQ8dX3XvpffRZVbqIL+84IYJouieWCke7or+f1vuLR3FT6gu0
 dMsALPQeJdWAG9g+4NNox7f2fnUiCKCQFILOOkav6bQLznxOhZ6D2v8U5vMwPAhKvBjL
 cYi2yS00Lx09MU7u5s5T/B2O2h6CrwgFcCChFP4JXL6jzwcc5L8vb1/7mMvQNPbUPY/5
 bvtkmwpvQq/SkcS5Zz+3bbLJF7wps48mGrLQuV99/R5xDsmfTxqBiKv7mBJyG2GZZtex
 tmYg==
X-Gm-Message-State: AGi0PuZSSY1Hlj4vg+p9GLgWnvdjd0xDiivZdSYl84inXLLnQPwWQ9TK
 njsNUX3QPBsRL7Aow0XfKn27lsuJEMjGWLIgQzQ=
X-Google-Smtp-Source: APiQypJ4mCpUO8IhdLrK30WoeCt6rN/HBe4BA+6R2XV5bp1ZQH8CRiuj+09nIzr/Q5usLo3qhpYk8zkUkFhFbluwTEQ=
X-Received: by 2002:a02:c7c2:: with SMTP id s2mr480881jao.130.1588283284434;
 Thu, 30 Apr 2020 14:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
 <CAKmqyKPDzusVqzCFwCJ+2gY0qchguhR57zHNkE-0MTeffKs_OA@mail.gmail.com>
 <CAC41xo3qeQZ+i8XoQq3j80_JDEoL2yMA__arpmE+GXyjX4c1sg@mail.gmail.com>
 <CAKmqyKPJ6QqUULrDj9NX_bLdnjsjzPOGcCBH5q23fG=ScT_NzA@mail.gmail.com>
 <CAC41xo32aWNZteKP-95AtFXQo3w_Ey-7MA0-dL_uJmEMScAuhg@mail.gmail.com>
 <CAKmqyKOnpJQUHVnzGVBjPkib-Z1vfdWqLx1HmfbGascFFG4DVQ@mail.gmail.com>
In-Reply-To: <CAKmqyKOnpJQUHVnzGVBjPkib-Z1vfdWqLx1HmfbGascFFG4DVQ@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Thu, 30 Apr 2020 22:47:53 +0100
Message-ID: <CAC41xo2-knUMRVALdftzu4cNz5u5UmBf1aK=mAt9YKzvOcCjpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=josemartins90@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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

> I'm not sure HS is a higher privilege mode.
>
> HS is privilege encoding 1, which is the same as VS (VU is obviously lower).

I just checked the spec and it doesn't actually, explicitly state that
HS is a higher-privilege mode than VS. I thought this was something
implicit, but you might be right. I'll try to reach out to the spec
authors to clarify this.

Jose

