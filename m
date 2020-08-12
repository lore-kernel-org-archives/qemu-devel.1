Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFE72078B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6Jc9idA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFE72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5v1s-0005Rc-0P
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k5ui4-0006TC-Vl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:38:45 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k5uhu-0003V2-SE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:38:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id o5so1417383pgb.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HWMeYlelru6nIOlCg7H8kkg2dwZuhbaCw7gaGt6dzaQ=;
 b=V6Jc9idAo3A1qnevE2Yf+59XCbfx/XdmKxPErhYIM8+nrc9owNxrC2R7E/HtNFKEus
 RSQOTf+qSdh8J/9bT68+qTv+dEQELa87SgbBPMJRefvUcT3QDeawlJc1Y4zuJiTNlIhu
 j0I599ItyyOByZ9Ch27CKnRbfl9xppXi42s7yFnqKc4fU7HWmnaPqYySElMidFxFXy8+
 oOz3frgBvtm1e0Y8+Mprs7mcOYCfgUP/+htPQWMmK0ZXG8LFR0egwfaGqMf15WwaeZwV
 nhzFevaqoYud9JVjAU27K3bG2d5PP0SAkXqs99EGrmaau2yEruZwRUfiylOKjXax2fKM
 WG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HWMeYlelru6nIOlCg7H8kkg2dwZuhbaCw7gaGt6dzaQ=;
 b=JBXwWeLpeqNFJdY6RX9b3K/kg1fKM+ACSiVmjeMYBALt6C1P0tZ8qES4wAwlqhdUrE
 MQ6fT68B4XhwBKxzLl+imf9NwA5PdUVxIgBO+9Ag092Ww2tVmZkc+iZf2+xRQR9jBMeJ
 5JD61CcDgnNhr4RornnePaF369tf9/mBMq8gkYKKsBEVgjuK+s5Id96eUkd+odVY5vIl
 8crgLZj/bvfdpQjsPMUwgD4Z81IcYHLeyPNaAHkuS+KneZatX4LpKW2DdVWOMRTkaxmc
 j2pOuNzF4jzeZENp1r24pcz2+BNaGskPZvT53JtYAJbQTgl6sl90G0fCqLawlsw4DJBr
 NrAw==
X-Gm-Message-State: AOAM530Be+Jk8Itp7oIUW+HYVnlpBPfPAEWphhLdV0SiApTpHWRs9zKH
 LBwipBjN1RXSL3EcNuzIaZPTSgNq0z3SMf2oJnfuhg==
X-Google-Smtp-Source: ABdhPJw+OWsy97migmGsNRKVaOhK7JT4cO0WDoLxqQJOtp9RscVfQfaxA9J4LLrosfi51B+Lqp/JfrYS6bZ68BKOWCo=
X-Received: by 2002:a63:af51:: with SMTP id s17mr241068pgo.286.1597253908761; 
 Wed, 12 Aug 2020 10:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
In-Reply-To: <20200812171946.2044791-1-richard.henderson@linaro.org>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 12 Aug 2020 19:38:17 +0200
Message-ID: <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 alex.bennee@linaro.org, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=andreyknvl@google.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Aug 2020 13:58:29 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> As reported by Andrey, I was missing the complete ISS info for
> the Data Abort raised upon a synchronous tag check fail.
>
> The following should fix that.  All the twisty little rules for
> the ISS.ISV bit are already handled by merge_syn_data_abort.
> Probably the most important bit that was missing was ISS.WnR,
> as that is independent of ISS.ISV.
>
> Andrey, will you please test?

Looks like WnR is now being set properly, but SAS is still always 0.


>
>
> r~
>
>
> Richard Henderson (3):
>   target/arm: Export merge_syn_data_abort from tlb_helper.c
>   target/arm: Pass the entire mte descriptor to mte_check_fail
>   target/arm: Merge ISS for data abort from tag check fail
>
>  target/arm/internals.h  |  4 ++++
>  target/arm/mte_helper.c | 24 ++++++++++++++----------
>  target/arm/tlb_helper.c |  8 +++-----
>  3 files changed, 21 insertions(+), 15 deletions(-)
>
> --
> 2.25.1
>

