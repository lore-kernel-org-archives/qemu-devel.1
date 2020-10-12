Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C45C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7852A2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4sCNcuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7852A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0sx-0004xg-IW
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS0rz-0003tZ-4L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:40:19 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS0rx-0007Kw-A5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:40:18 -0400
Received: by mail-ed1-x541.google.com with SMTP id x1so17692967eds.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XjXKXrasuBN3Ky1mkjkRUnvRJ3PFkjkayVZzWFVUDfY=;
 b=n4sCNcuBQZX+EO9tODiczijNK+QocAzrWfOlmY4la5xap//TnuN06Yb2v51roPAkpp
 ATiKnrGLKNqz9OUA2gcs85r2Myl7oDbHsRbEHXvmEbCjbZZwaUGWhNfsZ4ldUsxnUZyT
 I/bB+LyZxV3Yp7RFeGeiu8PWfTOa5Sy+MzSq7woszuSYtIxuiZGnCEBNAvTcAJKavjZK
 uEZUHYDfnTby/bFvOOGHntE9rsjN9URQmI7Pa8diVAiXK7AL/gNFHlfDzoMXuGpBODhX
 CV4vB9PcmoSpgUD35b0ALcycMSgiIvYFQnEyEn/CqRns0CHUN4cffrc83PL2idPLKAT4
 JsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XjXKXrasuBN3Ky1mkjkRUnvRJ3PFkjkayVZzWFVUDfY=;
 b=ccdPSpBEzwYZ42vUe4Mm0PCqVGXxRqdTgiwZFd80YbpH4LN2txOj9gpef6FYiO4812
 6eCZv+JOVASRiSWMUpoKGCpzXM4yI2RoSukcwyTG8rp0F9GMVJ1BW9hEBGPsSwjUwAgJ
 ocV1bpgnFqD26cLr1E4APehYIYi0ESvN5t95CBl4BkSz/W8Uvcql+RS1y1hsNzJVsi9e
 moBBYsGjvObWxDRhaXojgfTcednKR/pSPgk/S+cam8e1XQXUSwWAWFiFRA1uj/SKOzoK
 GKyfECNzTMUb+/LN8jXIbSXvCoJVa6W1OtjDQKwsf/BzE7bsIcnRRul9R+Ah1eRHjr4N
 WHyw==
X-Gm-Message-State: AOAM531gzXNoSkBEkDWYOtHYEPddffuxDUU3B9JIPX7jgg+5f9B5x/1L
 GZT5aroObqrr/7cieAJIOe+XEa8G/CKLqRtwjMdjhg==
X-Google-Smtp-Source: ABdhPJw/3lt6AEodMTp4YbgM03idREaE4hZIOL2WGiw2IXAoQxUPqiPUrX5z8LAVpcXx0OX8C8FkhMpaWWFwU1rkF3M=
X-Received: by 2002:a05:6402:3133:: with SMTP id
 dd19mr13161194edb.100.1602520815053; 
 Mon, 12 Oct 2020 09:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
 <87lfgbzb2m.fsf@linaro.org>
In-Reply-To: <87lfgbzb2m.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 17:40:03 +0100
Message-ID: <CAFEAcA_rySOEc=AD0o79Qz=_1vXFxAEsU9SE7qsxmGUc1DZ_KQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org,
 Andre Przywara <andre.przywara@arm.com>, stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> So the real question is are there any other -devices that we want to be
> able to graft FDT entries on or is the generic loader enough of a
> special case that we keep all the logic in there?

To my mind the point of the generic loader is exactly that
it is not a special case. It works exactly the same way
for every board, for every architecture. It shouldn't have
special case "this makes things work for the thing I want
to load on these boards that all have FDT and want a
particular change to it". We already have a loader that
has that kind of "do what I mean" behaviour (--kernel),
and I very much do not want the generic loader device to
go in that direction. Its whole advantage is that it is
not that, but is just a "load the file, nothing else,
no magic" operation.

thanks
-- PMM

