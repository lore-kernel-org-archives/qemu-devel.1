Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D5C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D84020838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LslFXGWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D84020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1OR-0008O7-Cv
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS1M8-0004hz-4T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:11:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS1M5-000331-ND
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:11:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so18258039wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=APIX+5l2GeU8/uYiZAt9OSH17nh/YqVqkN+9zsKxzSo=;
 b=LslFXGWZ+2hQJXB6wumkqSYad2PybxDUWGPWs5O6XZzvAodH5dDggU0e87Rl/ZjLrB
 X96Xiy0VumNSoXGLqSfpil4DnwcxKpaT13DocA6ncHcwq0I9xL5doCt9R3AzDZTmz1s0
 rk4EbVLmGVg0mgOOgKEWe6mF+fS8QsbV8Lphm7wO0dHpC+5tlrdzdyEO8HOjjW95oRf1
 J9QY/9BH1+66g11NzdLvkcKaR7e8stMjZs1cbpmDuZ6oSyd9zwyM2HLlAic3MbrXG9XD
 wrMtgUuSZxqUtlEQZhxp0YRPB+/lWxthoRcnU25e18JHe8Hb5k1DCj6u6asxifcWBxiN
 c0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=APIX+5l2GeU8/uYiZAt9OSH17nh/YqVqkN+9zsKxzSo=;
 b=d0EV5jPXL2xXZQW4XtSAyM0ix57RSPre24NECpZKK1Ir/GjHEYy3I1ghk82SGXEn6q
 ke0bhp+qRHxEodLEq2p7hCIkBU9rk1WuGMuz/YxBGQyO+880FY8bfySaU4kwzm4dLRWn
 Udei8wmcONDu7YSmZ985+QVnEQa2PX8v/Ad2JhI5iPkMkPBWIT3zpZ1Xtu8zgzEIhjyt
 i2mIqZLpCWtjAQkbpaIC7J6oPXCr0rqdW0hbGmKhrxnzsweulANQdqaYBmOkpsWrOCy0
 KNzITJ4RbLtVGWM+KqLyWQctt8PbpPD/xgyFNZ1c2jry1lQCVyyaxiLzFfKwr4pbYBJF
 UCyw==
X-Gm-Message-State: AOAM531uc0PKuBnfD9N1im9AY9fDiPf5tcN/TfCSB5aH2ENZVbC3DuEJ
 sg5gOj1YFBDkPpnrsSL4i/WzRQ==
X-Google-Smtp-Source: ABdhPJx4dJ7MjDEfp9YGhG/MH447M5RVkmHFDqeiH7HehBOF5dSDGXbBLDkgDfyFVO0dUT799JjRcA==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr12594177wma.189.1602522683808; 
 Mon, 12 Oct 2020 10:11:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm22329615wmd.48.2020.10.12.10.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:11:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B7611FF7E;
 Mon, 12 Oct 2020 18:11:21 +0100 (BST)
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
 <87lfgbzb2m.fsf@linaro.org>
 <CAFEAcA_rySOEc=AD0o79Qz=_1vXFxAEsU9SE7qsxmGUc1DZ_KQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
In-reply-to: <CAFEAcA_rySOEc=AD0o79Qz=_1vXFxAEsU9SE7qsxmGUc1DZ_KQ@mail.gmail.com>
Date: Mon, 12 Oct 2020 18:11:21 +0100
Message-ID: <87imbfz7wm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 12 Oct 2020 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> So the real question is are there any other -devices that we want to be
>> able to graft FDT entries on or is the generic loader enough of a
>> special case that we keep all the logic in there?
>
> To my mind the point of the generic loader is exactly that
> it is not a special case. It works exactly the same way
> for every board, for every architecture. It shouldn't have
> special case "this makes things work for the thing I want
> to load on these boards that all have FDT and want a
> particular change to it". We already have a loader that
> has that kind of "do what I mean" behaviour (--kernel),
> and I very much do not want the generic loader device to
> go in that direction. Its whole advantage is that it is
> not that, but is just a "load the file, nothing else,
> no magic" operation.

So should we introduce a sub-classed -device guest-loader which behaves
like generic loader except that it is also aware of platform data
issues?

The other option would be to add the logic to each board that supports
dynamic platform data. It would keep the problem bounded but also lead
to a fair amount of duplicated boiler-plate.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

