Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4EC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9E820693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELN4wu/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9E820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO89-0006MJ-Mk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35897)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnO80-0005xa-2c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnO7z-0001WT-2y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:08:24 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:37017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnO7y-0001W0-Tf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:08:23 -0400
Received: by mail-ot1-x333.google.com with SMTP id s20so21195615otp.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nHMPPhphvwsZvMd4/2q9JvxTSMEyvXwDVB2Boelqu8k=;
 b=ELN4wu/sffC822kFowGebrNTo8lAjg5tUTDfmRmoGrmHIFXV4l2dQJ6UqEZaCWbenC
 bolaolPvAEhE0vo+XRC8urIrvTmbpApJfd+wcUzZtuZjb7YkgQG45E0ygdJbwRvA9AIy
 w6mNPaC95Dt3C7bhDwBJBRisRGPB+YKcspe2A9wj1DyIboIyfR5T5kwZTbvhyq01ebjl
 salckazNIQ3BCgpYuCBHdIprp9wk8FwRl2Jj/Fw8plooBRlkFYwYKDUa/6UIcZ4SIlGm
 Ac/RskJ75/L4/5BsI1zTaI9qN3u4eTDc/1AgTNBBxEg5w0yvFOMiHligDMhT6ftz0NDt
 rWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHMPPhphvwsZvMd4/2q9JvxTSMEyvXwDVB2Boelqu8k=;
 b=XsiiqdeaIdbws8BQZqr6FgkJancEuawbgmS7ZX34KS/2ALvn5G69QO/59ykabWJUOH
 qzaXhEoSXnZ/QVQsz6LJvguLKCjFcTf9yZJYxX4f/AoOsA4JndUvOcC/S1BDrqH4oAne
 rbl0oD9D3JmSQP5uSRef2Cyo7bTXE/J3tm/HmIsSmb3vIypBRpX7Aydg2qEPVuUVw57e
 XgoqrGSlYNQjPY/ET0Q/pBBz0qiuBgoiPNaUDnHgrOLR7QvBFCJLz/6U986v0UHQD4zA
 kKfVPiJPGFjQFONOcPAbSXQSMNvKwnlLKYVgiyMD28Df4jKq1wHNBfSYwmKzchkldUaS
 cVYw==
X-Gm-Message-State: APjAAAWWQL3beXHkhn+0qqGzges1RaNSedccxKxTT0V5CCaHSk9WiySa
 Yz1h81OT0+XCZIk0PnrcHCc2DhYAhZrcgU9WxDq3cA==
X-Google-Smtp-Source: APXvYqz1BomGnURzrvBkRPezDFJ33fLTPZSBCQuWnkN4jNXdP8mfUdOUJB6/aJeqHmpcoWyjkz4QIV9R1yzzxAfTU2Q=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr20148790otn.135.1563286101780; 
 Tue, 16 Jul 2019 07:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190716045141.21383-1-armbru@redhat.com>
In-Reply-To: <20190716045141.21383-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 15:08:10 +0100
Message-ID: <CAFEAcA9Fn6n3MTH5PNwF2HNOP2Yc1AHMP-sEe9EKdffxMwVTOA@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL 0/3] Build system and documentation patches
 for 2019-07-15
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

On Tue, 16 Jul 2019 at 05:52, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 5ea8ec2fcf57cb9af24ad2cf17b4d64adb03afdf:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-07-15' into staging (2019-07-15 16:11:47 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-build-2019-07-15
>
> for you to fetch changes up to 32481687e1a262a9ca0083f8e938d7b0614d823b:
>
>   qemu-tech: Fix dangling @menu entries (2019-07-15 21:10:29 +0200)
>
> ----------------------------------------------------------------
> Build system and documentation patches for 2019-07-15
>
> ----------------------------------------------------------------
> Markus Armbruster (3):
>       Makefile: Fix "make install" when "make all" needs work
>       Makefile: Fix missing dependency of on qemu-tech.texi
>       qemu-tech: Fix dangling @menu entries


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

