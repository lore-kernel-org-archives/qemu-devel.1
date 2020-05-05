Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5394BC47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E9C20675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uyz6ifQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E9C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyO9-000895-8S
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVyMm-00073t-FI
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:16:12 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVyMl-0004VR-BX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:16:12 -0400
Received: by mail-oi1-x243.google.com with SMTP id o7so2074631oif.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FO6j0tdOBGbCldNYC2to060b33zQJqWyOuJmsJWQQuc=;
 b=Uyz6ifQoOgr3d9YPURi42/JGu6E/EgjsTYogHtkXhl03ISzFlHfnXjmqqHaqaX6O7p
 Oxgq7ACARgtr0hWABTLh1DlsVAlIRgswSq675ywBHMW31XKItT+KGdvDrae8E9KQW55/
 JxkieBq3qU5/S94W5YxdF4VT2JRiobXaDPdl0wCaP0Rj0Ttzv58mnsaKS7Xa/VEh97G/
 JH1SJK0oQw41exLcCq/5bpe8e0He1Eek/q2nD2/UvddD0oC3BhaT9eVOmwZ5f6Sqg0EK
 Qcv49xK2fb13I/GeJMCgbjSlubzb7Z0fJAQBO55sUKP7P1DsK8wS4cZp3DGkbyuM8Enh
 HQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FO6j0tdOBGbCldNYC2to060b33zQJqWyOuJmsJWQQuc=;
 b=LEUSOacx52z6TqlSrr2STeaaJ9Pox0/jkDn9EPukjCnjBsi+SF/18EOvW0pGWi9YHd
 cXYidRh37QNVhsP18QF5FlHyypKKurdCkOLd+i+TByVVxbM7zwDmd+jwT6kbj7ISsxJu
 tnRq46hwziKP7xEcAJYfax+LWza7sGa2AhNQvrSas49gss5E5VUyv1T02gQ17UCoRA9+
 Q/4wU1HXBu8SHJbD1HlFY6cK372XB1HHoDv10eLQe1MwTYW+2YHHMvbYtBkuiSuez9Ax
 z7HWkXkj0jhKE3kkdfFKB/OTFrhw1pQlCq1y9crC7r2wJoysfNaBQYyapUiw+AAcCHAQ
 Ma3A==
X-Gm-Message-State: AGi0PubwX12lUKZ4KLGMDv1bwF4Ko6b6aDt0FUHxi/Zeodkt3AGBWC6a
 p9neD/0THHEBbVx/GXyeGhhy/SAWdxzVFa2bUjQE7A==
X-Google-Smtp-Source: APiQypKZ5Fjkac9rEr75czoq1X515/vm98HCfEgxRpk5QD4WiJhBwWZKieOS9jWL2thZbe/9VjcUYNFW9xqpzk9LZxw=
X-Received: by 2002:aca:895:: with SMTP id 143mr2553576oii.163.1588688169426; 
 Tue, 05 May 2020 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162813.17671-1-richard.henderson@linaro.org>
 <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
 <20e6093b-edcb-c0e4-f4d5-b6ff4d51783c@linaro.org>
 <CAFEAcA-uupuSni8yqs6evWbjZDZyToit6Hhn8nQ=oSWjRuJjgQ@mail.gmail.com>
 <a55cb2a3-9018-2288-bfe9-2fa3c2bf0050@linaro.org>
In-Reply-To: <a55cb2a3-9018-2288-bfe9-2fa3c2bf0050@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 15:15:57 +0100
Message-ID: <CAFEAcA8s-YcfTFDDh+ht5HYQUjg0cyPODXb5ereBikufjQViiA@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 15:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/5/20 2:49 AM, Peter Maydell wrote:
> > On Mon, 4 May 2020 at 17:03, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 5/4/20 2:43 AM, Peter Maydell wrote:
> >>> I've reviewed patch 13, but I still don't understand why you've
> >>> made the size-related changes in patch 4, so I've continued
> >>> our conversation in the thread on the v3 version of that patch.
> >>
> >> I've changed that here in v4.  Please have another look at this one.
> >
> > The page_check_range() call still seems to be passing a fixed
> > size of '1' ?
>
> We only need to validate one page, so validating one byte on the page is
> sufficient.  The size argument to page_check_range is so that it can validate
> multiple pages at a time.

Yes, but why *change* what we're doing? If the patch doesn't
change details like this then I can review it by looking at
it as a code refactor. If it changes this sort of thing then
now I have to look into the details of what exactly page_check_range()
is doing and whether it's possible to get here for an access
that crosses a page boundary, and the review job gets harder.

If passing 1 rather than the actual size we have is the right
thing, then split that into its own patch with its own commit
message that can explain why it needs to be changed. If
it doesn't matter whether we pass 1 or size, then please don't
change it in a refactoring patch.

thanks
-- PMM

