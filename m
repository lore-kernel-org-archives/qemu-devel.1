Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A434206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIuApx8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A434206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30kc-0004CY-HO
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pcc@google.com>) id 1k30jg-0003ZL-FK
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:28:24 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:35103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pcc@google.com>) id 1k30ja-0000j6-55
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:28:24 -0400
Received: by mail-vk1-xa43.google.com with SMTP id i20so821392vkk.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tj9S+jt13dZL2uqzI9eNoiWm4249m0G177wh4qUTsLY=;
 b=UIuApx8BVdeKf+fvNvxSiPK2Unzk7r/kZkxr+dBK1A7cWybGTTG2a3Gs5uvOA8mfVE
 vMoEmpHKRF/H1DQYpxMcWbMK8+O1GU7UXL50EvUpmsLmUf15Xw7sRaEH7ptxqGNOxDKJ
 is/VvklXKEQymkUlMeq79ZPFLKrq2gWSfMYX3Nn7hI1/SGwgH3l6KXgpTet7FzkwjCJA
 /aVLt68xKIJQJAWeDbhl6VASmThHqjjUisOZ+xcu/bxNq0070MtNoeMQYeHJO49rVrzh
 TKFRR2FWCZrZ3kcV9jBHZ00PBZaPhyunBFxd3kHsH0/x/aW24OvmvJI7mws2O4XSh5J/
 ZaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tj9S+jt13dZL2uqzI9eNoiWm4249m0G177wh4qUTsLY=;
 b=HEl8rNaSgu/8pArNksrVzdglfeVZghKPxpFu3EvovY3niWXYy9xq/wtfJKp8emsMep
 N0drsAZyCfuq1ojPAg26zuq76EjNM3A7ax5XNKQwai3zTKe03R7Lcz9xU4gzbISk6QZU
 Iw/QZZciNved2tyz/S5Is1oENZ1r39/dJKy7Y6pbIQtFQdrEWLeRUnAjS/+9MeCgnc7M
 OZHiSYDhRvcey3Ek3KURnbyYUeVYtnaoOhK9yDaBujPftsIj291cC/YnXazPbIteHWRB
 M3wlLtLRzZuXQTh7OFStJhpz1ZtBPa0cW/WfALbRordFTRDF8hgqotbj0XWzlOA9Sg0Q
 wqgQ==
X-Gm-Message-State: AOAM5325UWNBsaouSr7qMUKr9DCuFikxOP/1AI0FJ/rxZd8Rx4nk8Tgk
 7cHVcQzQrbPQr6RDw5QJmrQerNoOdCkb2bxNYV+2Hg==
X-Google-Smtp-Source: ABdhPJx+RL1YoBfzE4Wxp1/cvJjvt7lxiYokud+o5vcK/nXJOJHUzs+mANSRxPIFo5fywFA+4cKxDJmAJLYiZNxYV5I=
X-Received: by 2002:a1f:f8c5:: with SMTP id w188mr8354044vkh.15.1596562096216; 
 Tue, 04 Aug 2020 10:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200803222656.63936-1-pcc@google.com>
 <CAMn1gO75w=oaCp2TjhFzr2nrbKhHOP6Q20bnvuuAzgSVe+thMg@mail.gmail.com>
 <1c14ed0a-da1b-a265-d5bd-2dea42764032@linaro.org>
In-Reply-To: <1c14ed0a-da1b-a265-d5bd-2dea42764032@linaro.org>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 4 Aug 2020 10:28:05 -0700
Message-ID: <CAMn1gO5nBvra0saJ53zY5fWYo_Jm0LReHmOSyYwsCGXES66fAA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix decode of {LD,ST}RA[AB] instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=pcc@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 4, 2020 at 8:41 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/3/20 5:21 PM, Peter Collingbourne wrote:
> > On Mon, Aug 3, 2020 at 3:27 PM Peter Collingbourne <pcc@google.com> wrote:
> >>
> >> These instructions use zero as the discriminator, not SP.
> >
> > Oh, there is no such thing as STRAA/STRAB. I must have been confused
> > by the name of the function, disas_ldst_pac. I will send a v2 with a
> > fixed commit message, and another patch to rename the function to
> > disas_ld_pac.
>
> It's called decode_ldst_pac because the Arm ARM section is called "Load/store
> register (pac)".  Page C4-311 in the F.a revision.
>
> But yes, there are only loads defined in the section.

I see. Arguably the ARM ARM section is misnamed then. There is a
sibling section named "Load register (literal)", so there is precedent
for naming a section after the types of instructions that are actually
supported. I will send mail to errata@arm.com to see if the section
can be renamed.

Peter

