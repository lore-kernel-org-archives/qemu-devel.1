Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178A7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C53A20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyVwlhFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C53A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQkl-00059r-Jo
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQhG-0001Mm-CM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:49:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:35983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQhE-0005F5-Ct
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:49:21 -0400
Received: by mail-ej1-x632.google.com with SMTP id e23so10021106eja.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cUHk8Bdi8Ag3iFp0zcXGCQZn0jxTpQTOWmcZys11+sA=;
 b=gyVwlhFz/Nz6V+z6Mn7JW3qf0smnDY4SPMCgj66NGzq3gbXCHwGprpjoCDuVXyahfl
 3YeWlITQezivhCaGpQs9HvFBWM87BMAhMp8dRKALg3MuzK9OPB+McDt4gvl0XFvKxjHQ
 fJL6B/i3YnBhFhqq//EF0WzE+pGvyMx7tdKhKQs/EFsuBTssEXU39C2HjvEGKymv7e44
 lpK4KlmJIe6bnAiEOKqVJ4ZUUznzgBYXo86qxqVEhgoVgmio1ErDRlU9lzu1lferR7Gj
 vmZUaj3EY33kj6xIArEFAcgn4T5gTLK99puCnLa8slovgEXlrRz9TmzwRUcbI1OlM1NG
 q5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cUHk8Bdi8Ag3iFp0zcXGCQZn0jxTpQTOWmcZys11+sA=;
 b=IkLBW7ucfNeEkK0/tMgqUozp+hwPYezCYRSILvMnsj3rit5j9w/tX8y/3TUZ41OcDA
 4ZartX/OlnvT518IgnsDEwYbGCjWKOJqjgObFpz6G/sWdqmZZ6NK2NDJDUi/RGCBsHZp
 FrL2gfWETxft4jwnkC7GM3Q0ZAOm/Mrt2hjlL9kAUku0CktN+HPqpsqLXmxT63oHlEoy
 mh4HYlvbRPmPo2vNjTlFBDMmU3XcukXTgjUPDEObWedZLqx8nGvgDhx7CdTvah1tjFqV
 KawyyA+KLis7lvm8mKDqMfdkrlBBngK/NjLwOACDfXnNXluI+MU1cjTD9BjsTl6B7xak
 ZIUQ==
X-Gm-Message-State: AOAM531vKmsN4iIZN1NY5ASHQT02qAyB9NKue66pvOhpRcuujQHQUfA/
 T+Zo+/syRUuJRWd4dVgqWF5UjZ98R61j16hxDtZb+w==
X-Google-Smtp-Source: ABdhPJw6hGXUNla+jT0SxR5+AgPqQdsVC4zm+KvUu56ojfPjrlKnDaWjWXae1YDjkbD5IpTovmlm5k7siaCnceL8IGI=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr10100199ejb.4.1599760158382; 
 Thu, 10 Sep 2020 10:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoBWHwtE+HWkoj3a2pdYHOkPpG7ya=+-RRFvUp-SXwuTWvm5g@mail.gmail.com>
 <CAFEAcA8spQVin2vj2V5DJYQCR_BizqrRneoRMKhqKAzFv8EiMg@mail.gmail.com>
 <20200910174346.6y24jkyd7ca4xuoz@kamzik.brq.redhat.com>
In-Reply-To: <20200910174346.6y24jkyd7ca4xuoz@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 18:49:07 +0100
Message-ID: <CAFEAcA8OszXLXPNsRt68pQQ6SQVG+-PYduOqGpodqKk+fi6rqA@mail.gmail.com>
Subject: Re: Master cannot execute MTE instructions
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
Cc: Derrick McKee <derrick.mckee@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 18:43, Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Sep 10, 2020 at 05:17:17PM +0100, Peter Maydell wrote:
> > What QEMU command line are you using to run this?
> > In particular, MTE is not enabled by default, so you need
> > "-cpu max,mte=on" or similar, is not enabled for any
> > board except 'virt', and doesn't work with KVM, only TCG.
>
> Actually I think the 'max' cpu type has it enabled by default, but you
> need '-machine virt,mte=on' for it to work.

Oops, yeah -- I remembered we disabled it by default somewhere
but forgot where the enable was.

thanks
-- PMM

