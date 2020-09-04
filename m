Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB7EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB052074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNVwodEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB052074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBco-0003kO-8d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEBbr-0002pG-TB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:18:31 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEBbq-00035z-5b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:18:31 -0400
Received: by mail-ej1-x644.google.com with SMTP id z22so8544320ejl.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8PBpp64AyTbbvOpK0zSmEGg+kNFjvAvYIq9lRb/tbaI=;
 b=GNVwodEGEkxhBklzk+L+nz5DkqYTziBZT0qjO62yEplvCSTLGicKou4XMm041X7+v5
 MRUITqQ4RDLSTBKKPRf7Z79gmmhmbnhDWzg/lIRR7ffkBaWzVmY7his0/qUWKvVfg3o2
 T5rsfENdGn5mzwPs4xTY0d5wx4Jq4hCB1SCKAcxokkBYKxGryE07pqpnks4wcva1jZTJ
 roGjBpwRRfEd492/o4pwY400dcPfyjY2DXEhJvIgfRzb5ihWSzW7bwNZGpij4wWOVt1w
 g4YAqOOc8271JnklLW69iTq72cFWAOuzZkzgg261U24ckxAhzjN0HodfDlR4fO1mIDMv
 CaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8PBpp64AyTbbvOpK0zSmEGg+kNFjvAvYIq9lRb/tbaI=;
 b=pbCh+T4b273d9gK/xaiGJ9G6v3SVhYNFvwnzemyxKxaezNMSElAtRLkn6PNyn6ZAoV
 IYwqs0TD0RYvbMDGLpu+lkxEugoL8FW931cfUDY5pv2V1NRoQSYP/hdKYISmVo938HTI
 WTFAKWnmmG5x4/rEZAo4OFOxsGMpA+gB3vO6bky4apmDUeun2ksS4/jagbHZpdFOpGUv
 LG0rQXhZFYqZWVOVaf5Y6KivpMDABLe1QJdTJVfD13xdkDHcfYXvyYN5HFSdzvIFtqT4
 5uel4kOhV7ZQ2gL0uadzJ4YS0GcouLKnGf3+gwyEMjBJWyFetUuVAA1vhwg7x++kPfWZ
 6AVw==
X-Gm-Message-State: AOAM533UU9QXEIciIlqU8rmZcN0URYkpSunZeZY8XCa+8zibiUr11uDY
 lPevtMk2Eq/9BvJV5bekuuFKY8HwIcH8KENZXc+JrCdiUYADJw==
X-Google-Smtp-Source: ABdhPJyI/S5yzVVly7kH/dkNHyeiLCETdd8Me5LzYKzQuckWcMRIFsc/dJfZCTYth4XzJrH6Cy+A47S1oTH8si9v/00=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr2635302ejb.4.1599225508236; 
 Fri, 04 Sep 2020 06:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
In-Reply-To: <875z8t7kd0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 14:18:17 +0100
Message-ID: <CAFEAcA85r2fPMYfc_dy9njZPYD2ngx7Wsc228s=C-D7vj60PVg@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 14:16, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Convert qemu-ga-ref to rST format. This includes dropping
> > the plain-text, pdf and info format outputs for this document;
> > as with all our other Sphinx-based documentation, we provide
> > HTML and manpage only.
> >
> > The qemu-ga-ref.rst is somewhat more stripped down than
> > the .texi was, because we do not (currently) attempt to
> > generate indexes for the commands, events and data types
> > being documented.
>
> I'll miss the plain text output (I may get by with formatting the man
> output, but even if that works, it's still an extra step).  Others may
> miss the index.  Oh well, march of progress.

The index is definitely something I'd like to restore at some
later date (for all the manuals, not just this one).

thanks
-- PMM

