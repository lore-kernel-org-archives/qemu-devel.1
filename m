Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90CC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 01:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB1A206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 01:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dx25vrqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB1A206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipj7R-0005kw-9A
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 20:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gurchetansingh@chromium.org>) id 1ipj6Z-0005K0-41
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 20:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gurchetansingh@chromium.org>) id 1ipj6X-0003D3-TC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 20:28:50 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:32985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gurchetansingh@chromium.org>)
 id 1ipj6X-00032X-HW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 20:28:49 -0500
Received: by mail-lf1-x142.google.com with SMTP id n25so237250lfl.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 17:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZD5FeMyHEpLAI4RDmBEkPzFF4c6By+Nv+YvyYt2HRIE=;
 b=dx25vrqJP+K1GrmNcbAdfaMQuy+02/bLxovM6P89uUQ6NWWd+i1gpDdhdeyMn14FX9
 6STwL+63/lbwt60KeTK4ESs1ypvW969zHNzz/fuOczRCsfucBkgnjGpOfwnUP9QNHx/X
 bwGTSujHWHjHk4BYjzhzgiqY44+Z55GXKT70M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZD5FeMyHEpLAI4RDmBEkPzFF4c6By+Nv+YvyYt2HRIE=;
 b=ItqbckAQZsovpHiZPs1V7IsyuM2YqpUUqyHyPLjir6Y6Ub2p5rZciXT4j6XnaYNK64
 tUKU/SgrVPxAq2K19YO8KEsw4n/myDNrfMtaFBF5Yj73vBXU0dMkuqyMbE55xAs9OwNS
 mUxfobPKhMeM36g3bqgBCy3PUOtjnwQ72g4K/0Xw9+jgo1YNK2QvQHAa0UoenYI1Kn57
 J8AZx2jbgsbofGwo4STzk6h4yuSdd8gELnzZ9JrZg2seeYm7d02Km4Z5l2NSeFg8dOfn
 z1/6U1rDQPJPujuBg1023TguxYBiW1UMoNkxfRj/huwerxfo1w6pjP6VoBdrmFGKo2LO
 HNRw==
X-Gm-Message-State: APjAAAWP5tGMWYWWiqWE1Od+/bSS8E3Rst1HpXBfcRoo8R22LDbjMbAL
 Cpiy6tlpWQ9oqxVmbVFntWmNhLg45f0=
X-Google-Smtp-Source: APXvYqy7OhgC48U0cuv6q7v2oR4gNak5ACwCdHoOCpmVR/07EcvTea3aAP+pG/DgsgZJk/5zGnuNQA==
X-Received: by 2002:a19:ae04:: with SMTP id f4mr444061lfc.64.1578619726810;
 Thu, 09 Jan 2020 17:28:46 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id 204sm196501lfj.47.2020.01.09.17.28.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 17:28:46 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id i23so213426lfo.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 17:28:46 -0800 (PST)
X-Received: by 2002:a19:c0b:: with SMTP id 11mr427248lfm.135.1578619725775;
 Thu, 09 Jan 2020 17:28:45 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
 <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
 <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
In-Reply-To: <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Thu, 9 Jan 2020 17:28:34 -0800
X-Gmail-Original-Message-ID: <CAAfnVB=z_wCkN4nsAfnapp7sq0hUFfAEbtcnvdiZPHVwjfDL9g@mail.gmail.com>
Message-ID: <CAAfnVB=z_wCkN4nsAfnapp7sq0hUFfAEbtcnvdiZPHVwjfDL9g@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
To: David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 Dylan Reid <dgreid@chromium.org>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I like the idea of having one central place in the kernel where
virtio-devices get their uuid from -- i.e, no separate VM specific,
device specific implementations calling into uuid_gen().

On Wed, Jan 8, 2020 at 3:20 AM David Stevens <stevensd@chromium.org> wrote:
>
> > Is there a specific reason why you want the host pick the uuid?  I would
> > let the guest define the uuid, i.e. move the uuid fields to
> > virtio_gpu_export_resource and scratch virtio_gpu_resp_export_resource.
>
> Sending the uuid in the original request doesn't really buy us
> anything, at least in terms of asynchronicity. The guest would still
> need to wait for the response to arrive before it could safely pass
> the uuid to any other virtio devices, to prevent a race where the
> import fails because it is processed before virtio-gpu processes the
> export. Perhaps this wouldn't be the case if we supported sharing
> fences between virtio devices, but even then, fences are more of a
> thing for the operation of a pipeline, not for the setup of a
> pipeline.
>
> At that point, I think it's just a matter of aesthetics. I lean
> slightly towards returning the uuid from the host, since that rules
> out any implementation with the aforementioned race. That being said,
> if there are any specific reasons or preferences to assigning the uuid
> from the guest, I can switch to that direction.
>
> -David

