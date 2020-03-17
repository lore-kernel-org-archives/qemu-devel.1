Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE89C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8A920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4oTy5aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8A920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDqJ-0002dV-1b
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDor-0000gI-9h
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEDop-0007EI-P4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:07:48 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:39921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEDop-00079a-Gy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:07:47 -0400
Received: by mail-ot1-x32f.google.com with SMTP id r2so6538108otn.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C7Y4UJGLKwFelm6HlTF0wyLG/bfxpxmk307g3iM1ISI=;
 b=d4oTy5aTQ7kI3i5RR1G/dK6bFzGiO1gBScdqq2J/XZcikOnEALnDA8lDLXoLLbnBXG
 wJzmFKZAHvhf+AMiCxQGmyq2lkztFVyYGoMkAdVFYQXeYDb5B7Gp2CizjOxlwwnbxfYS
 BETcDvO2gixzSJ5QEiBLtw+mZ9BcGUzI7K/LxGbATZ1MBJrJKg+Qe1qHH0lYfLUVoxhp
 WXwl5YGevTWo4dkkTDwL9zPDfM3AhFUiLqdEp/VWpVQA4+uhguBX3M86hrda/X2tpnlp
 YFEZPvmYFtffejGE0vun8sjl+yeZn5hPok/bXXPwsG+uDYbPK1dgD5uZIFc1cn5GB0kL
 7myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C7Y4UJGLKwFelm6HlTF0wyLG/bfxpxmk307g3iM1ISI=;
 b=n9e5byZ9ZbKdU8mbRaxJ0uJ1hdK/FXKiwoR46t1Fd00q1p7Y4bzNF48WdM1BRU2vde
 oihalRPnynkn/6zfiTy3Yo26vLmzUfF3WpuvoZmL2LNm7e58k9iUmRDn2HxjtmyP21FY
 s65kDyp2beCz7YAit7lkWSkOEmaU8TShfJ332sEy/9SFabPA1a+pEQSJjnvrIzVpeXt3
 2bSeden2ncfL91XNN81YNwR7lxy0BLSvwlQKndTQYS4U7Vwvwzg67FPHMeph+Vi4n2LI
 F2UxKZGRMYe2LQHHoDF48laJFBbeD+kLlznwylS6r+0X8H7pDWo9jliF3xWWkzUoYHjg
 /pSw==
X-Gm-Message-State: ANhLgQ34bRDa7/22NdpWjYpTIj7mSV2hCG6ke5mGiTAa5R0SjLVKO4y3
 SwENvpv2BGka1Ml/nEyYLUxgnlfKkGzPquZ5d1kHBw==
X-Google-Smtp-Source: ADFU+vsflQdwfBOmcNngY5g9Hzi8MxNNOxpmkIJ8h27l1doV8wK1Zc/T6GXj1Yhd6WTK4aM0oPQXnwVgjH0vvoihWmo=
X-Received: by 2002:a9d:19ca:: with SMTP id k68mr4114688otk.232.1584457665736; 
 Tue, 17 Mar 2020 08:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
 <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
 <20200317145703.GH2041016@redhat.com>
 <CAFEAcA9-YLNcZPPsHsdLB0O2Ac4WKPspMe=Re2S7tyTZu=kwFA@mail.gmail.com>
 <20200317150528.GK2041016@redhat.com>
In-Reply-To: <20200317150528.GK2041016@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 15:07:34 +0000
Message-ID: <CAFEAcA_pLvupGhgeuevVBxhNz-NVkKWOUrr=nJaPAEKquHaqxw@mail.gmail.com>
Subject: Re: [PULL 00/10] Bitmaps patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 15:05, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Mar 17, 2020 at 03:00:48PM +0000, Peter Maydell wrote:
> > On Tue, 17 Mar 2020 at 14:57, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > I don't feel like -Wno-unused-function looses anything significant, a=
s
> > > the GCC builds will still be reporting unused functions which will
> > > catch majority of cases.
> >
> > The most interesting difference is that clang will catch unused
> > static inline functions which gcc does not.
>
> That's mostly just about dead code cruft detection IIUC. That code won't
> make it into the binary if it isn't used.

Indeed, but it's nice to have the dead code cruft detection. You
can always mark the function as __attribute__((unused)) if you really
mean that it might be present but not used.

thanks
-- PMM

