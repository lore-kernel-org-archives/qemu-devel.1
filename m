Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B15C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97CF2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6Ty4UHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97CF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG0NE-00065l-2R
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kG0MF-0004zc-AP; Wed, 09 Sep 2020 09:41:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kG0MD-0006xl-RL; Wed, 09 Sep 2020 09:41:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id s65so1036514pgb.0;
 Wed, 09 Sep 2020 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lx/eN7qylYuFGXPo73EXtXAuZaS1Ib1cGdeygKan3Ag=;
 b=t6Ty4UHvh2NmVhIK42UHnZpIQE1zKWPSIjpIM2kcLLmcXPLLhEqZifrQzF0Qt2lPrx
 HQ64le5RqHmfve1gNAdiEGzmgPD+2RSShXPfb/tO+MAzghrPnNrmK38/WSKbq8iLtfVL
 MZwkpVn/96qr0400yqZke2fGeko9oME9j1kLeHf2ufPeSFrPxJRNSZNgYiXFWz/2dqxG
 Xd6X55g7T6nHOnNOVeDdv14q/1ZbLK12m+gfIwQ+QukkTByuif5RJSN/Qt4GAvTi36/I
 tuesziKJ9BuWjKBaNKcvVNa5nrkOy1ONx3/4i28kViJ3GnQFo4qys32NnR2m5bAjWg+J
 iYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lx/eN7qylYuFGXPo73EXtXAuZaS1Ib1cGdeygKan3Ag=;
 b=s8/wy3/3fEWpoT17c56YZqfhtVRUxPX78JU837Hxn3LXZGS/R+1JBiPs1wzxq+L/h5
 2FmsUrh9mMAqe7gXxxMUUn8DpGA36n8pPSG78xD2lufktLmYhnKOvRHbuh4C5yRpcWsf
 xYLcu2WrYgu6g4nL9si7oLcJAaVbcfBMzKPwmKUKcoLisrzdBwxLVswdYZ3j9JgYaf9i
 F3W1meheUPojN2o613eAtN3je1LRpytuSxezi3oIkWGZl9joGTgcQ10iUGw9Z3ZWxfH3
 VIy7r1qavK6W8zSYzBKxJzDGjYwogeunwwmUpC3RMAAROpF3iF1OumczhleYDN0P1+3t
 FgKw==
X-Gm-Message-State: AOAM530fh5RBg9PKolzHtEcTiNjE+8VelVed3RyknwDxr708FJLlz/it
 Tt8MG/SJk2grm790gDv7pnYAGZfaPIpFOW8MOko=
X-Google-Smtp-Source: ABdhPJzfzDMvKU8RvpZbS6cAOJKZEJ8vIGk5GmOaYMGLPKWl3q96alvEMPeSXhRMeF66z9kCmCCFeYtr/3/ewcJOVzw=
X-Received: by 2002:a63:a55e:: with SMTP id r30mr702838pgu.61.1599658911432;
 Wed, 09 Sep 2020 06:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200903110831.353476-1-philmd@redhat.com>
 <20200908143725.GD7154@stefanha-x1.localdomain>
 <CAFEAcA-Ptc6_jQCna8+BMM1DOY-A+-b4toJiAm8z-9nzwJiDcg@mail.gmail.com>
In-Reply-To: <CAFEAcA-Ptc6_jQCna8+BMM1DOY-A+-b4toJiAm8z-9nzwJiDcg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Sep 2020 14:41:39 +0100
Message-ID: <CAJSP0QUBR+6=rnQz-MJ3mPJ4TSqEme5SHHUP3dhnW4_y1dEf_w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x541.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Qemu-block <qemu-block@nongnu.org>, Li Qiang <liq3ea@163.com>,
 "Emilio G . Cota" <cota@braap.org>, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 9, 2020 at 2:23 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
> On Wed, 9 Sep 2020 at 10:12, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Thu, Sep 03, 2020 at 01:08:19PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > The main patch is:
> > > "exec/memattrs: Introduce MemTxAttrs::direct_access field".
> > > This way we can restrict accesses to ROM/RAM by setting the
> > > 'direct_access' field. Illegal accesses return MEMTX_BUS_ERROR.
> >
> > QEMU needs to simulate the behavior of real hardware. What is the
> > behavior of real hardware?
>
> It varies, depending on the hardware. The most common thing
> is probably "happens to work by luck", which is OK for hardware
> but doesn't help us much since our software implementation is
> naturally more serialized than hardware is and since we don't
> want to allow guests to make QEMU crash or misbehave.

The memory API bounce buffer mechanism is evidence that some board(s)
need or needed it. At a minimum we need to find out the reason for the
bounce buffer mechanism to avoid breaking guests.

Stefan

