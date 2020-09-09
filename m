Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE8FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CC821556
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gADgROOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG08M-0007rh-Lp
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG07M-0006jC-KN
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:26:32 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:42745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG07K-00051W-V6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:26:32 -0400
Received: by mail-ed1-x542.google.com with SMTP id l63so2610604edl.9
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wpvymIGIQNzQ1H8674/RPali75R4PotkRllq0sVIq1M=;
 b=gADgROOwkydVyJzk4Dy15nA4f25H3PB66gxKC8e3M+ex9w3EsSHKC6+1Trn2zzo00g
 NpHzVhVwrg+waMp3/UqaedLdJe3jt1zFPasfdqrAa3yj2QdtJAeV25r8yw3OX/hZTu37
 kCvxciYY8ord5dDpPNFt3sikg0fEF6zehzmn9a4ESAjRxlzxosm9tcUu+54rndWkBgqI
 C6Lc13AfX3hpMrDa2deV2YAlW+fi+l4ub/0sEWcHjI/cQ6kAit5wMGTzvjpk+cS0ac2q
 v3/c97QZPCcwsAUIdDBqVDcB3FTccWwV1ucdhzt8HOcYvYna0hNfNjhRaFuQyslzA0/G
 sKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wpvymIGIQNzQ1H8674/RPali75R4PotkRllq0sVIq1M=;
 b=tTCCsrg41eNmCzKN1VYl0DdEM2DKVkH4hvAWGufo6Z/Hmo8orj2OTEFPrAP6Pi1ndf
 /NHRYGi9lsagNjepm7ylZt6VnN3aZ44vin+klrjYHq1mjhr5NgFkIUlbMehmHGLNHeXI
 fa/nbvvtNWI8VZKNJVftzylF4JrFnz24vysQQT40uPIdX9C+PaB4p6k38I2xhw+m+VtV
 NJVirczNQFAPCNnpNkX3ZC6UseT2/qM6Z34Vwz3qY7/TvDQpp0IJKGR1RPVNQ0enwGzX
 japRLh4ITKlRtC76haosz06XiaAUjRnfld2FkpLfFgwXbBcuUTCXiiwdPGE22GfeZ/pS
 uDmw==
X-Gm-Message-State: AOAM531xp5PtFWzod6464H/C+tJ9YG62JqdFBh5RfCJ+v8XPMqwCBKbU
 Z8Cw54kIzIwtjMSXJTwHPytB2ZEXZ3A69Vbsi+TM7w==
X-Google-Smtp-Source: ABdhPJzpKuAAwm75qDdhdT1NTOi/4MBilrUnpoD7lXYN1oTQSH4BEtbVFmFdjxE+gMzLQGApmHvqVOtcys8e6k4pnVQ=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr3990926edm.44.1599657989482; 
 Wed, 09 Sep 2020 06:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-5-luoyonggang@gmail.com>
In-Reply-To: <20200909094617.1582-5-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 14:26:18 +0100
Message-ID: <CAFEAcA8hGNTM+Mxp27tW+v=AvCFppiEiFoKKdB7PEXMKixH5fg@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] curses: Fixes curses compiling errors.
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 10:46, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> This is the compiling error:
> ../ui/curses.c: In function 'curses_refresh':
> ../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
>   302 |             enum maybe_keycode next_maybe_keycode;
>       |                                ^~~~~~~~~~~~~~~~~~
> ../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
>   265 |     enum maybe_keycode maybe_keycode;
>       |                        ^~~~~~~~~~~~~
> cc1.exe: all warnings being treated as errors
>
> gcc version 10.2.0 (Rev1, Built by MSYS2 project)
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

I never gave this a reviewed-by tag -- can you be more careful
with your tag handling, please?

thanks
-- PMM

