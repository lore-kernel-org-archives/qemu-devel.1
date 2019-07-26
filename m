Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F6C41514
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B4E229F3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ox70SePT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B4E229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvtR-0003l1-R0
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35102)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqvtF-0003Mc-0q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqvtD-0002Dg-2z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:47:47 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqvtC-00026G-Pg
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:47:46 -0400
Received: by mail-ot1-x341.google.com with SMTP id s20so54582047otp.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gtdn1fD4cI8QtI0wMIK5kEuem9S+JqfXC8U4yoaa6FU=;
 b=Ox70SePTCu4wm3EzTY5qI7jt8yBvG8I6awGHhs1WXyxvUXQvGZK4kcPmG2byTe7od5
 xrvRvSmAKksH66BkTMrcSmlHPZH7B9kHqSD1ndMvqxjFnuR+GQE1u9ysG6eZliOpDCwi
 6l/swi6qxQsn7LMO3vFDePlc97K0E/aWjb3aTYmBEASsMd/h4ng7ZZ/OmNGWbQtHlc5V
 NXKmPuEv19c3pwhlD8tMjUZMnGIMi4rIm/UiChAKXUUTQkrwK/m0eqZfyjJZuMoBClEV
 KvGjfvjKsj1j0R47QMqSzkGHdmCq8IvaPJQuwOPwpS+MhbylQpk6ybTjnLIRLamIeF7Y
 +00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gtdn1fD4cI8QtI0wMIK5kEuem9S+JqfXC8U4yoaa6FU=;
 b=m8SU0xmtAPoLamcrU4dMTkZhXbCIcLSyKt7VFaQ3KzA7Pt1GO78YOsI/Kwrfj+4TuD
 hNbZ+LOx4oTvyndnPrfGRaX9ikF9rjYcALGM+b8dzBYAB7H0FXK6f/xs+S0lEz/vRFpf
 BPkjylkbDEBBC5MxuRXIG3QWasZ4SrKXAKcdid5Gy62D6fVwLIryUQLTlClQqQ8E6Egf
 1dJGjkSZu25BW/iXaKFP3xNAo6Jnnv+VFxCnEbaWZDgUgRFv2T9pQivAh3g+FdLqx+56
 QMB0KunVetRc/8GBAyRNgMbOb7OuqtiFykp58B3Wc+W5ARKvzhFVS57u7DFIpU1DgWYx
 XGZg==
X-Gm-Message-State: APjAAAVcmvImWcg+bb8sC+mKdoZsYR7HzNhnMF1JuckiXG73W9PRjL8L
 HvvkKls5l6J92YadKzwi9PPZnvxka1OPchC5f8OEUQ==
X-Google-Smtp-Source: APXvYqzskghLVrFe8hQzs2w3NoI1G11DZOgUMFoEHcQQrCF2Ye7ZfgTw2iX6Zp5YSpQ7vbnr0AtEaCZ1aKJK2PM98Ag=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr13801663otr.232.1564130851631; 
 Fri, 26 Jul 2019 01:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
 <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
 <9631a4e2-80da-9369-038a-45f3b0399bc4@greensocs.com>
In-Reply-To: <9631a4e2-80da-9369-038a-45f3b0399bc4@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 09:47:20 +0100
Message-ID: <CAFEAcA-qv5NF+bOyiQ42+7=BHZnfkXn-tq8V=ao58uXTapooZA@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 09:25, Damien Hedde <damien.hedde@greensocs.com> wrote:
> On 7/25/19 7:59 PM, Peter Maydell wrote:
> > As an aside, I'm surprised also the macro doesn't complain
> > that we said the num_buttons field is int32 but it's really "int"...
> > arguably a different kind of missing type check.
>
> We would need to compile on a host with int size not being 32bit to
> catch this kind of problem I think.

I was under the impression we did catch attempts to use "int" with the
VMSTATE_INT32() macro, but we do apply the type-checking magic to
the 'value' fields in the VARRAY macros, so I guess I'm misremembering.

thanks
-- PMM

