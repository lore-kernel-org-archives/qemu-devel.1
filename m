Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB5DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A755D2074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bv0H3MGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A755D2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaE1R-0001GO-Jl
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kaE0s-0000rM-86
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:19:26 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:36932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kaE0q-0002o1-2i
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:19:25 -0500
Received: by mail-qk1-x72e.google.com with SMTP id z6so18361050qkz.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a2xn/972ZQE+RGCuFDWPwVqrFRwi4Z8R96uvetrtIzg=;
 b=bv0H3MGAhlWRvXO57cfylNEzXAuNYNAiGpkOMiScMUsuYGOSyJnJtBneMvR7+hgQC/
 lY0ZtBgLha3V74aUjNQBK0lWjaeaCzpjtWpLt3Gd7uB521SsVx3QRZ+iUJuXUUwdRlUD
 KqW0d9z/1gCoPe3otMsRm9gYtXRzKk8WOXr2JT6cuW18z2ASxcY8bNbe6/xCsj/YFtDO
 zew26dFyM+bKos4m93FGn7/+EMVRgbDyBHOIsWHBfM4Qloc+dDW29BsjLY82xiL6x8B/
 x801kW6xC2LDjoFeC6YUZxLKXBOQNJJ95Wh56siJSDjgeBHIbjJIfi95v7a/MmgiqlTp
 MZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a2xn/972ZQE+RGCuFDWPwVqrFRwi4Z8R96uvetrtIzg=;
 b=pTc2tlO2vaG8AVApDdIU1xfdDHrUA77Y7pSEdWJJ4+nVRJzuqCXM7MjtQBPhR5QPKM
 4X71lppUEMxGfPVknwpXCn2xIke6t7cVTiDnXOrWCF5kGxzFG2ivvdZxeYQdF36voOPH
 Q0vUFs5eqrwzhoNUTp1THWCzx6uxHgFcQQCveVrq37oyR8mceJuE2yrepizCfoyQGfXJ
 YbbYhWeAJ8gZyewJs4dYfKzgzR5zE6OU/GKzTUq4OqNhSuAA56SDNvtYbqEiYHA7Sd+h
 Nvbys+PJqIGY0WJe5XrCbHHIO6llwCR07yXXtisxzmLO6M2F6J6rNifuDNq0zOEzjK25
 UugA==
X-Gm-Message-State: AOAM530Kkql354j5cViPHpVinCb/WIuyczUfw4rq3cSzSTAjM3o8sBJ5
 svWWTdMRA6o7KTFXFcWqlSTuVVzTX1kN8XT1Gul/fQ==
X-Google-Smtp-Source: ABdhPJxY8TiAG0I/G8VJr+ywli80lXDQU7j1fmXaJ8LFvmfgyyH7KW2cC/Lt/u18Nl87S88dEE1b8ZJgofdypLtAV6M=
X-Received: by 2002:a37:88c:: with SMTP id 134mr23650062qki.17.1604477962467; 
 Wed, 04 Nov 2020 00:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
 <20201023151619.3175155-13-alistair.francis@wdc.com>
 <CAFEAcA9MEG_g_YTFdnfjAp6U9zwqKmQWD8UnPYwbGj0c7WnOUg@mail.gmail.com>
 <CAKmqyKP5b+3QN91BV8sZ8+diTGmJ5SMQJJLPi_jsENQCX_6O4g@mail.gmail.com>
In-Reply-To: <CAKmqyKP5b+3QN91BV8sZ8+diTGmJ5SMQJJLPi_jsENQCX_6O4g@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Wed, 4 Nov 2020 16:19:10 +0800
Message-ID: <CAJivOr6LXhVc7q8toBZEGB2U2Y99o6W+nwJ0hLANO5krF0gijQ@mail.gmail.com>
Subject: Re: [PULL 12/12] hw/misc/sifive_u_otp: Add backend drive support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=green.wan@sifive.com; helo=mail-qk1-x72e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OK, let me do it. I'll send it soon.

On Tue, Nov 3, 2020 at 11:53 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Nov 2, 2020 at 9:49 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 23 Oct 2020 at 16:27, Alistair Francis <alistair.francis@wdc.com> wrote:
> > >
> > > From: Green Wan <green.wan@sifive.com>
> > >
> > > Add '-drive' support to OTP device. Allow users to assign a raw file
> > > as OTP image.
> >
> > Hi; Coverity reports some issues with this code (CID 1435959,
> > CID 1435960, CID 1435961). They're all basically the same thing:
> > in read, write and reset functions this code calls blk_pread()
> > or blk_pwrite() but doesn't check the return value, so if the
> > underlying file operation fails then the guest will be
> > returned garbage data or have its write thrown away without
> > either the guest or the user being warned about that.
>
> Green Wan are you able to send a patch to check the error value?
>
> Alistair
>
> >
> > > @@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
> > >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> > >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> > >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> > > +
> > > +            /* read from backend */
> > > +            if (s->blk) {
> > > +                int32_t buf;
> > > +
> > > +                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
> > > +                          SIFIVE_U_OTP_FUSE_WORD);
> > > +                return buf;
> > > +            }
> > > +
> > >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> > >          } else {
> > >              return 0xff;
> > > @@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
> > >              /* write bit data */
> > >              SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
> > >
> > > +            /* write to backend */
> > > +            if (s->blk) {
> > > +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
> > > +                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
> > > +            }
> > > +
> > >              /* update written bit */
> > >              SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
> > >          }
> > > @@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
> >
> > >  static void sifive_u_otp_reset(DeviceState *dev)
> > > @@ -191,6 +242,20 @@ static void sifive_u_otp_reset(DeviceState *dev)
> > >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
> > >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> > >
> > > +    if (s->blk) {
> > > +        /* Put serial number to backend as well*/
> > > +        uint32_t serial_data;
> > > +        int index = SIFIVE_U_OTP_SERIAL_ADDR;
> > > +
> > > +        serial_data = s->serial;
> > > +        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
> > > +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> > > +
> > > +        serial_data = ~(s->serial);
> > > +        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
> > > +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> > > +    }
> > > +
> > >      /* Initialize write-once map */
> > >      memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
> > >  }
> > > --
> > > 2.28.0
> >
> > thanks
> > -- PMM

