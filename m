Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6E7C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B2321D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLUKmmhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B2321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75IR-0002TU-6r
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j75Hp-00021q-LP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j75Hn-0004ss-FK
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:36:13 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:32852)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j75Hk-0004kL-IT; Wed, 26 Feb 2020 17:36:08 -0500
Received: by mail-lj1-x241.google.com with SMTP id y6so1016713lji.0;
 Wed, 26 Feb 2020 14:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hycO/r6ehLWFkXOuplhsAZTzrdlyWBSx+ojI/UFkOQw=;
 b=ZLUKmmhfSQ/Uuc3kfT0fuVzYAfHBLvQqzJ/okSOo3xKYCDMuSw6zoOqAyD4V9gfsoc
 G6uFB/nc6ZcVA7swv/TgGG5XrGXjHpY3ukRUHmG4kmb7zMeDwLKQuDEWCFq4paBkLKWD
 3N2MBeT+8kRr3zymSgpGiZAHqOMAvNsPvBVjcmhBUzLZL0eXfQUSYlJNyrLis+4A8UvL
 sRoNMTxPMrTnxb2RyRZUbT+rUJubShQnTpGzJBLSuFyOLKNExvDHQF1sY+ngyKTXJwUB
 sDZ7jA0impodT22f8WeOQw6Bp/4FKluCG8QuUCDX1XHpxp3rlBGPB0EylWd8a2L3KR0A
 gqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hycO/r6ehLWFkXOuplhsAZTzrdlyWBSx+ojI/UFkOQw=;
 b=NW/coqBkmX4D7h7IiPJm7Ea8b5LAJJOR+FOgvSnAFXtvFuhj/v4T+bBD6p6xlWMf9V
 F2jmbB8kZw4yOb59VfplbQZs6unYZaDMd2tWHkObuqNi7T34aK1jfi6rSMEXZv+cvD5M
 g+vQlvLnv2C3lMFFBTOx/K82k5QSykGpLTQGdYj2ZRLH00Kp84rHFz8aP3zVH2+aGjb9
 SMG9lG7DKNARaEWXiJT3uk+Xn1j+CFfRTHe1KXGqTrmaXZ0YlBdQhJuA1AS5RjYaMxtZ
 3iN+k+HVlSXuacL+qSxer3mRqQudDCELBol8AyYymOZ0Qc3qbygB7+b5Syrl08QAy73q
 LmNg==
X-Gm-Message-State: ANhLgQ1QUrStoRMwUUcHGeKx7RIHXT9DIWOaGDapjdTBjdXUfZPME3Ap
 dm4E8hHffc3GkhfeH/LS8EDm09BqHRNauWYZVOI=
X-Google-Smtp-Source: ADFU+vsAzgnNYZrRmdOQdFuhNbJQq8clqct3xUsyaiUUHAXRzfhhSCUBemP3hFS51pFcZRmFZpUFJKkRnM6iOfzhhK0=
X-Received: by 2002:a2e:b4ac:: with SMTP id q12mr678950ljm.285.1582756566951; 
 Wed, 26 Feb 2020 14:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <ac290e38-bb39-6551-0758-95d087fa568c@sifive.com>
In-Reply-To: <ac290e38-bb39-6551-0758-95d087fa568c@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 14:28:30 -0800
Message-ID: <CAKmqyKOedrW3HZFfep4ErJ8H86V=KXeBL8LN2Cy_+669a6c9gQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] target-riscv: support vector extension part 1
To: Jim Wilson <jimw@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 12:09 PM Jim Wilson <jimw@sifive.com> wrote:
>
> On 2/21/20 1:45 AM, LIU Zhiwei wrote:
> > This is the first part of v5 patchset. The changelog of v5 is only coverd
> > the part1.
> >
> > Features:
> >    * support specification riscv-v-spec-0.7.1.
>
> I'm still concerned about versioning issues.  This implements an
> unofficial draft of the proposed RISC-V vector extension.  This draft is
> not compatible with the current draft, and will be even less compatible
> with the final official version of the vector spec.

I wouldn't say this is an unofficial draft. v0.7.1 is an official and
tagged draft spec.

It is a draft spec and there is a new version (v0.8.0) and eventually
there will be a full (not draft release).

>
> The patch adds a version which is good, but there is only one check when
> qemu starts.  Probably something like 25% of these patches will be wrong
> for the official vector extension.  How are we going to handle this when
> someone submits patches for the official support?  It would be better if

The current plan (for all draft extensions) is to support just the
latest draft in QEMU. That is QEMU will have experimental support for
draft extension x at v0.1. When draft extension x is updated to v0.2
we will update the QEMU implementation (when we can) and only support
the v0.2.

We will continue updating and supporting the latest until the final
spec release, in which case we will then maintain the feature
following QEMU's deprecation policy.

While the spec is in a draft state the feature will be considered
experimental (hence the subject to change).

This way we can support and enable users to test on draft extensions,
but not spend all our time supporting draft extensions.

> everything in these patches were conditional on the version number.  It
> might also be better if we stopped calling this the 'v' extension and
> maybe used another name like Xrvv071 to make it clear that it is an
> unofficial draft of the proposed vector spec.  Or maybe be we can use
> v0p7 but that isn't an officially supported extension name.
>
> If this rvv 0.7.1 implementation is considered a temporary solution,
> maybe we can just remove all of this work when the official rvv spec if
> available?  But presumably it is better if we can have both this

That is generally the plan. When the final spec comes out this will be
updated and we will only support that.

> implementation and the official one, which means everything needs to be
> conditional or tied to an Xsomething extension name instead of the V
> extension name.

I agree that would be nice, but that is a lot of extra maintenance to
support a draft spec.

Considering most other projects won't accept draft specs I don't see
the huge appeal to maintain draft specs.

Alistair

>
> Jim

