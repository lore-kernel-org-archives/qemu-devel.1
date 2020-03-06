Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8CC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56F120848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56F120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADxg-0000mZ-3V
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1jA92g-0000Ef-91
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1jA92f-0002Ds-3k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:13:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1jA92e-0002A0-UJ; Fri, 06 Mar 2020 04:13:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so800468pgh.5;
 Fri, 06 Mar 2020 01:13:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UvWmgp0NFp/mKgDyS1K2Nd14v5giX0K4pPVrUcKgo+Q=;
 b=ZRobFLBqa6jRIN7lhNMY7LH7oo194t5jRM1W5E4tAKem0hmljzPs+lE1jXRbm+oP4x
 VBcEoGbSxlBKmeQ6NHVId7vCs12grhbVZTZFjoTtqUFTxp9pz7jjl4MAMKtG+AhICONj
 Ee/dhLfzymcFtiCv9IwuRCtgTZZUn84Q42faWGUulP4HsunZcuDmGIgT/6hb4yAso6pR
 x+arewxP/arUJOGpOfVvn/otIxr8/YqedxqlAsARB4KWmcIRhUuRMaLCGUBHF5/ECANw
 sXx2q9p+3cDC7MUngRfMGmUzCNCzByLh0yuMKSEr8e3jQT9RuWOqkBdXodb1Jz+xnDKn
 HGUA==
X-Gm-Message-State: ANhLgQ2tfHqp64SwbDUuCbFgSDRJfLmkVKgFCuluTjjXkQsU/Jopv2X3
 ttXVe0dJrNncmL830Qs+TYYOZxUOJlINkBIU
X-Google-Smtp-Source: ADFU+vtui8tgZliuX0vOJyHdcY5aaD3AgZssxxkV1UlumqLYK+0s2lZEtZAjHv12ZaZESiFnr2dSxg==
X-Received: by 2002:a63:7a5a:: with SMTP id j26mr2413045pgn.447.1583485991166; 
 Fri, 06 Mar 2020 01:13:11 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com.
 [209.85.214.176])
 by smtp.gmail.com with ESMTPSA id t126sm989771pfd.54.2020.03.06.01.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 01:13:10 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id f8so607139plt.10;
 Fri, 06 Mar 2020 01:13:10 -0800 (PST)
X-Received: by 2002:a17:90a:ec0f:: with SMTP id
 l15mr2568366pjy.133.1583485990255; 
 Fri, 06 Mar 2020 01:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-11-vsementsov@virtuozzo.com>
In-Reply-To: <20200306051536.27803-11-vsementsov@virtuozzo.com>
From: Paul Durrant <paul@xen.org>
Date: Fri, 6 Mar 2020 09:12:59 +0000
X-Gmail-Original-Message-ID: <CACCGGhAdx_OX-V59omuSQZccUWBNft063BO4-TPAw=JHNbuGoQ@mail.gmail.com>
Message-ID: <CACCGGhAdx_OX-V59omuSQZccUWBNft063BO4-TPAw=JHNbuGoQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] xen: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
X-Mailman-Approved-At: Fri, 06 Mar 2020 09:27:28 -0500
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 05:16, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
>
> This commit is generated by command
>
>     sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Paul Durrant <paul@xen.org>

