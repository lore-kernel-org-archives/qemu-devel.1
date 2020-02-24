Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A82C38BE1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8451720836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EStkK0Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8451720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IhN-0004b1-OI
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6IgP-0003rq-Pq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6IgO-0005mO-Rt
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:42:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6IgO-0005l4-MY
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:42:20 -0500
Received: by mail-oi1-x242.google.com with SMTP id i1so9929785oie.8
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=frW4XW7C9DTZGXxJUUdjq/QcCG5YG62CSZMprWf4x6Y=;
 b=EStkK0TsxQSuLSG1efUjuQEwGXU+WkgTERGXBN3i+bKNioU2iDXXMgmj5kUXqjAahe
 dT38pnyNKn12CIrDn6FjFHpq+EWRO9B9kFTgMTgknciZrwgWZeiv2PgFj+1emj4hLeuB
 0e6rbeTXs5gMtLKyJwLMAmoWtTBEqXr5WaLf4Z2WK9Qs/0bHatkbwcrxqTr6OfIv4Lp3
 lzfrdHduqKFUewfRoO6zQG8yzBonU+tRFLyF9CMzlvrsxZsXlUsywjzNQTbhEw/ez3ac
 TIKAecbyjo6F1so/1s05gvu26SfP0lR9Cj1dx+nCbCLAihcSNKBzv40yzM9B0Lho7ELf
 tOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=frW4XW7C9DTZGXxJUUdjq/QcCG5YG62CSZMprWf4x6Y=;
 b=PS3U9ETg4ZQV8vKE7I0rA92cvHvnlgzAET7qnZ9sba+ICFiJ2hzR8wVjd9VULhHxsP
 TOTLXS9ZAlRoHjfeXDPqGHAo5PvVoBzAM1oYOD/7u+RIve2hFzbdhIgBZJSEAoHBOMgk
 CbOHV/zaNL9coJCf37VGTvygXjOfOXzEbX72EpHmSW2ceiTORwtz5EqN4OSbIdLMwSSQ
 qyH8x7iLxm2ZymsLbkpH9PkFfQolUddSp7ns3ZLi8TKEuj63WHhDIoyPs5Ifw6CpO8Kz
 YSHKOcxhPCz/LSP/epN/4DElHoUcbx29hECbNCcnDKX4PMbfnrAbR2c8xdJIl0PHBkCp
 FMXw==
X-Gm-Message-State: APjAAAWd2WXOG73PMcRMjMwRw5fa5wci2ZgTzRl3ZURxO+bg/9I8x9vM
 QFtpc7bFbxCIaa9gHZYV0fzMGZUmT3ZG0vzJHbrJEw==
X-Google-Smtp-Source: APXvYqw/8DaRUbAlH1OLyRm7MmpRVV4z/mbvh9nJzQxlV4CcTNbdlcpWOCriwfMkzh2xaqBSGllBxCH7uBoDR5OuzRQ=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr375211oid.98.1582569739730;
 Mon, 24 Feb 2020 10:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20200224172846.13053-1-peter.maydell@linaro.org>
 <20200224172846.13053-4-peter.maydell@linaro.org>
 <60d47c82-1c7b-9e75-f4fd-fbf752092a82@linaro.org>
In-Reply-To: <60d47c82-1c7b-9e75-f4fd-fbf752092a82@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2020 18:42:08 +0000
Message-ID: <CAFEAcA-zDpucXU0fp+JerfhkOBEaHUZtv=05v_Zxuh0U8XTE_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: Implement v8.4-RCPC
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 18:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/24/20 9:28 AM, Peter Maydell wrote:
> > The v8.4-RCPC extension implements some new instructions:
> >  * LDAPUR, LDAPURB, LDAPURH, LDAPRSB, LDAPRSH, LDAPRSW
> >  * STLUR, STLURB, STLURH
> >
> > These are all in a new subgroup of encodings that sits below the
> > top-level "Loads and Stores" group in the Arm ARM.
> >
> > The STLUR* instructions have standard store-release semantics; the
> > LDAPUR* have Load-AcquirePC semantics, but (as with LDAPR*) we choose
> > to implement them as the slightly stronger Load-Acquire.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  target/arm/cpu.h           |  5 +++
> >  linux-user/elfload.c       |  1 +
> >  target/arm/cpu64.c         |  2 +-
> >  target/arm/translate-a64.c | 90 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 97 insertions(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I guess your memtag series will need to account for the extra
loads/stores added by this series, incidentally.

thanks
-- PMM

