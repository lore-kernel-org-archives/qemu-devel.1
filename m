Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C741C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B9E2073F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyHzISY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B9E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf6Go-0002oP-4l
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hf60x-0006yW-CW
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hf60w-000234-3n
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:10:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hf60v-0001yB-Sq
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:10:50 -0400
Received: by mail-oi1-x241.google.com with SMTP id a128so8105537oib.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=liRvRgCuJlFeUvsNW1D4r9Cbj+BN/T15I0/5xAVeaUw=;
 b=XyHzISY8/Q9tOlPfpDbwLwtUOvEW3Dp8vTBDqiOhOJxmT81JgYBGysBIStM5beI7wN
 7CJ25gt1e1yBgBoGUL2Nn+s7ioN5hUZMqPopODB44YlNulPLPN9lJXhccAtthSIcDtiu
 y9Wo/C/nigsjnp3f3DcMPxVwkFjm/6WSlI1yM81oQbHqRRFnaopUrljHrWLALcSRKqiA
 zrg6yMdmQDm2cDDXZQphoptoZCyFvBhdstpsZ/EmmHmH3BGrsWgTgaJ5LE7oBoBv+GS+
 NM7Z5Tdxh3jFRlOH3mbPTgcNsKvoOe+bLsvq8raOatNubaiHWULtI/a5gaiNO6KGUajs
 BPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=liRvRgCuJlFeUvsNW1D4r9Cbj+BN/T15I0/5xAVeaUw=;
 b=bSV9JoCo2fteslIJEF0HEjn67TJkO0WCR63T5UvUzWO7S4vs17UcBtmuLbtSodGGba
 JP2cl24eAbWaQICkx06Yj/g5bUeNNIm1PSoBq4KIKDPo14RYy5tVCW9WD7U3xSrXKf0R
 UwaqttIL4dASRKF0fRnuHMa2vLnt+wp2+wvBlWX3vWmLGadjuYc3yMpWkRGnCOY/Q+i5
 dXr6xu0Tka0Xl8dBcDiWPLwzue5g2L4PKLUm1mWgY21L7VRBBl1vRUimqM0jKgVrGUIL
 O6rscs1j+5+EfOORWnDyBh83L97mbzwraG08TbjjKQpU134RbuDZNS2+yoSnS0a3WjvS
 0S8Q==
X-Gm-Message-State: APjAAAVvqcALivqk2t9SHboNroJLzqbKTDYL4fxo9bQ0jpntdANNyOCO
 51GffQdCd0CpeW7O7jp832cFRBXb1urQMIQauWg=
X-Google-Smtp-Source: APXvYqxKr3FESmFx1GHDC4ghMFvNajQO1/j8OlU68lVMZgaAvpnK8H4MeFI7BGtN3E57IinCzDoYfdzrlcBm64D18ho=
X-Received: by 2002:aca:b254:: with SMTP id b81mr3804808oif.53.1561309846899; 
 Sun, 23 Jun 2019 10:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
In-Reply-To: <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 23 Jun 2019 19:10:36 +0200
Message-ID: <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 22, 2019 at 5:02 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 22/06/2019 15:20, Mark Cave-Ayland wrote:
>
> > I've just given your tcg-ppc-vsx branch a spin here, and like Howard I'm getting
> > segfaults trying to launch my MacOS images :(  The segfault is weird: it doesn't get
> > caught by an attached gdb and the qemu-system-ppc process seems to hang around like a
> > zombie which makes me think that it's probably an illegal instruction of some kind,
> > but the PPC kernel can't handle it as well as x86 does.
> >
> > With a bit more work I bisected it down to the first commit in the patchset
> > (d8dcbb57e9: "tcg/ppc: Initial backend support for Altivec") and then as an
> > experiment I hacked tcg_can_emit_vec_op() to always return 0 to see if that made a
> > difference, but the segfault still appears.
> >
> > The commit message mentions that the load and store helpers are also improved, so I
> > wonder if they are what is causing the error rather than the vector parts? Also in
> > the kernel log I see the following messages appearing:
> >
> > [3639669.374942] qemu-system-ppc[28591]: segfault (11) at 64b8 nip f87280 lr f8723c
> > code 1 in qemu-system-ppc[94e000+aa0000]
> > [3639669.380015] qemu-system-ppc[28591]: code: 93c10038 91810020 90010044 7fc802a6
> > 3fde0059 2e030000 3bde6c18 7c9d2378
> > [3639669.385056] qemu-system-ppc[28591]: code: 813e80a0 7cbb2b78 7cda3378 7cf93b78
> > <81428ff8> 9141001c 39400000 81290000
> >
> > Does that help at all? If not let me know if there are any other tests that you'd
> > like me to try to help debug this.
>
> One more hint: if I try a build of d8dcbb57e9 along with my tcg_can_emit_vec_op()
> hack and pass --enable-debug-tcg to configure then I get an assert on startup:
>
> qemu-system-ppc: /home/mca/src/qemu/tcg/tcg.c:2207: process_op_defs: Assertion `tdefs
> != ((void *)0)' failed.
> Aborted
>

Mark, Richard, Howard, David,

I just sent v5 of the series, that is (in the sense of net-result of
code changes) equivalent to v4, but the patch 1/7 from v4 is now split
into ten smaller patches. This was done mainly to enable Mark to
perhaps try v5 and bisect, in order to at least somewhat narrow down
the culprit. Most likely it will be patch 5 from v5, that is still
sizeable, but even if this is the case, we can eliminate other smaller
things from consideration.

Sincerely,
Aleksandar

>
> ATB,
>
> Mark.
>

