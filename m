Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77C02225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77C02225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUdYJ-0007Uv-SZ
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUdWT-000660-55
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:20:58 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUdWR-00010P-0D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:20:56 -0400
Received: by mail-il1-f194.google.com with SMTP id j8so2116456ilk.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iSevN+GZts6gTIMeV6gww5+561M8+Uka6gIhGIyG0jc=;
 b=KlHBtlIN0AFArpX2OO2ZLnJVSff6oLB2Ueq8uifSELTXkdFs//OgnnYCzm/DSpzJ6o
 /XUvRWJfUq3/wa+d0pU1cicDoKKLzI676kMp1+xcTRLHI3/6oo8aQyvXo2WOXV5HRX1C
 MtFPzv7IecQaS9zSoasINdxYINkKZh66IsfiwGZ7LeATi7lRDZ6Ats6yEs5GBWHvLt+M
 cGQd3oR5I1pHaoO175ijjpn1MMz4n1f86RAbJEzPBkjb4AFWRJIptc98xzOKwj03+tV8
 UJEOjO/DDTs7+SDDRVEApaTPXhgUGkKr7E6nC822PaUZbhFAuMHYaqG4SuH8j6tGNjhN
 AFzw==
X-Gm-Message-State: AOAM532tjC24pxPRs+eVY+kcY03Oob1baCVCjX88rqPg2wmLW4N/MNsf
 QrRykwpJRFBfd7ED+Cn7rQv6Fmz2YgU=
X-Google-Smtp-Source: ABdhPJzKQZiBA7/nwXXQLtGO4bxNDV+/4wYeec0Rbazu+ox6lBoqyk0AmDUV8AiP7rZIc2fdlRbttg==
X-Received: by 2002:a05:6e02:111:: with SMTP id
 t17mr1989161ilm.79.1603146052548; 
 Mon, 19 Oct 2020 15:20:52 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com.
 [209.85.166.41])
 by smtp.gmail.com with ESMTPSA id z20sm986348ior.2.2020.10.19.15.20.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 15:20:52 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h21so1804173iob.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:20:52 -0700 (PDT)
X-Received: by 2002:a6b:db06:: with SMTP id t6mr1394553ioc.204.1603146051794; 
 Mon, 19 Oct 2020 15:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-10-j@getutm.app>
 <54ea1dc9-f4e5-7827-6d05-c574b8c411d1@redhat.com>
In-Reply-To: <54ea1dc9-f4e5-7827-6d05-c574b8c411d1@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 19 Oct 2020 15:20:40 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAO0-0FFTBuM7c54cXOQMJkUhcPZ=kf-=RtSvwKdjmViA@mail.gmail.com>
Message-ID: <CA+E+eSAO0-0FFTBuM7c54cXOQMJkUhcPZ=kf-=RtSvwKdjmViA@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] block: check availablity for preadv/pwritev on mac
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.194; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 18:20:52
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

On Mon, Oct 19, 2020 at 1:27 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 19/10/2020 03.39, Joelle van Dyne wrote:
> > From: osy <osy86@users.noreply.github.com>
>
> That "From:" line looks wrong ... could you please fix the "Author" of your
> patches / your git config?
osy wrote the original changes. I joined the UTM project to help bring
the changes upstream with permission. However, they have agreed that
if required that we can use my name as the author.

>
> > macOS 11/iOS 14 added preadv/pwritev APIs. Due to weak linking, configure
> > will succeed with CONFIG_PREADV even when targeting a lower OS version. We
> > therefore need to check at run time if we can actually use these APIs.
>
> That sounds like the wrong approach to me ... could you please try to fix
> the check in "configure" instead? E.g. by running compile_prog with
> "-Werror", so that the test fails if there is no valid prototype available?
It's not that simple. Xcode 11 and below (supporting macOS 10.15 and
below, iOS 13 and below, etc) does not have preadv/pwritev symbols
defined and would fail to compile. Xcode 12 (supporting macOS 11 and
below, iOS 14 and below, etc) have preadv/pwritev weakly defined so if
it runs on, for example, 10.15, it would abort. There is no way to
determine at compile time if you can use preadv/pwritev or not when
building with Xcode 12. The availability checks are Apple's preferred
way to handle this kind of situation (they discourage directly
checking if an API exists on a system).

-j

>
>  Thomas
>

