Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CD6C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3164214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8Os771p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3164214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0464-0003eD-T0
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i045Q-0003DQ-5t
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i045P-0000RX-0y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:22:07 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:36771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i045O-0000R2-Pe
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:22:06 -0400
Received: by mail-oi1-x231.google.com with SMTP id n1so1635149oic.3
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cyONkCluLhUbUtA73Kfob8ivOrSdvZH5LxKYAcdPEak=;
 b=w8Os771p5XvNblEn7FI7T256mPxDwRs32xQtPz1WcelwjanH0RjKtexrrk+D96rfHm
 ltGRRruU9ghDSAHW/nXL9LskMtdOVtZnH3kMLoR0mshfUC+cr1RHVN8p2S9HGlgsZ4i3
 POxY5D8fmc93I7IaeHyrskqzm84rm1UotncB+qXF9IH4swDtO/ZP5TFJ4TwdWZRGQAh1
 0EYclF+ghEJZQFRbq7OBGkcrUb9Y8KR101pX4JvoJ02DbDdRoQD0sNO7hVlJ9A7yIOrR
 g4i+TgiLYdAz1aUwRyOh+fcSU/qZHyBgS8bnsLPKvpogLuCWTZ1/gGLU1KhrFIprS/hR
 Ypqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cyONkCluLhUbUtA73Kfob8ivOrSdvZH5LxKYAcdPEak=;
 b=MyuDViWKr2U284gHJ+FTsChAvCewQmXHxJ5y13RCSBaTQa61xEzWbX/HZDwaBNF22D
 pyGIaWnosCX2yvLfP0IEjQ5BvSLZZOau3kqIjYlOekTpkgHfg2oFs3k3oAEs5okFsnen
 CWlYZ9MCKIY8IqhD1jW6bFf5OF0d+SZD7w3CITeLEq24HMeLH+aVA0w+a4DsHPxiETL2
 3RrWU9WYgwdRKxk7qjx04Bu1lTMq9W6PdnxQdeHCCYxoPacdkEjI/occHtaQ8GUP35tb
 1Zs4ox9KDR9FMagw5UhC8dTZ0nJhsaSjpti6p+g19EPoXQukXgwIXKF7zSsN/d8MXpj+
 autA==
X-Gm-Message-State: APjAAAVOxJsbtt7S4r62XfYS7maQNPN6jjWFdFIw0afVDoUJLpq5ocp1
 YEG/Pv2cihx/yn+Ryb7n/7QjuFdwCgfHsD/rsklIcQ==
X-Google-Smtp-Source: APXvYqz05mYBUXa8CjA4xfzDpylRP+q3kL57zTMZggHnvqcHEzgvowofWKqoBMP6M57AN2UGQWsF07tJA7WWYeFmk5c=
X-Received: by 2002:aca:4814:: with SMTP id v20mr17252084oia.98.1566307325850; 
 Tue, 20 Aug 2019 06:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 14:21:54 +0100
Message-ID: <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
Subject: Re: [Qemu-devel] Proposal for amending TCG interface naming scheme
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 13:50, Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
>
> Hello, all.
>
> I noticed certain barrier and difficulties wrt learning TCG interface by =
newcomers and to some extent oldcomers too. At least some of them can be at=
tributed to not best choice of names for functions TCG exposes, especially =
in the area of extract and sextract. I have a quick idea on how to improve =
it using the following renaming scheme:
>
> tcg_gen_extract_i32
> tcg_gen_extract_i64
> tcg_gen_extract_tl
> tcg_gen_sextract_i32
> tcg_gen_sextract_i64
> tcg_gen_sextract_tl
> tcg_gen_extract2_i32
> tcg_gen_extract2_i64
> tcg_gen_extract2_tl
> tcg_gen_extrl_i64_i32
> tcg_gen_extrh_i64_i32
> tcg_gen_ext_i32_i64
> tcg_gen_extu_i32_i64
>
> could become:
>
> tcg_gen_select_i32
> tcg_gen_select_i64
> tcg_gen_select_tl
> tcg_gen_select_s_i32
> tcg_gen_select_s_i64
> tcg_gen_select_s_tl
> tcg_gen_gather_i32
> tcg_gen_gather_i64
> tcg_gen_gather_tl
> tcg_gen_extract_l_i64_i32
> tcg_gen_extract_h_i64_i32
> tcg_gen_extend_s_i32_i64
> tcg_gen_extend_0_i32_i64
>
> The idea is to provide significant "lexicographic" distance between those=
 groups of functions, rather than having the similar name (wiht common root=
 "ext) for all of them.

The current naming of the extract/sextract TCG ops is intended to keep
them in line with the extract32/sextract32/extract64/sextract64 utility
functions in bitops.h. I think those ones are reasonably named. The
other ops are a bit more ad-hoc in naming, admittedly...

thanks
-- PMM

