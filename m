Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7066C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348CF206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiCbOfyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348CF206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEd7-0005Pe-W7
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kSEbS-0004Za-Vv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:20:11 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kSEbQ-0003I1-EW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:20:10 -0400
Received: by mail-il1-x144.google.com with SMTP id r10so14511657ilm.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cqPb2/sYwmiJmAxv4zSQ1d/SafPv9FYTUtxqEhB2kYA=;
 b=AiCbOfyfipZbuqlVNe03qKwGaOD1N6RFxxh49s0aeEfUTCRNhluLVzbe8z2vsMzymi
 JH8Ee8piXXBfxPNRZrjuAbEzDl9MMnGoyhFyyZjYcAgGlMss1njODo7Dl5s+xwanxz97
 VzZsCmzyInLl/wRmIzQdf9FqIsapZ1a/z+oDWOj3rChMJzVj3V7gEUhQrpKe1j3KP0mH
 kCk+V+JSF/z83swAM76LpTPEGq8G8ApsP88tIaYpxThwBPEVqYLOMRc0UUgwZ/Jso3Ue
 2gmuBxtLpJMuanWdJ06+Gyc+hWxUOlCXi4mzdIraoHZbNUGgwO/+v42XDqEasre1yYfM
 KTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cqPb2/sYwmiJmAxv4zSQ1d/SafPv9FYTUtxqEhB2kYA=;
 b=gnvLpH7CBY46L4DqCNNKCD9VVXYccN0H7bW8KKnPpVU1KVwssIotySXeCpw02ZvbOV
 sNUv+pDNSjTPDyFL7zFfh2X1bFIgDbChtGAcYrKq6baxgOCQDmiyiad4vRf/hVsXpwfQ
 lnDo8eVkGhDdSJFd/POC/lnlBxg0d0J5/7f6kKi2Pkqr/aV1xb8VgTX9f9Ao5axXc96U
 +pTe7izkzzbcpJcrQonPlMw/LVV0Hy2Zz0u/4QcjvfuhGG2h9qwV8eFcqwrD4V+UCveF
 viPhQXdrbWUykTrMbveCUcx2/5OmQkFrUp2VTsiMG1nsLjAkXfckKSJBd3p1MVVeEeU9
 oRPg==
X-Gm-Message-State: AOAM531fjeDdw9lyeDoN3o4foZYxw9ZaEUUzTe8fIZ6z7NbH7t2QndNK
 dl1xCYBxVSeaj2UiP6BiwOE+4jKbvbJc9QvHZwo=
X-Google-Smtp-Source: ABdhPJwvGX9ognDnO1jPxAmY9HH7Kx0gNGm8IC4Z20htWawCNilp6Jwq6gZ3y/ffN0B02W3wJ8zd4AVclz3rocZL7K8=
X-Received: by 2002:a92:6b0d:: with SMTP id g13mr2181441ilc.242.1602573607232; 
 Tue, 13 Oct 2020 00:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201012150356.79670-1-mcascell@redhat.com>
 <CADBGO7-w7txnd6MHAY0ge3k3LRcn0FfGDU9znQU7qxQddJQT0A@mail.gmail.com>
 <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
In-Reply-To: <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 13 Oct 2020 00:19:40 -0700
Message-ID: <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x144.google.com
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
Cc: gaoning.pgn@antgroup.com, Mauro Matteo Cascella <mcascell@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, linyi.lxw@antfin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On Tue, Oct 13, 2020 at 12:04 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > +        if (mps == 0) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR,
> > > +                    "%s: Bad HCCHAR_MPS set to zero\n", __func__);
> > > +            return;
> > > +        }
>
> > I think it would be better to move this check earlier in the function,
> > just after 'mps' is read from the register. Otherwise it can get
> > assigned to 'tlen' and 'p->mps', and who knows what mischief an
> > invalid value there might cause.
>
> Makes sense.  While being at it maybe handle len > DWC2_MAX_XFER_SIZE
> the same way, the assert looks like it can be triggered by the guest.

I sent you a patch to fix up several assert()s, including that one, about a
month ago. Did you miss it?
https://lore.kernel.org/qemu-devel/20200920021449.830-1-pauldzim@gmail.com

> Also: What would be the effect of simply returning here? Would dwc2
> emulation simply stop processing queues? Should we maybe raise an
> error IRQ?

Not entirely sure, I imagine the emulation will just stop working. I can
test it tomorrow. Also, can you give me a hint what an error IRQ is?
Is that a Qemu thing, or do you mean we should emulate what the
real core does in this case?

> What will real dwc2 hardware do in this case?

No idea. I don't think it's mentioned in the manual.

-Paul

> take care,
>   Gerd
>

