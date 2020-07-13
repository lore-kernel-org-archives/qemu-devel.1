Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D0C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC872076D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KVsRwm19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC872076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv185-0003a2-Gs
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv17P-00032m-1i
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:15:51 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jv17N-00025l-Aq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 12:15:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id g37so9928713otb.9
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=orzPIWVnwHo2G6bvPdgUpXbljgj2/uj4fcJ5AHejZmE=;
 b=KVsRwm197wKiC4TuP3EuldNzv4nyRYmF+iYL3uIc15hcVMYyKg74UU4R42PfxTuJIb
 WZ9KE4VFyVyN9ou/cHSbJLhBM1stFjOBsJZCrqDSR9qd8aBBkv2fEunGzyCe7cbKqjZ+
 8ksPcv9d/NB2XOv0vGbUCXNCWt1XmOkNkjH4/wpwkme20bhCoPLN3W8qPR3J4VXwWTtw
 joj2z3Manvq2XOndisG0AC9yfLIm3pLII5ca4aYNVHEJ/lhXmUVEZVRhT324sqEx7XJ1
 UJUG96mE2m1GJJdYj93XlGEswRCSxrR8jfZdq3XOYi2vpWE/wqaH5H0bADNqujtqTfDH
 trTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=orzPIWVnwHo2G6bvPdgUpXbljgj2/uj4fcJ5AHejZmE=;
 b=OlxfvS4FBFo37DtdQpb5IAMNL8oi77LxaWjosfzmiov3x4n7D4sOvvDbsfESUgOBbL
 oahqyj1sOVkKpjuPv8RFxumAjYJCd+tfm0VRoiuy6eetuFUmy87NcrMSMNuhJDB7/sFh
 xuzuZA39G08wk1AkHximU4VZwMpfelBmhWKll8rbqNyYesxnXMTezlD+kGJRF0aVji8O
 /A4lPuqLRxGIUt+2YHXlivpO57KxLff7yZ18porQPD1ydE/If/dQIuZT2MFK1PU5f/OE
 IVrceXKi8xbZ+288tscZapjJL1TwYFeU/LGYUzNiNQkwRjkc87CawDH1v/XkFTcCAoU4
 28Og==
X-Gm-Message-State: AOAM530MqQRHua5Pv0KzxkR09KkQ760kWwWUwUG6/V+iSYkIvZQZ9eS4
 diRNGDr9bYuDp8D6m+trww/jMKwuW659C57BfaJA+A==
X-Google-Smtp-Source: ABdhPJyish8FYRhh+aJVJq2cYZj0S6VVHVgHPB70TyTYkt199MmQdZPZqv7RqxBmjWpAxykXkaF/6gfUkRTm7/jeVjM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr294919ota.91.1594656947378; 
 Mon, 13 Jul 2020 09:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200710085417.638904-1-mcascell@redhat.com>
 <CAFEAcA-pRXOz5JVcwHa8=oaeogwaOK0YVXYQiJUpdM_rFZ+QTA@mail.gmail.com>
 <d7affe2b-0a2c-4e06-a874-daccf16bd136@kaod.org>
In-Reply-To: <d7affe2b-0a2c-4e06-a874-daccf16bd136@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 17:15:36 +0100
Message-ID: <CAFEAcA9=_RC0w-EgjdPw=UWXZ-ufHjkeDWTMj_jXfSQL8G9GHA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/ftgmac100: Fix integer overflow in
 ftgmac100_do_tx()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ziming zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 15:19, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 7/10/20 1:33 PM, Peter Maydell wrote:
> > Andrew, Cedric: do you have the datasheet for this device? Do you
> > know if we should also be flagging the error back to the
> > guest somehow?
>
> zero is the only invalid size of a transmit buffer and the specs does
> not have any special information on which bit to raise in that case.

I found a datasheet which might or might not be the equivalent
bit of hardware -- does your datasheet have a note on the
TXBUF_SIZE field of a tx descriptor that says "When the size is 0,
the descriptor would be discarded" ? (Though I found another
random doc that just says it's illegal...)

> I think FTGMAC100_INT_NO_NPTXBUF (transmit buffer unavailable) is our
> best option and we should add an extra 'len =3D=3D 0' test in front of
> the dma_memory_read() call to raise it. A zero length is not considered
> bogus by dma_memory_read() it seems.

My best guess at "what the hardware does" here would be:
 * TXBUF_SIZE in a tx descriptor can be anything: the h/w
   would happily allow you to assemble a tx packet with a
   whole series of 1-byte sized buffers, each with its own
   tx descriptor
 * zero-byte tx descriptors might just be marked "done" and
   skipped over since they have no actual data
 * any checking on max/min lengths would be done
   only on the accumulated total-packet length (we do this
   this way already for the frame-too-big check)
 * I suspect "transmit buffer unavailable" means "the ethernet
   controller needs more data but the next tx descriptor
   is still marked as owned by the guest" -- this is certainly
   what we currently do with it, and that doesn't seem like
   the best thing to signal for the "tx packet too small"
   case. It's possible that the hardware simply sends out a
   runt packet of some form if the software tells it to do
   that. My vote would be for handling it with XPKT_LOST,
   the same way we do for over-large frames. This probably
   is not what the hardware does but at least it's a
   coherent thing that the guest might be expecting to have
   happen for a tx attempt and it matches the fact that we
   really are not going to put it on the 'wire'.

Side note: I suspect that any failures from
dma_memory_read() and dma_memory_write() should be
reported as AHB_ERR (currently we have a mix of
ignoring them or using NO_NPTXBUF).

(It would in theory be possible to test some of these edge
cases on real hardware, but that kind of bare-metal test
case is usually a pain to put together and way overkill
for this situation, so I don't think we should bother.)

> Is address zero considered bogus ?
> If not, we need to check that also.

Writes to address 0 are fine, it is not a special physical address.

thanks
-- PMM

