Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB7820776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1IR4/Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB7820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeL8D-0001Vo-Sf
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeL49-0006bi-5Z
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:07:33 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeL48-0002jl-CR
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:07:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id v17so2787652ote.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VQcZ5tkf+SOVTcZB4BEx7QsIKrHgiOEwPN+FOSH8cKM=;
 b=q1IR4/Efhbs0f5zu4ng87QbXH8o/HD7cHapnVszM4LBd0GFLet9bRIqpkSTmKkrlHr
 tIwrA/UaHU39S3CPt/IAU+fe8hWJrZbTh28/QjHf8TgMXdYloDm5O8/AIMuSdU9bYmj1
 C1L4V7jzwHCWOG8dNE/INo15ZaHpu8luPYr9idpHSAfe+kmBuiLgFvzdRJoIk1iQdyP5
 gH8U1OR8RRgx+2Ye4bfqCOGP+TH6O2SpajL6927rGIbxkzspCwGKbtW181HdsBkcDDMK
 sMkbdXiTVGMuxN8o67FkTkM43SyD7DhmZJ4Xv5YirSvG/bD2a4c3TvaoTUDQFkfGNsh7
 CXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VQcZ5tkf+SOVTcZB4BEx7QsIKrHgiOEwPN+FOSH8cKM=;
 b=fbGd54YhiKkfakVB6ksCW4EvEpIa1kpvO6AmZ+NPGClkGxpO4H1IgmLgdiB4MySM8V
 nYuaZSOxJLSPRJsTdSSstHSXj/BCmQGZ1TDQZRz+UnBGPWS+SywaaEBYptO898LIjkrr
 soNg8ZhiNDDJBpT+sxzNM2TJuF3Q5eUNSdxQsSo8Mgc/G25XyolsGaOeYYpJcC6y9mFI
 wXhXmqYBRW74upREzCJhrH4Frl5cukNul3bT0vnkGdPQir3sFy0wrspm5VVoIrmFQKVL
 hcgXHv9RFthtxUHKJWbdn2e4lUG26x+6Ic51eTcBek5Yxq4vGxCEz0cehXqlF6/Gc3gf
 ivLw==
X-Gm-Message-State: AOAM5329cjU7XGt4aUQsi4ovxHlRfqLCTsH4qnQm5pjYcOuu4BvZ2xyz
 YLDCvJxWqSowpnTVZ0N2zdQ8MNoob2YB3p+8ymHzCw==
X-Google-Smtp-Source: ABdhPJzyAQZ7rfZy+bnjTvftRML+OqIKvkA8fnWG/UDpg0t6W+NkZyJqFne06Stq239IXils0UqsTcv+jdX92Xsy9BA=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr2676423oth.221.1590682051166;
 Thu, 28 May 2020 09:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
 <87blm83y5v.fsf@linaro.org>
 <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
 <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
 <CAFEAcA-EZ_c01599j+NJH1Vd0aJ4cQzwPYynx=rBZP7x_3h3jg@mail.gmail.com>
 <72395696-4b12-b843-901e-c0db34d6c2d8@redhat.com>
In-Reply-To: <72395696-4b12-b843-901e-c0db34d6c2d8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 17:07:20 +0100
Message-ID: <CAFEAcA9emvHkWBGSRD2KOJN4Re1RBfV8dfqEFvXBY3ZzkdU7-w@mail.gmail.com>
Subject: Re: [PULL 00/12] testing and plugin fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 16:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> > Did that change not itself trigger the VM to be rebuilt ?
> > If not, can we make it so that updates to the images always
> > do trigger rebuilds, so that we can catch new warnings
> > that they introduce at the time rather than later?
>
> This is how it should work... How do you run your VM builds?

git fetch pmaydell
git checkout --quiet remotes/pmaydell/staging
make -C build vm-build-netbsd -j8 V=3D1

thanks
-- PMM

