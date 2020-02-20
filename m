Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB91C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191CC207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxQyZ+6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191CC207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4p1q-0004Eo-7g
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4p0y-0003Cg-3N
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4p0w-0001mf-Tc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:49:28 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4p0w-0001mN-Nk
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:49:26 -0500
Received: by mail-oi1-x241.google.com with SMTP id a142so28181707oii.7
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UBJTtmaVHjCje4IQAZRXqmLtw7W5gnalWAcuadbspgE=;
 b=nxQyZ+6o/qPkh+vuDtD8NaRxXc/gbxMiU6R6pL1HT7AfKLTlxtChbfgkepof5tv9rI
 UmqPu/ZjTphruIQ2tDvuU3uiGh4Hv6H+kFCMvsgu67kcHem5NLHQIwXZR3/piaYCqy2H
 FpitLqpopfCDhn5uTJXYNEMQiMBiSz3ZnIWaSu14d9uE74+r/K/prwYNmX3cjeih6ov9
 ttnrP1O3yl6Va9mIoVHKnV3HMoeLe0HbcqDAsflZeFEM7S4YkPobiDTiZDG00yGJ6jJJ
 H0HFvDkUE9oQw03lpPoZ+DQpwNQchNE3YWP1uf1lmFJlDvRF/bDuO9bXAttIVqlaNTpf
 yIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UBJTtmaVHjCje4IQAZRXqmLtw7W5gnalWAcuadbspgE=;
 b=Izu+suVGMOx01x/jIYubR2Ud6O0GqJrek5UG4PJrRYLVDfXIVl2YRGxdpZvjkAgEkI
 Ko3bOzYsa1HgviHNE+WX2wG/u0NmmqWSoh1c6+bZNtxegQ5c9UzbVzCtfhu2oIA5kHRW
 7Nhci/+2oyVgrYSD8F+Bu7zN3gxSZ8fvFcQcSunOthk2spnqZeX6nViR0vhpCRc8bJTY
 MxH/WU4YH7luBaiRRW85hYWZXJU0DTXHvC5sCzs8I7oqdqrPLpRlANInOhpOSZZ/+oLU
 BDDFVy50i9KNQ9AlYirl1hG70ZvNqZ7rb86PPXSw2mlwQFJx+jk4eq9V0vuAX69XkafG
 ptkw==
X-Gm-Message-State: APjAAAVeLVveC70L1+vUpsOHbh1Unf1ig6VZbi+cPPiJ58/HsQ3SWGxa
 a0dwFpkhccz9tCc+FD4sMVYpBW/VhFVIMV40erJ3kA==
X-Google-Smtp-Source: APXvYqx/c28778GDAQIPLSvqbq4eaqm/pjNlenHHAgyfU/AhirM7dHAWbHOFDu6iEc3ASPGsAocA0rEeJfTJkeUhBv8=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2664948oie.146.1582217365873; 
 Thu, 20 Feb 2020 08:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20200217032127.46508-1-pannengyuan@huawei.com>
 <20200217032127.46508-2-pannengyuan@huawei.com>
 <20200220165950.3a5ec74a.cohuck@redhat.com>
In-Reply-To: <20200220165950.3a5ec74a.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 16:49:14 +0000
Message-ID: <CAFEAcA8ZcCEWn0xKiRQ8n3_sQQ2r12fwi_5Qrj0POUfW_70V+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] s390x: fix memleaks in cpu_finalize
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pan Nengyuan <pannengyuan@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 mav2-rk.cave-ayland@ilande.co.uk, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 16:01, Cornelia Huck <cohuck@redhat.com> wrote:
> I may be missing something, but what cleans up the timers if we fail
> further down in this function? I don't think the unrealize callback is
> invoked by the core in case of error?

FWIW I sent a mail to one of these threads a few days ago
where I claimed we did call unrealize if realize fails,
but looking again at the device_set_realized() code I think
I was misreading it. If the device's own 'realize' method
fails, we go to the 'fail' label, which just reports back the
error and doesn't call unrealize. It's only if the device's
'realize' method succeeds and we get a failure in some later
thing like calling 'realize' on the child bus objects that we
will call the device unrealize as part of cleanup.

Apologies for any confusion caused.

thanks
-- PMM

