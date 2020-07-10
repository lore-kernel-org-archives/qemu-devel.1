Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40097C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 00:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA4B2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 00:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbVl6xu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA4B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jthGO-0006I4-7z
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 20:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jthFV-0005nm-3C; Thu, 09 Jul 2020 20:50:45 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:36792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jthFT-00085d-IC; Thu, 09 Jul 2020 20:50:44 -0400
Received: by mail-yb1-xb44.google.com with SMTP id v9so1885363ybe.3;
 Thu, 09 Jul 2020 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2/o8F9RzXL68lK7h+hl720v6y/i9E7C9vqS2nQxXpHE=;
 b=IbVl6xu5j0swSnUY0wLQAow/KwgabUxRnSspR7v7O8yvZgs5VSyXqQUs6vCYauthSq
 4X/Xq0X0zgUelmHYFJAxJwLqXnXwHduaJC9EeMy90TxIAaB7dqXWxw31hqcpAslClq3p
 xw33wzDpxigmhWODUKyMO2Fu7AV3NnqnSziUMW8fary4S7GvTrIHSLRmOhz55O+mw7wA
 5vLf3DJMcbqwZ/G6rrYO3CRaDGwfqXmjZluNS028dkx3X2Ip4ZWzOype6PbBznfBrMQq
 opt5+zyiWpgnYrVSyhUNGiZmeCyqA7fbNL8rLTWM/K0LKZiJkbYV8qGP5IXhPNtFkg39
 RPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/o8F9RzXL68lK7h+hl720v6y/i9E7C9vqS2nQxXpHE=;
 b=aJGMIgNn1zPiBHhNl8iBAvNKw3X2ss2W6nZ8maEVmOixAF5vpSbpzC/g05FCO3G/NP
 tb+F30pGwb7IrZp9XyXUICVxTyi9EyKQkPQLNu6Qwj1UXLU2hj+OS+yXEFB+NG99YLVz
 wPnaa0BsmUonR+LHs+5/pCoqVC369Jrcjd/1h8oDrlV3JokNgNbfOhyw4cOJHRFn/ST/
 icN9NgGH5+NRRmE+VCEOGz8isY4h2nMYTi5XhQdtE32r6WHb7CpMcXbk6wr/3CR/L2Ey
 RjzgQ9UYfHqTdtTQ/o9EEzxJQg54qrVq98oBBRnIxd33jVfC8d3R8+ixSwGN0ZaTchpZ
 pcVw==
X-Gm-Message-State: AOAM531vYdivn8pwrEpDH/75FlB044x3rEwXGof+Z3f5PJLam5lknymi
 wCKtppnzRm4EnvOGW/cVzdcmzLImcEAMYcEhrVI=
X-Google-Smtp-Source: ABdhPJxLc/5QyJ5f3O/bYoftghXaMKe+RUPZX4FJy8abjBTwByuion1lrvSamv8cTCg00rU7ua2PQc72Lxh37SOMKXM=
X-Received: by 2002:a25:c342:: with SMTP id
 t63mr107127362ybf.122.1594342241582; 
 Thu, 09 Jul 2020 17:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
 <mhng-842d31db-ac34-4bab-a523-808f1f542101@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-842d31db-ac34-4bab-a523-808f1f542101@palmerdabbelt-glaptop1>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 10 Jul 2020 08:50:30 +0800
Message-ID: <CAEUhbmUPxCmo-4SPm8JwG7emD0YfLeAMSgd7mWaCH2VDZJTtsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Palmer Dabbelt <palmerdabbelt@google.com>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Fri, Jul 10, 2020 at 8:45 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Thu, 09 Jul 2020 15:09:18 PDT (-0700), alistair23@gmail.com wrote:
> > On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>
> >> From: Bin Meng <bin.meng@windriver.com>
> >>
> >> The reset vector codes are subject to change, e.g.: with recent
> >> fw_dynamic type image support, it breaks oreboot again.
> >
> > This is a recurring problem, I have another patch for Oreboot to fix
> > the latest breakage.
> >
> >>
> >> Add a subregion in the MROM, with the size of machine RAM stored,
> >> so that we can provide a reliable way for bootloader to detect
> >> whether it is running in QEMU.
> >
> > I don't really like this though. I would prefer that we don't
> > encourage guest software to behave differently on QEMU. I don't think
> > other upstream boards do this.
>
> I agree.  If you want an explicitly virtual board, use the virt board.  Users
> of sifive_u are presumably trying to do their best to test against what the
> hardware does without actually using the hardware.  Otherwise there should be
> no reason to use the sifive_u board, as it's just sticking a layer of
> complexity in the middle of everything.

Understood. Then let's drop this patch.

>
> > Besides Oreboot setting up the clocks are there any other users of this?
>
> IIRC we have a scheme for handling the clock setup in QEMU where we accept
> pretty much any control write and then just return reads that say the PLLs have
> locked.  I'd be in favor of improving the scheme to improve compatibility with
> the actual hardware, but adding some way for programs to skip the clocks
> because they know they're in QEMU seems like the wrong way to go.
>

Yep, that's my question to Oreboot too.

U-Boot SPL can boot with QEMU and no problem was seen with clock
settings in PRCI model in QEMU.

Regards,
Bin

