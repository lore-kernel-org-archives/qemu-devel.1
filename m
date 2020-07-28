Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001D92065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weSXbOoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001D92065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SKb-0001pJ-Am
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SJp-0001NN-3D
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:19:09 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:39488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SJn-0001t9-FW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:19:08 -0400
Received: by mail-oi1-x232.google.com with SMTP id w17so17972543oie.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=woIKF8NHCtDYNOBgmfuNOP+ClLc+ZIVDGuPSoGdWTig=;
 b=weSXbOoNV/J6MOyfEE6mVcHDKabeMjlwo8cU4dqhxsWc4aIbJ8KJQXGpogMUZLzgHK
 z1vHUb5ahWPzdM/2SiBka9kA5XOr+jKCWIHwhrdQYOSvdlH2i2cNV9REGRyOut9UZwwp
 ZZaChFMvvCkPC0AoyyRcOqf0MuKQ3WhNsC9ADoT6nMtxJDHj9xmVG2ODwOcH+1kSJJ7u
 gP2lqRJy2YhsCDzPZaCLaQBhvqYR8IkCdKAagRdRTSgM7ygahwqo/tetfbtMoT0bsSGl
 LPaBSMRvET1m4QSBcsSOvQeu2og3XAUUgCB4BXCdeUj5Z7seuTdED/Soi2SGnSVa8Vbh
 fxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=woIKF8NHCtDYNOBgmfuNOP+ClLc+ZIVDGuPSoGdWTig=;
 b=nb9GLpV9BNqL3UV7lUO+PE3+/QQ96uD3XMIkQXM2MliSaDtSfLv5FRtyO0Tt9NUhUX
 bvW8D4KTtGew/hksvkjfHQpukI3LGw1GpdkYzUwKxjuTo8WdYpst9UgKByYYxMpirLyh
 b1/Ga8cvolMny2bHTNtDdCZRi0ZjctBMsfDU4Fxad+oz9ouix+ch/+sqFdp2nLw21KrX
 P3nmkhWz9UhQsBXsiq6OJsP6rE/+LC2Vum8+49N5nzcpQTdy3a1biNYNs4RDz18P04Sg
 0Znqo1uhjBJdtsoGbIm9h+N5OnNhj3mILjk5pL3hoHAbqdbvWUBnG42CdKVWiroZc4nc
 +9jA==
X-Gm-Message-State: AOAM532f5+1vTnGXoTzl/3JXJfaUbVOVp3tfHQSzRMBiHwmpBXXUGy9/
 aoZbuSCmwo6upts5AWz4N1Gt7Mq+MPyeNIF7zim2Bg==
X-Google-Smtp-Source: ABdhPJyy3lnYCfsTi5pgnq7xabTIhnyJhhtXh+WKvaoZnHMs/NwYYVwXOEf2+RsFkcVUSvidcXQ+0Mzin+3VKGZ0TjA=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr4169962oia.163.1595953145989; 
 Tue, 28 Jul 2020 09:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200727122357.31263-1-alex.bennee@linaro.org>
 <20200727122357.31263-9-alex.bennee@linaro.org>
 <CAFEAcA8oTrHUzOF5tcqVDNtPWdoG0Yz0GKb2=JuT3O5h5g-YQg@mail.gmail.com>
 <87r1sv39u7.fsf@linaro.org>
In-Reply-To: <87r1sv39u7.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 17:18:55 +0100
Message-ID: <CAFEAcA-kEXPyGtE+eYW_bBEmtKh-zUGAR=rrX693xer7g9GpOw@mail.gmail.com>
Subject: Re: [PULL 08/16] linux-user: don't use MAP_FIXED in
 pgd_find_hole_fallback
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 17:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Hi; Coverity thinks this conditional expression is suspicious
> > (CID 1431059):
> >
> >>              if (mmap_start !=3D MAP_FAILED) {
> >>                  munmap((void *) align_start, guest_size);
> >> -                return (uintptr_t) mmap_start + offset;
> >> +                if (MAP_FIXED_NOREPLACE || mmap_start =3D=3D (void *)=
 align_start) {
> >
> > because it's performing a logical OR operation where the left
> > operand is an integer constant that's neither 0 nor 1
> > (it's 1048576). What was this intended to be?
>
> It's 0 if the header doesn't provide it. If it's !0 we don't need to
> check the address because it should have been in the correct place.

OK. "if (MAP_FIXED_NOREPLACE !=3D 0 || ...)" will probably satisfy
Coverity then.

-- PMM

