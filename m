Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D8C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 07:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8072073A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 07:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEByfTPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8072073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipp6O-0001au-Ls
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 02:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1ipp5e-00018l-Sf
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1ipp5d-0007jr-Oe
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 02:52:18 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:37772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1ipp5d-0007cr-I3; Fri, 10 Jan 2020 02:52:17 -0500
Received: by mail-yb1-xb44.google.com with SMTP id o199so390442ybc.4;
 Thu, 09 Jan 2020 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pGc28JUK4brkkBXgGYVjWG6E2diYpG1C4549iKELVuY=;
 b=mEByfTPg2xYtDNJeUQ4bPizh4zHOR9LBehXyNnenOJtWzb78c/jUDtWmlxeFhdI9/A
 DxlE5ZXhrxIrmgK3ZyyuI4gmvQ2oVzMGZr7Mzpor90NOiylce6Fn86YHQaAIL2yC2xYX
 WtIuu0+zpGsO65aQLzUxcmyRk6N51fEkBrVRq+VK9B6HQ2rMYNIy6o13BjE4vWyIKssR
 lafFlhJhkFMstGaiwBK8AKEBJGeu8wemMeIEtggCnZqYomIGxIh342mw3m47wVgQGqhs
 O/BuROKcBzan83IlV03zfnUFOtSBzcqihkzpxUhWWV1qdPIb1mfaW945r4YiGdxgxFiO
 rtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pGc28JUK4brkkBXgGYVjWG6E2diYpG1C4549iKELVuY=;
 b=iioSzntMPiNQpbTLbhm6S7z1+xbWxOl93wUFxJoUEgZOs0vSzbfhiaSy/I1Ci+lMdt
 tW6kZNf/lkUcIegimF96a/zkGzRWlySRYQZo8DiyV5YfiQ+pjBM6TK4LBxM+0dS0abTq
 Pejh8PX/OpGoG0iZrjTkHlOPFKXHkjfmKB1lkOlLxl+lzCAICnvhe0Ewkck6dzXonRMT
 NcyRWZYi81y4mrOYhrQsnhELvFyumOobxo1yrZm9IalwRc9mkkh5LBVzl34vzy/2qkWp
 stFg46XSdORFGeZyq80Y5U8R6NyLpQRU3i+aN4IqKvpK1iwe30WTTmwyq6r0Y00z6Hgb
 80sQ==
X-Gm-Message-State: APjAAAXs2cfqEU0JivXaEexqw6zghBZNxqMzqPChC7zcT1eJZVp1hX7Q
 1oaEiKvl5XamWYO3QXw8n24L2aSnMjRBXFWHQi4=
X-Google-Smtp-Source: APXvYqwH1tzEWsjJY/tum0YIpQntOtbjA1v70r9i2G5YJGspTgGMld42roZwsCla5+VSxte8x7IvWY8gQlZYRrb4/pM=
X-Received: by 2002:a25:b1a7:: with SMTP id h39mr1265160ybj.29.1578642736052; 
 Thu, 09 Jan 2020 23:52:16 -0800 (PST)
MIME-Version: 1.0
References: <CAEUhbmUuCOzd_Y6ip_oh13gt83rM8EffdXWRCa=KybOjAvEN-A@mail.gmail.com>
 <mhng-b2e05f4a-7c3d-4be1-a843-a19b4054760a@palmerdabbelt.mtv.corp.google.com>
In-Reply-To: <mhng-b2e05f4a-7c3d-4be1-a843-a19b4054760a@palmerdabbelt.mtv.corp.google.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 10 Jan 2020 15:52:05 +0800
Message-ID: <CAEUhbmXRaHqxNt2XCgsjUDfR+VoMOjb5f38V6Yu35HWV1nkKeQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Fri, Nov 22, 2019 at 10:38 AM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> On Thu, 21 Nov 2019 17:10:18 PST (-0800), bmeng.cn@gmail.com wrote:
> > On Sat, Nov 16, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> At present the board serial number is hard-coded to 1, and passed
> >> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> >> the serial number to generate a unique MAC address for the on-chip
> >> ethernet controller. When multiple QEMU 'sifive_u' instances are
> >> created and connected to the same subnet, they all have the same
> >> MAC address hence it creates a unusable network.
> >>
> >> A new "serial" property is introduced to specify the board serial
> >> number. When not given, the default serial number 1 is used.
> >>
> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> ---
> >>
> >>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
> >>  include/hw/riscv/sifive_u.h |  1 +
> >>  2 files changed, 21 insertions(+), 1 deletion(-)
> >>
> >
> > ping?
>
> Sorry, it looks like I dropped this one.  I've put it in the queue for 5.0,
> with a
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Has this been applied somewhere?

Regards,
Bin

