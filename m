Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337EC55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1227420757
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1227420757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3PK-0002KT-26
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kY3N5-0001Gr-Eb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:33:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kY3N3-0000PV-6z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:33:22 -0400
Received: by mail-il1-f195.google.com with SMTP id c11so2195155iln.9
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zBkvyUt0ulIv+t9/gREQpI/dFB9JafmcKND7PHgiwGM=;
 b=UnYgKZ/1DABAGt3cazeSV98z4LoEjatyvKQMB6iEHwMUrh9d7pfoR3JjXvlSsQzDze
 sESJajbGZBkJlMqByvSla73ykTEpvs237b5cPnoSr5+FhIcaMJGv87E7CFGOorlnJPCz
 g9tCxbCvdLW8I7qH+YE4Fh/UnAGS62J+UFrPzGEzGpKTsFkJtMonPI1huTF5Gv4dtnws
 BuCSghPx2hVWTZyebRJ4PwgzcU23Yr34Hg7C9lQQNqZvR6/3tamoqpRNi5w/Nn5SVnlO
 N6BpoJRaIbl0BLM+GBA/6Tl9+GbPhARLiM4VUWhNQMzGq/YhoxNElB+FLoa1P0GLpDJ4
 T25g==
X-Gm-Message-State: AOAM531TwS5GX1GTN58E12Hk0rNCSs78fYfnNuRg3vza4stGTt8DMaD9
 ypjVEvo4SltUEMvEq2MBghu5Nlz7CeQ=
X-Google-Smtp-Source: ABdhPJxdwHxKdxv/kJ2jqhiktvjcjIohtq9fxXNSQTLf3Ahd7NyAPcOf85ppfha4bDVt9HtrlQXVuA==
X-Received: by 2002:a92:c5b1:: with SMTP id r17mr2428853ilt.229.1603960397859; 
 Thu, 29 Oct 2020 01:33:17 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com.
 [209.85.166.181])
 by smtp.gmail.com with ESMTPSA id o13sm1512857iop.46.2020.10.29.01.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 01:33:17 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id z2so2167584ilh.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:33:17 -0700 (PDT)
X-Received: by 2002:a92:dac1:: with SMTP id o1mr2157354ilq.191.1603960397367; 
 Thu, 29 Oct 2020 01:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-8-j@getutm.app>
 <20201028115946.GK221115@stefanha-x1.localdomain>
 <CA+E+eSAfHXsYDbn5HnpGmQrpwpkAUBrMn7w4PwLDfMPctRwdFw@mail.gmail.com>
 <20201029075359.GC251558@stefanha-x1.localdomain>
In-Reply-To: <20201029075359.GC251558@stefanha-x1.localdomain>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 29 Oct 2020 01:33:06 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBRU3Mi+MG5PZ8Yj-D6TJ2i0OEY-xtbK1vf9omi9fxGqg@mail.gmail.com>
Message-ID: <CA+E+eSBRU3Mi+MG5PZ8Yj-D6TJ2i0OEY-xtbK1vf9omi9fxGqg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] block: check availablity for preadv/pwritev on mac
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.195; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 04:33:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No it doesn't return ENOSYS. Dyld calls abort() when a weak link is
not resolved at the time of call.

-j

On Thu, Oct 29, 2020 at 12:54 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Oct 28, 2020 at 06:07:16PM -0700, Joelle van Dyne wrote:
> > If built with Xcode 12 without the checks, a runtime error will occur.
>
> If that runtime error is ENOSYS then it's handled by existing code:
>
>   if (preadv_present) {
>       nbytes = handle_aiocb_rw_vector(aiocb);
>       if (nbytes == aiocb->aio_nbytes ||
>           (nbytes < 0 && nbytes != -ENOSYS)) {
>           goto out;
>       }
>       preadv_present = false;
>   }
>
> Why is additional code needed for iOS?
>
> Stefan

