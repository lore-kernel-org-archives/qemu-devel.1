Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B28C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5970A208B8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5970A208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUea0-0003pT-Fz
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUeYT-00039r-OX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:27:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUeYS-00015O-4V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:27:05 -0400
Received: by mail-io1-f66.google.com with SMTP id k6so155362ior.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oqc8JGcqQJmb8ZFZgcUXDG0qg5G7xEKx1MzbcDYoMkI=;
 b=qIEqC5DIWxBnnKNrDH4iLIqUNJqVvqGcuuTGs1NlM4nrZo2a318pihfl4x+oLu37wR
 GbQ+rAsY2//O/p0tLb3cZsiCJ60vrL6q9isjbpaciYv1/jeMRypgFc3s2rnBio++My5P
 R2u3JMOGhMrz00kgxLXrrfkA3s8Hk59pYTC/fUwJq6Rc5J+eyQkRmhemeJdFMPYa4p4Z
 ibJle3WDTGJCHf7fhsZF7HYk3P8zZsMDEsvnuBkgUPsBK3m0C/eeEG93cXRhdTQprCJ0
 IMuqTRnkWofrMmWWpVQnWaXpx4zuKnRuHJWflXHh5JwaVUDKIroNpNiy+mOu/ythZp+X
 flrA==
X-Gm-Message-State: AOAM533N+x8M7uI3cK8oD5/T2RCFyAWAZgPwn/bozKT8SKUKT2lUf68C
 aMCgMkmVCXhK4QiipFBatOJNus3E/Zc=
X-Google-Smtp-Source: ABdhPJzCJVV7A2/PkApPON75ur/80n8sbTiuTawL4NIWOGlCqD/pf0hGvDZPKZ54rOvTDn/xxxazMA==
X-Received: by 2002:a02:a395:: with SMTP id y21mr124807jak.58.1603150022515;
 Mon, 19 Oct 2020 16:27:02 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com.
 [209.85.166.42])
 by smtp.gmail.com with ESMTPSA id o19sm71976ilt.24.2020.10.19.16.27.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 16:27:02 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id b8so101235ioh.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:27:02 -0700 (PDT)
X-Received: by 2002:a5e:d719:: with SMTP id v25mr133598iom.32.1603150022076;
 Mon, 19 Oct 2020 16:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-6-j@getutm.app>
 <30c59d7a-a11f-5d9b-4dcc-eb8cf120a4cb@linaro.org>
In-Reply-To: <30c59d7a-a11f-5d9b-4dcc-eb8cf120a4cb@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 19 Oct 2020 16:26:51 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCX8wQKjehBtbaf1g7aRpLEaaivqmUqP3_1+h=iK6pUFA@mail.gmail.com>
Message-ID: <CA+E+eSCX8wQKjehBtbaf1g7aRpLEaaivqmUqP3_1+h=iK6pUFA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] tcg: add const hints for code pointers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.66; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 18:24:40
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You can --author "Joelle van Dyne <j@getutm.app>"

-j

On Mon, Oct 19, 2020 at 4:19 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/18/20 6:39 PM, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
> >
> > We will introduce mirror mapping for JIT segment with separate RX and RW
> > access. Adding 'const' hints will make it easier to identify read-only
> > accesses and allow us to easier catch bugs at compile time in the future.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> Are you "osy"?  We do need S-o-b with real names from all contributors to the
> patch.
>
> The patch is bigger than I would like, but it all appears to be strongly
> connected, and I don't see where it could be split.  I'm inclined to
> cherry-pick this patch out now to avoid carrying it around.  So if I can either
> fix the --author to you, or we can get a s-o-b from the author, I'll do that.
>
>
> r~

