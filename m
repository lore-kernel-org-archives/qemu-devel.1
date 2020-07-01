Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1302EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A05206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdMpAPls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A05206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdkf-0006kk-3I
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqdhE-0002XQ-Jl
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:26:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqdhB-0002ER-HC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:26:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id o2so23482850wmh.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jBUUBvbLB49Z89LD5FeOTagtD77OsB3rwZSPJ8JF2Xk=;
 b=vdMpAPlsE0/PEniqGDYhH/IB8efei9mOlm3c408Ox2X4/PUQSujrf3ucI3GLcS0Xa4
 V5nysJO2igbjhDc3fpIW8eK7GOSIKwIoZLzLss9AdNkBFyK9grVIyOmOXrCc2s+mYWct
 VtOmFUljiSBgxXUoQuHHOm5L8SDSD9DcsG45Y0PeQxrnqWgaNcAaMln6v9oxXPj9ckJX
 7w6P/HwiUetTWPXRxCAT94x4uxPJqNgiG5GChzHhxZbIU4MPEFsyraxFMXuBK9BxLn5s
 mP+e8E1zPIbztAF07zCJgArIBDikJ58VTDWMSfUqwhPMBEhKJoohTUc+alGSfSIRIvOG
 nWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jBUUBvbLB49Z89LD5FeOTagtD77OsB3rwZSPJ8JF2Xk=;
 b=A3nwgCsbV+c31BSBIXXQH//8vTjFNyRtrPyhpeby/EgD2kjcHdpOObzGxlRxNArkCQ
 0x0q7X8PLm7ujlfRrLXUoQTK9kUSi2j9lZuF5I7j8SIwCamQfoKrF+2tJKiSvUf8T0DE
 yv+AVs0qU6nGoavEPDcH8lKcc9evnI8RePf6Gtcp1ExbZ+m4Ux0887KxwyV3vzBq3G2X
 VGbi8BaoFZeINB2QGTapxCueNqhbbK5BEeIJiEFFiZNKuubmG75RC8R23qWxJEmiaNb6
 SqzkatVY2sDaVfd2I3A6qjvoqmfKu9X2wjFK2wm4PPUO4v8VvollKbj9pDqpqg1TcQWx
 sTOA==
X-Gm-Message-State: AOAM531mzHxPvp8BoiN6nYvUtSrSAkJEacgJL3gYPkEDVlYKDZ56isxo
 5UioW8K80u0BpoDSXonWZsf4J6ZGgj0XXaoSJII=
X-Google-Smtp-Source: ABdhPJzVUbZw/pxQw0OQL1nnXH0qccOMpsdJEmzULQjE4GVdnUuZzg2kcJgEoVsbgHXdAeA8sjaeX3Xqoqvk7A3nZ0Y=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr26026149wml.36.1593613599766; 
 Wed, 01 Jul 2020 07:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
 <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA9T1NGyi0g-DN+KGxpJwepWLfapDaWKVePhMEfeHvk5mA@mail.gmail.com>
 <d507200e-07ca-1849-30cb-9aed70161b2c@redhat.com>
In-Reply-To: <d507200e-07ca-1849-30cb-9aed70161b2c@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Jul 2020 16:26:27 +0200
Message-ID: <CAHiYmc4nYezbCACt7GtNRsL4G1RLSTbrJ8JqtkF-KAwPVYCzQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkpatch: Change occurences of 'kernel' to 'qemu'
 in user messages
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 4:20 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/06/20 17:04, Peter Maydell wrote:
> > On Sat, 20 Jun 2020 at 14:33, Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> >>
> >> It is odd that we inform user that, for example, his current working
> >> directory is not kernel root, when, in face, we mean qemu root.
> >>
> >> Replace that and few other similar odd user messages.
> >>
> >> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> >> ---
> >>  scripts/checkpatch.pl | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Regardless of my comments on the cover letter, for user facing
> > messages this makes sense, especially since it's only 3 lines.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > thanks
> > -- PMM
> >
>
> Queued, thanks.
>

Thanks a lot, Paolo.

There is though one spelling mistake in my commit message:

s/face/fact

Truly yours,
Aleksandar

> paolo
>

