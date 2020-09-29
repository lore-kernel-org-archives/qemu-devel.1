Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E8C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE53A206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKdgir/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE53A206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBRe-0001sH-Hg
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBQW-0000ix-Et
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:00 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNBQU-0000Co-Dt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:00 -0400
Received: by mail-ej1-x643.google.com with SMTP id nw23so13897480ejb.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5ji1dTE1I97brwx0qpiobtzBbzL3U5aVsJ6aTbj8YFo=;
 b=rKdgir/zhFv9y/qT7X2Mw29dgqw659FVW7a2NGVJPQ9h2Vmf/MnnKXDUvBYEKoI7FJ
 90+i2cnepAiX3arejXs2zcETaFdpEg0w4tdrSMhWeHPlc6bI2q8aV5oDaBXTxP08pBcx
 x8iV+uCTSbTf5KE5ElIvc5RiBXuxTVq2+EK8p7LgbHR4J8penujuZKfgsNFaL6OBfric
 OrNEiluK5kHk8G77F459MmbNgBoenXlNqlSKhCQQZKld6tDefIATjMOiKH52MAQTqrb5
 h0DK8NVR2oaDHIEv5GdE6cMbuGlbtE6MzXqyaEISsxAKLl8uTTvlOEIwxOWJou+erT1z
 ZUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5ji1dTE1I97brwx0qpiobtzBbzL3U5aVsJ6aTbj8YFo=;
 b=IpQZmT+5OORfIi2wihPajO8FBPzWOZinpiGPZVW3rOM1CH5F/vybFxEkhaHAcEe9+s
 06qd5S1akdFR7wDD2PLDC1ehtgOmKK9eOAAG+vxIoCtrzEY2JE521O9vqET+KQp7gedc
 crk1weBsWCdKz3RqxfcKw0Vf68Uubic6eoUTTn8UQrf7ZoKRr2ExVkjZq8m534PEWOma
 1f7I2aB98rUcUWjQ2FWwBk+3/+Ioa8/7TWhnK3L8SKsxn7gMSdNZXYrj/n7cBZFSiHar
 /i5/NjJTV7te2IfKOGQnmXQu1wp4p9EpCJiV1uIHFjL/cMRuWK8BIy+YodKNGhO6ouRF
 cOuw==
X-Gm-Message-State: AOAM531rF70Hb25MQObscbaEgGGXpbouYvLV6drAm86t3JZc9V/cXMQ5
 4YRawsLniPWi9LVcIst9Rrg/XEtX5a9khTUoh+UOuQ==
X-Google-Smtp-Source: ABdhPJw+h9fIOuCsg1nrZL+aMvnNnH0b/OtGYD2yB61YxWbMC3JHpiw8nqHgWiwXmzNn7+8i+Y3PG2ll/DCAjPSNgho=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr2706731ejk.407.1601369756450; 
 Tue, 29 Sep 2020 01:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-6-peter.maydell@linaro.org>
 <874knhbtm8.fsf@dusky.pond.sub.org>
In-Reply-To: <874knhbtm8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 09:55:45 +0100
Message-ID: <CAFEAcA94vOAbk_SkRZwyp3GsyknzWQ9GkvVPKYzW2MSL3KO2Pg@mail.gmail.com>
Subject: Re: [PATCH v6 05/21] scripts/qapi/parser.py: improve doc comment
 indent handling
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 20:16, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > +Descriptions of arguments can span multiple lines. The description
> > +text can start on the line following the '@argname:', in which case
> > +it must not be indented at all. It can also start on the same line
> > +as the '@argname:'. In this case if it spans multiple lines then
> > +second and subsequent lines must be indented to line up with the
> > +first character of the first line of the description:
>
> Please put two spaces after sentence-ending punctuation, for local
> consistency, and to keep Emacs sentence commands working.

Is there a python lint program that can auto-check this?
Otherwise I am going to continue to put single-spaces at
least some of the time, because that's the way I write all
the other English text I write...

> Can touch this up in my tree, of course.

That would certainly be easier for me :-)

thanks
-- PMM

