Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77271C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C60D20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHTY5CeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C60D20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7ox-0004sD-Fp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7o2-0004A9-UV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:22:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl7o1-000676-H9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:22:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id d4so1020446otk.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=evxvWdLGySiDb4ijImDiRjoXKAGoZTla3vJnx4JycZ4=;
 b=ZHTY5CeCYyBYekI3ELVWSR2rCOZKoC+CKzWdLsMuvl9WPpXVl13OCNPmcyJVimZf/4
 84AqafepIlsb5urNLPJ2SxOmnySlo1FTEtKw0HifnK8saFOowiM1dknY8CcpXFz0yziO
 roG6knETh5AHLq57uRWxysgIMDilPgBNptcbRk/Y02mHDTKNnop9JmjdrTy55TyavEkz
 S/3GD0QBzwpAEztrWzsY+gi1bMrFU2zSMHn6Vc6uzhfkPv3Rc1PSrIitXyT9Xst/19ze
 0bt+J14hwD6Tug+SgqcgB8QS50Xg/OoY9K431pNoMbWsk9nV4z+XlWNXiKB0W3nU+Sns
 2juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=evxvWdLGySiDb4ijImDiRjoXKAGoZTla3vJnx4JycZ4=;
 b=fVHktkoqZLBrTMHGQgw4aTZ4tujXZEy5RuuosEgt/vE9Qg9Jy9PrfmPVW9PpQL4IuA
 hDkCyC1u+IXpl2+Y5FpzFVnf0a+enVB/U1o2llHh3Rf0oLvaXJhfiB+pcVBCqdv41U94
 zjCEygehTzud8MFy9Ze4l9GfWsDICGKQvQaPN2NlY3URQHhbW7/vTxFxXXwBChMR3k3B
 qDyX6dWFuYa8RVi16AzjeBchllRw0dn+H2y8W7YI66XP8xqrSSQjqBI2Wzzh+0QyGorr
 Po14+hDtDLL27ELJdV3/ckQNOBFgaqVSZYp9NjrdV7Tblyydfyalj5Klv2IwS0tstF0A
 0iPQ==
X-Gm-Message-State: AOAM5335Dw6hztDpCQAmY+wlVlRxEq+2SKkFvjuTZO+c3ll3j54w6YNw
 6CIPDJv+ncX/Hc2KkHx8GB3mab+RLpm2We/TxJF6aw==
X-Google-Smtp-Source: ABdhPJznaFc2phNW440Ak7xBQ1NgO04/pWbdU9fZWz6qnsHjzAdEJe2e+tW2U6RZfGUL6vrF+oXqi39WLktOrRjjzx8=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr1645786oto.91.1592299376022; 
 Tue, 16 Jun 2020 02:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200529112757.32235-1-beata.michalska@linaro.org>
 <20200529112757.32235-2-beata.michalska@linaro.org>
 <20200616083337.yfgc4cyad4ipaqb7@kamzik.brq.redhat.com>
In-Reply-To: <20200616083337.yfgc4cyad4ipaqb7@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 10:22:44 +0100
Message-ID: <CAFEAcA8uX-CCSac8tQ6=pzeDtZWxCvA=DuoV9ZhT_OJVHXfdqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 09:33, Andrew Jones <drjones@redhat.com> wrote:
>
> Hi Beata,
>
> I see Peter just picked this up, so I'm a bit late getting to it. I do
> have a couple comments below though.

I'll drop it from my queue again for the moment, then.

thanks
-- PMM

