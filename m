Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D4AC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182D820644
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 12:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Klpda2Qn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182D820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPPu0-00088E-8o
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 08:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPPtE-0007io-L5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPPtC-00027t-Dj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:14:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPPtA-00026S-TO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 08:14:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id k21so1228557otl.5
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZDQiWoJHFKBowZ8xZNct+4GIEbUkPHO4o04+PZff9T4=;
 b=Klpda2Qn4GKU3LdljLbRlLvD+x7YgPG8ncc2CG4AsKjkBhJkc+IFfVUydLni/qtaZP
 Ax226hCGqY2Ac5ljX/l/2eQVX7IlwvO8/dgjVdsuKaR5+6S5rLRAmH8C6YeoGupW/tyG
 Z9360aO77q7uny6uunDb0HmDb5NQeSH6uNsyF7QPLLja+Ox+JM46HUDZM3F1qyBOQySu
 yX11p9unWeoEBFfsetKoSmFqCxEKblk+qg87PAXmfw8gPTu5UOucxZWOqhYRTyfo9tDD
 /PXO8M+vFEk3jGh2IdY2G1PMpdQSN7fQxzV3LGTD9nHwijHk1r5gnQow9TVx8vZBiNun
 cVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZDQiWoJHFKBowZ8xZNct+4GIEbUkPHO4o04+PZff9T4=;
 b=PqxGDkTGlKTvf9+iS+RcFdX1qkJLg2Ia7K/jSXs3/l3rP8ngRiS2+0FqBYp+PZUkhD
 fsKQ9iZgMB2/IC4giHky0w5PmxrWzVWsPrW1Dxduz8B/BLFUVIxufZg8F71s6cdzESkC
 NG7iLNYR192NHyFlMsoUS7/gh0mpBtHRv/TH+MS6QAOi9CYCF3J2/Sq7hdoWl27KRun3
 HMULhSEoZ8jo6HueEBJiKIdL4yoQ1IHT+WaUrHhH6GymVmDXlbbPvB64cu9Jg0uyr8aE
 NA0BBYYoB6Je3sE5FvtEOVlq7e7TwsPngeHdC0HiSXEVXlhORjBwQ74SNRplWcVtnz0W
 kDkA==
X-Gm-Message-State: AGi0PubJjgfcIGW5d0+gey/PM0KTGb6m/gQgP+B3Y2wLbcA17FTHHYfD
 EbZAF0TmSU4DUg+bFWLK/DXQVwJTiZYKYbklw2K3AQ==
X-Google-Smtp-Source: APiQypLUOtql0RYmrOMwTCk7fhboLin5IwF5xJu6uKF8QgEndwNARFKINc0FDwHA5yMCUSG+R+HcHWZFfwKAW5iUMZU=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr2156437otc.221.1587125671680; 
 Fri, 17 Apr 2020 05:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200410153916.17718-1-jerome@forissier.org>
 <CAFEAcA-JpeYgDwKRarWwggrU5XX7eWsdVy1ngLn538rC6J75vg@mail.gmail.com>
 <37b74bfc-bf61-450a-21d1-43fbdeaa400a@ispras.ru>
In-Reply-To: <37b74bfc-bf61-450a-21d1-43fbdeaa400a@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 13:14:20 +0100
Message-ID: <CAFEAcA-0ZkfDZdYeFcKa63e2Dn_x-k99hp=_pqG6hQvNQ=ijaw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add DT property /secure-chosen/kaslr-seed
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Jerome Forissier <jerome@forissier.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 13:01, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>
>
> On 17.04.2020 13:18, Peter Maydell wrote:
> > On Fri, 10 Apr 2020 at 18:02, Jerome Forissier <jerome@forissier.org> wrote:
> >> This commit generates a random seed to be used by the secure OS for
> >> ASLR when the machine is secure. The seed is a 64-bit random value
> >> exported via the DT in /secure-chosen/kaslr-seed. This interface is
> >> used by OP-TEE [1].
> >>
> >> [1] https://github.com/OP-TEE/optee_os/commit/ef262691fe0e
> > The kernel devicetree documentation documents this as a generic
> > property of /chosen -- should we be providing a /chosen/kaslr-seed
> > too ?
> >
> >> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> >> ---
> >> +static void create_secure_kaslr_seed(VirtMachineState *vms)
> >> +{
> >> +    Error *err = NULL;
> >> +    uint64_t seed;
> >> +
> >> +    if (qcrypto_random_bytes(&seed, sizeof(seed), &err)) {
> >> +        error_free(err);
> >> +        return;
> >> +    }
> > Since this is exposed to the guest I'm wondering if we should
> > use qemu_guest_getrandom() (which lets you make the randomness
> > deterministic for the benefit of record-and-replay). But I'm
> > not sure if that function is usable before the guest has even
> > started running. Pavel, could you answer that?
>
> Yes, usage of deterministic functions is possible before machine is running,
>
> because replay_configure is executed before machine initialization.

Great, thanks. Sonuds like we should use qemu_guest_getrandom() then.

-- PMM

