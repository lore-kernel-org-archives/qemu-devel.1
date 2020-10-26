Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4609020735
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfI1TVCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4609020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWvkD-000120-Ci
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWvjY-0000M9-Rd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:11:56 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:43580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kWvjW-0004FW-O9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:11:56 -0400
Received: by mail-yb1-xb44.google.com with SMTP id d15so6691068ybl.10
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 23:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C5i+M50hg0uWicmr3zNgjgQK7+KHhxAS8iADcDyxE6A=;
 b=dfI1TVCEQMZi6rvi9gyd1cvlUUgdzJZQkgGRH3OHupoz02jv/P20lgNSTUVyhSAH3W
 0j6LXF330q5LGrOPxckgvIPuo4e8emjFQbAA+uhvaPq9fbotiD3uRQkqivGBqD3jYZHe
 ZiJtagb274ZZyUzAnA3k1DKTUJoiyT/n8Uv9gy5h08EGW2SqsyAMFnybHQV21/NZ3SE5
 xlwHRAH9CyuMr0SmfyXlKvEccdrpifSVvnjsQRj0W2jA6hmueurhf7djGcyhBz6j7q3g
 EuP7VrLkx+RGbTN3DX7t0DErU65AvKxPGeJWcEhlpHMUfbYpZ8AVgRpw2eQLSA2htKBV
 Qjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C5i+M50hg0uWicmr3zNgjgQK7+KHhxAS8iADcDyxE6A=;
 b=TLCKdxsziL+TDbcoCYgxFHjPiPT2zxxGngu1WHEQE/IaC13uiT5koXP7pc29HrBmYW
 RYTpJGYPLyycUxsl0lzAok7PqrrNngV2aZNQVyk6jKam0SkWFf7Q+MO8gS+B1mSJxtkR
 r4XyNROeZaqXXBz+2NYlrKz5ng6G8Fr4w8h040rkPl0VpSDPGpdWViu/jzt6TyxUiEzC
 +Xupya50ZIfWzx93JxBwAzGlRJx3O4OaCNlxbRAVsiJkDta+zci8co3scjyA68Wr0FIQ
 gx+YVsRumjm9AAfGfE0mDYYdcLc+rNdJcKmA+1yBkvRCVzBTrLUag2ThGsVrB91N0r1G
 scxA==
X-Gm-Message-State: AOAM533suGQ3ePUSgZ93xcU/MV+CADqVP2F4hi5S3IJfATfT9ARY5hE/
 oxFQ87ZmXhyQutZBCqYq8qf07EqmP34U3a1q2W0=
X-Google-Smtp-Source: ABdhPJxa4XCSGkZQwjYdP2EkNI95mYwKEVH5d93lUeO17YwG4Z6PSCQdrCPODoZ2F+fBED1yyZTgw3lXdfPeUbWS2cE=
X-Received: by 2002:a25:4113:: with SMTP id o19mr18185042yba.314.1603692713217; 
 Sun, 25 Oct 2020 23:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-3-keithp@keithp.com>
 <CAKmqyKPtV4fsKhaaiSTwsOgi=w-B3oUP=_93ftLgpqBY6874iA@mail.gmail.com>
 <87blgs7a3x.fsf@keithp.com>
In-Reply-To: <87blgs7a3x.fsf@keithp.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Oct 2020 14:11:42 +0800
Message-ID: <CAEUhbmUwqREHDeSU20ohDx8hZQM0QCiPCdCMaMAY5w-qiyWBtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add sifive test device to sifive_u target
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Keith,

On Sat, Oct 24, 2020 at 8:17 AM Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > I also don't see this in the FU540 memory map.
>
> Same as for the FE310 -- this is a QEMU-only device. In addition,
> OpenSBI expects to use this when built for QEMU.

I agree with Alistair. This should not be put in the sifive_u machine.
For sifive_u, the hardware provides "gpio-restart" to reset the board.

Regards,
Bin

