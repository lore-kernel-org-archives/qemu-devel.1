Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED3520772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvDTwEXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED3520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKni-0005Ca-Il
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKn2-0004e7-8F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:27:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKmz-0005et-Kc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:27:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id w17so18706746otl.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fo9aOEQy9HS3e+hOF9SLpkb8z3Qv5g3aGyuhDZkmsgg=;
 b=hvDTwEXJ6gzghd5wygsGUlwfGeokQaTvlGhEHJCHq8JSeWI6cRRTkrhIuA5cNSquHg
 NSosRkmvCPnlurfgWDCIbcI3l0SiOiTuAwx5Zi09GJJZGzMAQGHGsz3TejkdYJFnwqwI
 u7fitq/uGAEhWqgxE/XmUZRBmnLL2RntCz7Y+VJipgJ5V9yWQV7cjPIphb7iFbOzPpqK
 3q8O/SuNhEN2+bPR19bS1bodrFshAxOPIsTIEmYH1mFbBdm7HjJI19+uJzT6VgiZZuQH
 Wew5v4YuOfNmLIKs5EerBJpUQYTfuA6Q0jtBblWoldnvQDoeABkeXxzdgCo0le0/IFkB
 WZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fo9aOEQy9HS3e+hOF9SLpkb8z3Qv5g3aGyuhDZkmsgg=;
 b=KtvH58hXscyEx9W95R+Ms8TqSd/5zSeCMfNosOwzmWKmWPywyq/CGxIV/2tdnHPQZ3
 flwbycVCjJpQ9p6gbsFuzohuJqGArjTsqJ+Fe3HEi0wdUiTKmC8y++0AOBNGE9JdrfBW
 Am7ly+BohYBEIGhw4GREQrP+b171Soir3kmSuQEbC4XRD2UUYMM7n4YM5TL/KQ4PRrSC
 UvJ/NuDRS2+YOiBwavKofCjUzKhFKVJO7b6fBKm58YT8ffZArUSPSZDkitrRRo9QQ3Vf
 Jp9QCDYMAVbTyJ7hksumDpHDfQbBQNJYv/niN2h1jORrtYR8PahKBmOajVaZw9akCRn9
 3htA==
X-Gm-Message-State: AOAM5332MwdWxhQN6/Nc7hT7Y17tP29tuj1kjq7kQb16HxRPD/SzRg6j
 Q9Q5IfqR2KzX/6veSFO18I99ZM8BiMlckqGUqGqNZw==
X-Google-Smtp-Source: ABdhPJx24X3KPp26gbSYBFHA5aCcN8DsYWtJWoQxN2l3jNj5wHHvgP6AA2rQaryi2u7OffKirhuETNpC+yCSeiN7+yc=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr22973761oto.135.1593779252183; 
 Fri, 03 Jul 2020 05:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
In-Reply-To: <20200626235519.591734-1-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 13:27:21 +0100
Message-ID: <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> Time for another refresh of this patchset. Sorry it took so long -- I've been
> trying to figure out why the Winbond flash model isn't working with
> npcm750-evb, and I'm fairly convinced the number of dummy cycles in DIO mode
> should be 4, not 1. Unfortunately, I don't see any other machines using Winbond
> flash in DIO mode, so it's hard to prove that it's correct. I'm planning to
> post a libqos-based test suite separately.
>
> I'm also planning to add the vbootrom to qemu as a submodule, similar to the
> other roms, but not in this pathset (let me know if you do want me to include
> this in the series).

Hi; it looks like codewise this patchset is ready to go in
and it's all been reviewed. I see however that all the
new files are GPL-v2-only. We usually prefer GPL-v2-or-later
for new code: is it possible to use that license instead ?

thanks
-- PMM

