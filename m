Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5582CC35DF9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2961C246B2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIWgLmBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961C246B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7NiN-00024N-AP
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7NhZ-0001bf-Lz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7NhY-0002Fk-8w
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:16:01 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7NhY-0002Dn-2E
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:16:00 -0500
Received: by mail-ot1-x335.google.com with SMTP id j16so93220otl.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ni1VCTUxXgtW8KqKkmDxtDKEArzNLpHUEJko5CgOnCY=;
 b=sIWgLmBvMDs3QOo+xUukc9i6/5YG4/NrS5iqMCKNKQ2VmZ9R/fA3eYy56uFNaoiAyg
 3kSJ9F/WF95+Ux3Ou6ivuInh957spJgECSwL1YeC4ncccwSHuVnq2UBxO3oibXbxcprk
 WO6L9n89JYu8ohrL80XXTKhaLv2RGQmR9HmhUeYpKBWS+iP4tTLpeIXS9SqduQ8ezREs
 UGqaMkkK9gtLP3dRo6F8mloMtExyIwo6yWLe1ttatxrYWKTwj7mhvGRMaYl1rgyhvuYj
 rn0Q7tIx/FqSMCITxD6VgJaTxehSBVkOKS1wATFAegHmLPhKHMj0GLqh1ww5PVkr5i4Z
 THug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ni1VCTUxXgtW8KqKkmDxtDKEArzNLpHUEJko5CgOnCY=;
 b=paZASUtSFGmCAlKbBbqjHdEVIbW9ha4TctT7hHlsK7GiF3FUQnDmLpz7rx7saSG2Ah
 CYSC36tMH7GEg5XJnE4reJPvK3Lk8EbOFafEdPNUsh0UPMvErYXV9kB41eZnjpXsrTM+
 wtPRX4GxCHrDfj7SafIWOrUyywIksDvKdBjhp4R/13riB9lywJyk/Pg+EGrGzX3jV7Sr
 rMqCBaoDUUzR/lzwI5FgHVNGBnPu2YvROL/P0bbHPcj6gMftPwliOQG5+k0eIbNf7s15
 i6qFVdx/IXQVgpI1zHa2Ai89Q333Sy/wiDs3eokqRZyJS/VmTWFRMEDhmVTX2gb5wYwM
 yCFA==
X-Gm-Message-State: APjAAAU61n86sM6gExVlmgBabaneYojpVnw+ommUlqNantO63LARO4Wb
 QNmrt9z3rl1MuJLhcACuE8X4viR3dp0swEtMkILqRg==
X-Google-Smtp-Source: APXvYqzqjqd3TBxNZB5Usy0pmUKXHkliAq+KXDJDxF1nsVBe6/HC4e0m2g/4V7UAMLLz5FcyhLYCKuahZ0e/7u3xS6M=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr165050ota.232.1582827359200; 
 Thu, 27 Feb 2020 10:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20200226073929.28237-1-alex.bennee@linaro.org>
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 18:15:48 +0000
Message-ID: <CAFEAcA_uwpVdCRuUhoNmzQ0F4STmRLYvU1LZVJsPBuW8WZeBxA@mail.gmail.com>
Subject: Re: [PULL 00/19] testing and plugin updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 07:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b8=
37:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2020-02-25 13:31:16 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-plugins-25022=
0-1
>
> for you to fetch changes up to bc97f9f64f8a4a84d0d06949749e9dbec143b9f5:
>
>   tests/tcg: take into account expected clashes pauth-4 (2020-02-25 20:20=
:23 +0000)
>
> ----------------------------------------------------------------
> Testing and plugin updates:
>
>  - fix pauth TCG tests
>  - tweak away rcutorture failures
>  - various Travis updates
>  - relax iotest size check a little
>  - fix for -trace/-D clash
>  - fix cross compile detection for tcg tests
>  - document plugin query lifetime
>  - fix missing break in plugin core
>  - fix some plugin warnings
>  - better progressive instruction decode
>  - avoid trampling vaddr in plugins
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

