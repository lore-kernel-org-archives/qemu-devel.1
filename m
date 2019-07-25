Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5887CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258F32238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkuXyu1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258F32238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqa2Y-000385-AT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37959)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqa2K-0002jX-P6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqa2J-0000yc-P5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:27:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqa2J-0000y4-Hp
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:27:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so50982492oth.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oW9HTUxPdaBc0SPZFgaxmXQGTaC3Jvw7MCiIJIDfpgU=;
 b=zkuXyu1DFiJi+AZi+urpQj49lzTS9FBGKa32vyPVa/HXVBfzfZjFnTFeJ1OC+bHmwP
 akEJY4JlgX2ZAsp9oSfcSEmWjcIvQsnhD11xxFNJ7FxN9KqPgMVGU8AsSN3yKBUWnMgD
 sCBrR1FhWNjRYYg1QcC71WNYvPUUQhaBKm2iqXh7cJbmL3KCVdPJ+O+boEEbakj8i8KE
 LRFh/fL3H6Y62OF+TtUApcdKyCedInD2urUWKA/6Ndiq5+G4qvYKkGht6cBgEqMtBDO3
 iCzB0pIn/oGQhQhq6qUHzarb5y3gk81Rr08aV1jlZOrGRTdi3YdLKlFIT8LX1XWtD+X2
 6jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oW9HTUxPdaBc0SPZFgaxmXQGTaC3Jvw7MCiIJIDfpgU=;
 b=drKXAGIwfLyj6R+NtpMHuT4jTTp60uHqQPnFJQGvsX40y1zv/s07xqmCRzPiNjJlVN
 ZVE3HLyteyOWozNvOj4qfzmVa+1tjdmOhWYW87le62Jz5kMaj39miymsVt2QusI8hEA8
 UBOdvZ2CP+zmABQaWZs9nAmwn9eRCDFbBeH91k7deG+hg+ryI0q30QdmNHVXmw2ppKGP
 1Ndr4KfNqN0KWXuQiEgkoQNXNLT8HrDdHXj3CgMnJK8cJ8ub4nd0e3QhmlIXzk9mzigK
 C36V5lw+ELNfnpWJvgqlmjIdhSMvClOjaQiH8X2H6EQL8wf/8E1RJsrBqz/AjcXXHolW
 0gtw==
X-Gm-Message-State: APjAAAXAgnBWqK209/2eMZePcunq+pGplqmxNo4RccWl4LfmjzO8PyRS
 nfiQ0ccxSt0BUWPkwclEsiVFrmEpjwi3vCpfTZEG7g==
X-Google-Smtp-Source: APXvYqyT1qjtOJWulraYr3SrKlYOzr1MAssDId6u2f69gZsY5fhs8Dwiv6Chpw+pKdGrXJiDWY4hkpkBW0uJ6/s7L4U=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr9316199otr.232.1564046862055; 
 Thu, 25 Jul 2019 02:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190722171828.11322-1-chen.zhang@intel.com>
 <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78061D67D3@shsmsx102.ccr.corp.intel.com>
 <599f9e75-3d85-c1e7-fe6b-34c95d9d240c@redhat.com>
In-Reply-To: <599f9e75-3d85-c1e7-fe6b-34c95d9d240c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 10:27:31 +0100
Message-ID: <CAFEAcA-cjP6-T4JOVGu2PvNNscvrPo1RAxWwRM4iA4ufSYBaDQ@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 04:24, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/7/23 =E4=B8=8A=E5=8D=882:38, Zhang, Chen wrote:
> >
> >
> >> -----Original Message-----
> >> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> >> Sent: Tuesday, July 23, 2019 1:25 AM
> >> To: Zhang, Chen <chen.zhang@intel.com>
> >> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat=
.com>;
> >> qemu-dev <qemu-devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
> >> Subject: Re: [PATCH V5] net/colo-compare.c: Fix memory leak and code s=
tyle
> >> issue.
> >>
> >> On Mon, 22 Jul 2019 at 18:23, Zhang Chen <chen.zhang@intel.com> wrote:
> >>> From: Zhang Chen <chen.zhang@intel.com>
> >>>
> >>> This patch to fix the origin "char *data" memory leak, code style
> >>> issue and add necessary check here.
> >>> Reported-by: Coverity (CID 1402785)
> >>>
> >>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> >>> ---
> >>>   net/colo-compare.c | 27 ++++++++++++++++++++-------
> >>>   1 file changed, 20 insertions(+), 7 deletions(-)
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >>
> >> Thanks for your patience in sending out all these versions as we worke=
d
> >> through the code review process.
> > Thank you too~
> > Maybe you or Jason can pick up this patch?

> Applied.

Thanks. This is now our last outstanding coverity issue --
are you planning to send this in for rc3 ?

-- PMM

