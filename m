Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D97A248F3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D97A248F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLyW-0003bm-CC
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSLwd-0002RZ-Mi
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:10:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kSLwY-0007rq-QS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:10:28 -0400
Received: by mail-io1-f66.google.com with SMTP id y20so18834678iod.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XZOs5yvKtERnEpF1TXqSL62b+hB5q3yGFVvv/Joge0c=;
 b=r4X/7G4dg+CS5G3HQYPqqJUyWJBWsQP83zfhCoeklMzt1ymbIiqT07VVJ9JPMs1bhO
 yujFzHOKEG+07kgjquuzw2Cr+bVRxLq3rabu1TrA0+S+HIaid5qnJlgXf3oR5ixoCba+
 31UGENHFYA3NmC3BRuOP896a1YX5E6hdJxtksMQOoQhtDn9Qn2fjmLFtqQVoBI6e+OdS
 3bSxBidzUuoN2k39qM1HJlun6b3/KApuVA7GOiOjZrnqTIfqswyPnUvmQSXB1mO5bqT2
 SvdH2ATSmTGtYlopaLArXEVT7hGgGaTtMzKtGpenNLcFCzmdrh+3VTLPtfUl8XuicXqp
 rCjA==
X-Gm-Message-State: AOAM5317irhST2UfH+PXjK37izW/LOUGH2aiarL4/+/s7jJr+sd/Nrgo
 ZCjXjhQ9MqbwesaRzcPcdQZAN9Machk=
X-Google-Smtp-Source: ABdhPJyLVUUQRCL8WaMgA1h/5aMTYe74xGm6b47IazCVjEQ4e9bL82nBfI9UKuTtgQtqcC1vvPzKhQ==
X-Received: by 2002:a6b:144e:: with SMTP id 75mr20086508iou.39.1602601825289; 
 Tue, 13 Oct 2020 08:10:25 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com.
 [209.85.166.46])
 by smtp.gmail.com with ESMTPSA id g17sm54965ilq.15.2020.10.13.08.10.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 08:10:25 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id l8so22935903ioh.11
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 08:10:24 -0700 (PDT)
X-Received: by 2002:a02:7b08:: with SMTP id q8mr370558jac.120.1602601824653;
 Tue, 13 Oct 2020 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-9-j@getutm.app>
 <684fff0d-05cb-0e6f-c963-6bd4e4cf457a@redhat.com>
In-Reply-To: <684fff0d-05cb-0e6f-c963-6bd4e4cf457a@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 13 Oct 2020 08:10:13 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBxZr47qn3sDJGvg+4GnjQEhwpF-uKGTZTWsY5D3o_FzQ@mail.gmail.com>
Message-ID: <CA+E+eSBxZr47qn3sDJGvg+4GnjQEhwpF-uKGTZTWsY5D3o_FzQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] tcg: mirror mapping RWX pages for iOS optional
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.66; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:10:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>,
 Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a slight performance penalty for using "bulletproof JIT".
Since that is not required if you have the proper entitlements (only
if you're Apple or jailbroken on iOS; available to regular developers
on Apple Silicon macOS), we want the flexibility to disable it.

-j

On Tue, Oct 13, 2020 at 6:52 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 13/10/20 01:29, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
> >
> > This allows jailbroken devices with entitlements to switch the option off.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
>
> What is the advantage in doing so?
>
> Paolo
>

