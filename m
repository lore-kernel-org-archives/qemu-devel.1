Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7050C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A26124670
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/N/zE7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A26124670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOJv-0004tK-NB
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBOIw-00040b-4V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBOIu-0005to-Sw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:43:09 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBOIu-0005t2-NI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:43:08 -0400
Received: by mail-ot1-x341.google.com with SMTP id f21so10790360otp.12
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Q0CdpBdOvt1w8ablW8lhzSlbAov/4auH4UW9T9m4ak=;
 b=t/N/zE7SlQPXnGOdhKyQB+/LdXTQwRL3DAyug0JEi8pdjlA/MRIYf5MW/87T7YviBC
 X+jRlSICqIe//5p9WAcxpF3BhBY7p9A/E5gaco9niKqniURmfDsEdaTy8kqxeHR+DApv
 PNc6mLjlVLOmGtmyFk/Vgy3JtVd2yrcH7QfZCG3r/u4S2lr+i9SR8HAkVAOGIVs30n2B
 /z5UAWClRjBoGkMRzSbKOY9LAQZwkkl+6Zlx2KwZ/GtE9C28dJX9UCNtakzwa9p0Gs9U
 CQxKO3G2jqsFIAfXVp5JY42pEw6ofhUTtP1oIM/rtcecmTihMVehhRCNr6hEGgOW3xLV
 iRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Q0CdpBdOvt1w8ablW8lhzSlbAov/4auH4UW9T9m4ak=;
 b=s3xN3Db696pAVcTZuLxU7/k33CpH8JULNZmFWRDLM+8jEAXSSDZX6KWHEFc/RtLnvV
 zcs7+sFPKpw821YHY89VsLtkJoYfh+wpppljMEIU2F9SlgcQCx313LucM/WmNjmnzEDf
 fZRDwoxuHa/XZ2jjseqn1y5x4r4bOt1lwxjfCuvjw04z6f6zfnKzPXV7uyDpc7/FaLsc
 ntKbN8m6CyrgE9SHPBIcZGKxjySgrcl3zONh+i7iYBlLeM7a2u6eQKhi5RkXR7F9IacI
 CRh5TU6uvZha+08c8a5tJQtyWPY1a7XKmoMapAvBfdBzx4uKyxHGYzLBzezUHKEI4eIN
 yrGA==
X-Gm-Message-State: ANhLgQ1p7du2byXwtMyZWunlLthIJE5LjEhjeqb5plzWSwX2KMFXSqVE
 m7vWmCkl41PMOmfXnYBXOIH9HkLl9ByiDImlWBvtOQ==
X-Google-Smtp-Source: ADFU+vsTeO4teS062nLpVbWucmUfbN7jHRjL2aPiTcqxXGawRxCdYFVT5yxzsLNh4WSaxTroMaZZJY6/sjLXSi4oKpQ=
X-Received: by 2002:a9d:6f88:: with SMTP id h8mr14268504otq.91.1583782987624; 
 Mon, 09 Mar 2020 12:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
In-Reply-To: <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 19:42:56 +0000
Message-ID: <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Niek Linnenbank <nieklinnenbank@gmail.com>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 19:38, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> On Mon, Mar 9, 2020 at 12:22 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>> Yes, this is now the right place to put arm board-specific
>> documentation (the rearranging and conversion from texinfo
>> is now in master). I should move microvm.rst's contents there
>> I guess.
>
>
> OK, I'll move orangepi.rst to docs/system/orangepi.rst and add a short section
> about the Orange Pi PC machine to docs/system/target-arm.rst as well.

You should include/reference the orangepi.rst from target-arm.rst, I think --
that's where the per-board docs would belong in the structure we have.
If you just drop a .rst file into the docs directory somewhere it won't
actually go into the documentation and instead Sphinx will error
out about it not being in the table of contents anywhere.

(I'll have a look at microvm.rst to see how best to make the structure
work -- at the moment it kind of assumes there board documentation
is always quite short so they're all in one file.)

thanks
-- PMM

