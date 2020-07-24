Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F4DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF4320674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REr7dpeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF4320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuVA-0001Vh-76
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyuUQ-0000z9-F0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:59:42 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyuUO-0004V8-Mw
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 05:59:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id e4so7581647oib.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tY39xB/n/GnQoICRfIUv8CVPYwynRRrWDIdwPvr1Rb8=;
 b=REr7dpeQfCcmwFOSBqWaLJ9ua1Ie0hoYujmEjCvIa6t8QBErIIVxpFegDeBWURs8to
 l++uge+4clOCdK6F9tpokyhBIMSSluUEtl3ktsOTfdJ36qFhqS8PMKCJt0G4lZPzajoR
 QNpH5pepKpp52wWn7OrH1eOtgYTTwhGi/sd5BjWKRJuD89XnBIGe8xrgnPvD2hFrfPoj
 FMdbbBBGDtqB+R5ZS0GF2gMErVnTaq0NwluuKJSFzw7kwHMBXnkso2K9l4u6SYyX5nnb
 Y7/JWcPTfZ5axlLL0XTbM2vUR16KbwTomJUjTVo6/nt5cqnOuDnvaP7UhLJrxROy3F9x
 LqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tY39xB/n/GnQoICRfIUv8CVPYwynRRrWDIdwPvr1Rb8=;
 b=EakioAm/bbAxaAkUVYRaxTbMDSmXhB17jGFvwGlfIPouM+WnaljAISynV1Rnyedgyj
 U4BJ6q2F0om9Q2+EvnIVUgI0p+B+8QeD/aOROwk/rRAXByNHiBiQe4afPAtPMpeKN5U3
 DHdY7ezdsIpLzSXYMHVZdyzONpHLZ4JJ3YZC4Ol/Ziz+VUpzyx8z7mYCyfXdfCFZUPE6
 UIa+16xTSoHi5z2sIF5zp70EJNT1aJdI+ka8NM23fE5cUikwYpgoaMaUPW7dbZEYSkSB
 0rIyw//0atkkkSYWxLdck+23+D3ZxgSeU5wVbk7RpulYOjuNtSrIbAjH+6PXNh6LYxvK
 cTkA==
X-Gm-Message-State: AOAM533orO8gZSij9TgnN8eNANxcsqNOx85xoD1wNDV/D6E7CVUd/vgf
 e3Bkv87YYdUjSYfdKeuZhy3b/dNqnMSvK/h05UaBIA==
X-Google-Smtp-Source: ABdhPJwBxUCRqdn4AsEhTdz2ebDwCNWbftMdkFu+UNj3qRhL633BkQyXxbP1J8oi+MVzFbEDVhyhxULroHY1M/f1zXs=
X-Received: by 2002:aca:2819:: with SMTP id 25mr6874111oix.48.1595584779353;
 Fri, 24 Jul 2020 02:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071657.21508-1-f4bug@amsat.org>
 <5d8ade29-c085-9f6d-b896-fda48c1f5666@redhat.com>
 <0ce8f279-1ef0-6d93-5fff-032783fba2b6@amsat.org>
 <45942406-2ee2-150a-fb11-d485a12ca290@amsat.org>
In-Reply-To: <45942406-2ee2-150a-fb11-d485a12ca290@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 10:59:28 +0100
Message-ID: <CAFEAcA9wXHK0h6kzfX_re=Q8P3Yv93c_WFQxjbEUnj_PhV-_bQ@mail.gmail.com>
Subject: Re: [RFC PATCH] buildsys: Only build capstone if softmmu/user mode is
 enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 10:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 7/24/20 11:38 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/24/20 9:56 AM, Thomas Huth wrote:
> >> On 24/07/2020 09.16, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> At least one of softmmu or user mode has to be enabled to use
> >>> capstone. If not, don't clone/built it.
> >>>
> >>> This save CI time for the tools/documentation-only build jobs.

> >>> +if test -z "$capstone" && test $tcg =3D 'no' ; then # !tcg implies !=
softmmu
> >>> +  capstone=3D"no"
> >>> +fi
> >>
> >> I don't think this is right. You could have a KVM-only build where you
> >> still want to use the disassembler for the human monitor.
> >
> > I had the same question with KVM, I agree this is unclear, this is why
> > I added RFC.
> >
> > Don't we have !softmmu implies !kvm?
>
> It works because it falls back to the old disas.c (if capstone is
> here, use it, else fall-back).
>
> Does this means we can directly remove the capstone experiment &
> submodule without waiting for the libllvm integration?

The theory (at least at the time) was that capstone was better
than the internal disassembler for at least some targets.
If we want to go from libllvm to capstone as our long term
plan that's cool, but until we actually do that I don't think
we should drop capstone.

As far as this patch goes: if you want to disable capstone for
the tools-and-docs-only setup then I think the right condition is
if [ "$bsd_user" =3D "no" -a "$linux_user" =3D "no" -a "$softmmu" =3D "no" =
] ; then
  capstone=3Dno
fi

thanks
-- PMM

