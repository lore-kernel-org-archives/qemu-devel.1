Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FFD2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0qWHdy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FFD2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAHV3-0001Av-15
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 14:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAHUA-0000f8-GN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:46:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:43463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAHU8-0001vA-Q4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 14:46:26 -0400
Received: by mail-ed1-x535.google.com with SMTP id f24so6711265edw.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OLmV+kZaRJZvdoyJi+sxWzHcAsFTnsA7ghv4MpufkhY=;
 b=u0qWHdy5voN8lQvbensm6R8DwVl9cZPbnV/wedoTYTbjGbcC88n9f9Z0TyPD46yO5Y
 Us6ClCaf+h5S19Y5dKV9+SCsprTipefFigIscw9Y+n64/Vtuk+U1LwHQngjBMOcHgTLu
 WFsteftQCS384UgHJhv+VhE8DhLQAmZguhkjFWlmJiD5yOvD8c1xcd9YlKVdzKGIT7hm
 PLT2GLERCo/zr4V8m3G4MZRJMpNs8E9w8FqXNChZ733qhQUbPBCUBYngrfIPVfsw8eW/
 C+kHtLtWyIb88zef7B7f6KAvWiXdljzZFcAelg7SH2Q7Pdyr74ZnhMSpL/Nc9CWMgcAq
 k5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OLmV+kZaRJZvdoyJi+sxWzHcAsFTnsA7ghv4MpufkhY=;
 b=tNQT8uMNmZjfTdQqE0ekkzploJefTcaSKrUia8lP97hieDak/xAhewyzlDBTXJortR
 SvgZQ+JZ9R88O5PN/XraTBV4IRTKUK21zTv26VVt+nAPL5twV6iWhKUtnDqbMUqgCD7y
 /67o/vBN7H0c7b7nBQQkknKqVSyJltwwIUUZDPdO2e8Haa1UDElEzNTz3lCfPzGl4VnY
 fso5z3G+vKoVidsWuTAuOV3DZCsb3WwFqZBpezl5wsICtcDqIAwJR3wX96cum6VPx+N5
 7fVhs6+7dWKTJKnD9KXGXm+rvuVsRXHGpf+LJ2pOUj8ZtxfCGyMM8bgyuZAG1Abu1FR1
 2UqQ==
X-Gm-Message-State: AOAM531zWiDTXguMNMckdZXlIAlL3nKRhAoLqx/ryPKsMU69WX8b7Vyz
 kl9h4CMsQ6UqT8SNXhuA/rg9j58yoEJzgG0OgDzxDQ==
X-Google-Smtp-Source: ABdhPJzjZprd4Nqagk1/q7CRUPnTyvBaTT3PSBywcA4F+VElpew7/ZFhgD+VVPv9pzYhl8BLfLjWIm7Ihtu3ML79tuw=
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr2905055eds.100.1598294783012; 
 Mon, 24 Aug 2020 11:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
In-Reply-To: <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 19:46:12 +0100
Message-ID: <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
Subject: Re: meson.build files are missing copyright/license headers
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 19:29, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> On Mon, Aug 24, 2020 at 1:44 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>  It looks like the new meson.build files are missing the usual
>> copyright-and-license header comment. Could somebody add them,
>> please?
>>
>> scripts/ninjatool.py does have a copyright line but is missing
>> the license statement.
>>
>
> Afaik, most makefiles didn't have any, so it falls under the default GPL2=
+ LICENSE rule.

Yep, but the rule is that new files should have them, even if
old files didn't always.

> If it's a matter of prepending
>
> # SPDX-License-Identifier: GPL-2.0-or-later
>
> On each meson.build file, I can prepare a patch.

Everything needs at least a copyright line (in this case, judging
by existing files in the tree it will probably be something like
"Copyright (c) 2020 Red Hat, Inc." but check with your legal
department what they like ;-)), plus a statement that clearly
defines the license the code is under. We don't mandate SPDX[*],
but it will do the job if you want to use it.

[*] Mostly because nobody's cared enough to say "we should
standardize on this and convert existing files and add the
check to checkpatch that new files have an SPDX line".

thanks
-- PMM

