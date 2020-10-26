Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D10C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C7422400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C7422400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4Wo-0005V7-Qd
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kX4V2-0004Va-Eu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:33:32 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kX4V0-0000eR-Nl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:33:32 -0400
Received: by mail-il1-f196.google.com with SMTP id y17so8711587ilg.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1hqbvpO6QkMFYVX67N26xrXU2qi5n9sR1C2Wjch+heQ=;
 b=pl9voHLGRs06Tcq1pGUVA7mNvVBppzAZgnzpf+FE8kfJdb8BnhbO1sObuv0BqbKbcu
 U+R8qvX5CyEhCyfGZwUba6u1OCJzQHG8LemUzp4tLaw2PoHjZCRz9GKL67ucXJ9ljzPm
 zXu7fj4BGLAsQNFRr0kPNrBXA4yYRusXmhgvi2djdcp//HRitiQB0Hdre00Fl7tYa4ri
 6AM8Xvt5aGFBXObyXaLqMRYker2539xtPwuiGhTcEqP1Qc38362n+Y6TiOIy6kY1SbN/
 fTHXbedx8IxxXePLfCub5+hnVLAIuKmrzrsWeZ3rZbjXnTccnV3CKoeXJabwdgXdXgWo
 cHwg==
X-Gm-Message-State: AOAM530Zn2Sbb2mNvi2xF9ICLrJyuNlwqcuZowNsbdWvNJQMS+JKBPwN
 N5xeVCmdAr9FvBGeT4hwQOJX2CldYUE=
X-Google-Smtp-Source: ABdhPJw2Yh6/zjhOPwOO6WpzIeiX2okyDwqH7ie8lSbAH3NyEoZRHCeTKsFKADtDb1HZgiOKV6pz7w==
X-Received: by 2002:a92:c741:: with SMTP id y1mr12373205ilp.52.1603726408480; 
 Mon, 26 Oct 2020 08:33:28 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id x13sm5664345ioa.36.2020.10.26.08.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 08:33:28 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id x20so3351715ilj.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:33:28 -0700 (PDT)
X-Received: by 2002:a05:6e02:931:: with SMTP id
 o17mr11588407ilt.273.1603726407992; 
 Mon, 26 Oct 2020 08:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
 <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
 <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
 <77ef9338-de8c-82a8-7ca0-f8d708f8d1da@redhat.com>
In-Reply-To: <77ef9338-de8c-82a8-7ca0-f8d708f8d1da@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 26 Oct 2020 08:33:17 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBedWZL2hw_RKCSLn2bxomhdbTvYd9YSatX5RnGB5r-KQ@mail.gmail.com>
Message-ID: <CA+E+eSBedWZL2hw_RKCSLn2bxomhdbTvYd9YSatX5RnGB5r-KQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:33:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just to be clear, you're in favor of removing the
--enable-cross-compile option? I can do that if others agree but I'm
not sure what the downside of adding this extra option is?

-j

On Mon, Oct 26, 2020 at 12:54 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/10/20 20:24, Joelle van Dyne wrote:
> > As the patch stands --cross-prefix="" works but I like having the
> > --enable-cross-compile option because it's more clear of the intention
> > (in logs and such). I've been struggling to come up with a concise
> > modification to the help text for --cross-prefix that explains that
> > empty PREFIX is allowed and why you would want to do that.
>
> --cross-prefix=PREFIX enable cross compilation, using PREFIX
>                       in front of compile tools
>
> Paolo
>

