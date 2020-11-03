Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA77C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F7320786
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcagc8MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F7320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZydQ-000590-Jy
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZycV-00044o-Ma
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:53:16 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c]:42840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kZycU-0008IA-2Y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:53:15 -0500
Received: by mail-il1-x12c.google.com with SMTP id g15so1796399ilc.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iFz6AsDSw1gcUlBXxfxLgIu9Ln5wNr38zIYH1L4kx68=;
 b=Qcagc8MD2q0+SJgTXGvC261nsIjfh3mqKXImPSldOPDIVOYe/BrkCO4RStaRruuzPx
 gnMqYGgDHGk1o05QuZEFhWnrLdqpRORh6Y/tinkaDXhzIF0tLYxK9pg7RnBJYHwOzKoL
 8+D+SU/xb75RTSe+nbwPSfT15KLxmAs6Hbrljvuv0HZO/7C9fdNDPPsBFP+LgJWQJD00
 UIVf1+lqIRB7nioI2BrP3VatVS6gWHaYWwBIh3tgwIibWKGw72sNQ60crIhXTJlnVMSR
 DXhck2kc3cC9CHaZtqj1EKbH/YybzEgHqeqOUTqefoYWnFXsAuhH8ZVXN6j4eOtJ8ek3
 8Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iFz6AsDSw1gcUlBXxfxLgIu9Ln5wNr38zIYH1L4kx68=;
 b=s6GE+2qUzIwA0MphIrYVyAXm2vxsKtaoVHicV3j2LHGR/DKrpvnKBhmLzRtKMzSnOo
 PmAY+FxFzNw8ojQUdiTL+eyNM/HPq3szxnfu8XcDDYGYwQqJjGnw6G2C0iw6tqQSbv72
 WIAs+6kSAHIBioQGgh1zEiK/Vl6uNEvfsz0du4Oapbh9TY/WvlyscGPOmrqsYvOnG2lw
 QCuasQ/brlWV/pEtpAJ3Wk84d7wSuSDWPlYqBzN9UeonkynGcS12kDK0QaEq/m5mUB5F
 gKWQRoom3yKUM6okHiz3cN/tsRiv0BTe2ZIpyb0ImQksA4t6WsOS4JuAWrXVzmE/yH00
 2f+w==
X-Gm-Message-State: AOAM5304y6NPPHIp1IrGec4Pv/x5hM7MPxmeMp1ozxJfSop8Hm+7gLKD
 P8PIXWgjKXoFbYV0+Qv+lT5Fm1urPMRPT3H0Rfc=
X-Google-Smtp-Source: ABdhPJxwwtuVB0rEnmzzIQfOfouQVRKK31YzbwGHfnamn3dlK331kef3PouQ5U2JG752USn9dbCsE2t4Z1QiG2j/Svo=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr15488414ilt.40.1604418792306; 
 Tue, 03 Nov 2020 07:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
 <20201023151619.3175155-13-alistair.francis@wdc.com>
 <CAFEAcA9MEG_g_YTFdnfjAp6U9zwqKmQWD8UnPYwbGj0c7WnOUg@mail.gmail.com>
In-Reply-To: <CAFEAcA9MEG_g_YTFdnfjAp6U9zwqKmQWD8UnPYwbGj0c7WnOUg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Nov 2020 07:41:15 -0800
Message-ID: <CAKmqyKP5b+3QN91BV8sZ8+diTGmJ5SMQJJLPi_jsENQCX_6O4g@mail.gmail.com>
Subject: Re: [PULL 12/12] hw/misc/sifive_u_otp: Add backend drive support
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Nov 2, 2020 at 9:49 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 23 Oct 2020 at 16:27, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > From: Green Wan <green.wan@sifive.com>
> >
> > Add '-drive' support to OTP device. Allow users to assign a raw file
> > as OTP image.
>
> Hi; Coverity reports some issues with this code (CID 1435959,
> CID 1435960, CID 1435961). They're all basically the same thing:
> in read, write and reset functions this code calls blk_pread()
> or blk_pwrite() but doesn't check the return value, so if the
> underlying file operation fails then the guest will be
> returned garbage data or have its write thrown away without
> either the guest or the user being warned about that.

Green Wan are you able to send a patch to check the error value?

Alistair

>
> > @@ -54,6 +57,16 @@ static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
> >          if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
> >              (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
> >              (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
> > +
> > +            /* read from backend */
> > +            if (s->blk) {
> > +                int32_t buf;
> > +
> > +                blk_pread(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD, &buf,
> > +                          SIFIVE_U_OTP_FUSE_WORD);
> > +                return buf;
> > +            }
> > +
> >              return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
> >          } else {
> >              return 0xff;
> > @@ -145,6 +158,12 @@ static void sifive_u_otp_write(void *opaque, hwaddr addr,
> >              /* write bit data */
> >              SET_FUSEARRAY_BIT(s->fuse, s->pa, s->paio, s->pdin);
> >
> > +            /* write to backend */
> > +            if (s->blk) {
> > +                blk_pwrite(s->blk, s->pa * SIFIVE_U_OTP_FUSE_WORD,
> > +                           &s->fuse[s->pa], SIFIVE_U_OTP_FUSE_WORD, 0);
> > +            }
> > +
> >              /* update written bit */
> >              SET_FUSEARRAY_BIT(s->fuse_wo, s->pa, s->paio, WRITTEN_BIT_ON);
> >          }
> > @@ -168,16 +187,48 @@ static const MemoryRegionOps sifive_u_otp_ops = {
>
> >  static void sifive_u_otp_reset(DeviceState *dev)
> > @@ -191,6 +242,20 @@ static void sifive_u_otp_reset(DeviceState *dev)
> >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
> >      s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
> >
> > +    if (s->blk) {
> > +        /* Put serial number to backend as well*/
> > +        uint32_t serial_data;
> > +        int index = SIFIVE_U_OTP_SERIAL_ADDR;
> > +
> > +        serial_data = s->serial;
> > +        blk_pwrite(s->blk, index * SIFIVE_U_OTP_FUSE_WORD,
> > +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> > +
> > +        serial_data = ~(s->serial);
> > +        blk_pwrite(s->blk, (index + 1) * SIFIVE_U_OTP_FUSE_WORD,
> > +                   &serial_data, SIFIVE_U_OTP_FUSE_WORD, 0);
> > +    }
> > +
> >      /* Initialize write-once map */
> >      memset(s->fuse_wo, 0x00, sizeof(s->fuse_wo));
> >  }
> > --
> > 2.28.0
>
> thanks
> -- PMM

