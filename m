Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69F7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723432467F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OgjwJ6ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723432467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuD21-0000tt-Jb
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iuD1G-0000Rf-F0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iuD1F-0001Km-Eg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:13:54 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iuD1F-0001KJ-9A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:13:53 -0500
Received: by mail-qk1-x742.google.com with SMTP id v195so5672023qkb.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v/v4gsunZW3/SK3txv49RS3OswX6Moo8iJj9KiNLNZk=;
 b=OgjwJ6ipmysY8QY7m+iVUYCtrCC4Gq60ZF7VknltICjgEeV/IlRhLkejG3/BbyPeKZ
 jZHigYJ61VVy0eMV+i703qL93FoYcUV7YXryizSnFXClFrKTVwvIxlB4EqXxNhRibPUH
 x+01SFXzBtGJJegbKdhk19B3e2dZw+OX9l5jM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v/v4gsunZW3/SK3txv49RS3OswX6Moo8iJj9KiNLNZk=;
 b=Ulif7wIxXyYMf3TsLj2/uST0wXp/CdtYlRwEXHPm5wswoTIaLBPumTvl/4iBf/BBRh
 nqmX+meTbZPPbaWJAbo1s6o7BE/Q7iIn9FoXEEkhznx2PWNKcBahp3S9W0DgLr0y/fdb
 w5vDL+GCSemHX5JiE6zw1sAq16w1JNo5w3PTp2Q/T9XsqKOtG9voWFoVy6ttNmRvzOvJ
 f5+B2Ro/zRy63E277nNZVm0ud/rYakrX1kAegQteR+e18huEckl7x/kKUBi3vBJvhi/L
 QiCuCHLRQoDe1VBdGEoupsfQ/GfOIhdCSt9I9D0MtFB/yq12xzfQfjuKA47JL+7SeV1U
 ECPw==
X-Gm-Message-State: APjAAAX6c0p/NAaFYpmKmyebdeTjeP4/eLY48MQ8JkzJ7bucjIv7y6QY
 iJwjbS3x9AhLT8K2b77i0/nWVFoPXQAnk23HBA9trw==
X-Google-Smtp-Source: APXvYqwUv897TNxhaRUh9087ToKhnGrEv4kyAiCMXN4m5pnLcbNPvv45TSY+d77prKdAy3FM+9B3p4HD4eKhdGOjIxA=
X-Received: by 2002:a37:63c7:: with SMTP id x190mr9140006qkb.232.1579688032385; 
 Wed, 22 Jan 2020 02:13:52 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
 <20200122032103-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200122032103-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 19:13:41 +0900
Message-ID: <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +When an object created by one virtio device needs to be
> > +shared with a seperate virtio device, the first device can
> > +export the object by generating a \field{uuid}
>
> This is a field where?

It's a property of the exported object, but I guess it doesn't really
correspond to any concrete field. I'll remove \field.

> > which the
> > +guest can pass to the second device to identify the object.
>
> s/guest/Driver/ ?

The uuid can be passed to a second device controlled by a different
driver, so I think 'driver' by itself is ambiguous. I'm using guest as
a shorthand for 'system which includes the drivers and software which
sits on top of the drivers', and that meaning does seem to be
compatible with language in the rest of the spec. If that shorthand
isn't acceptable, I can rewrite the sentence passively as '... a uuid
which can then be passed to a second device ...'.

> Also - what are guest and host here?

There are a number of places in the virtio spec where 'guest' is used
to refer to the system where drivers run and where 'host' is used to
refer to the system where devices run. I guess those terms aren't
concretely defined within the spec, but they do seem to have a well
understood meaning. Or is the guest/host language discouraged in new
additions to the spec?

-David

