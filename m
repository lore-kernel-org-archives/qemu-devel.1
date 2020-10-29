Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA3EC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 01:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8898207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 01:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8898207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXwPb-000896-B4
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 21:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwNK-0007Nz-Er
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 21:05:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kXwNI-0004S5-Im
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 21:05:10 -0400
Received: by mail-il1-f194.google.com with SMTP id c11so1435674iln.9
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 18:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DTS/iRyQ4Q+A6wa/e+WN8JtY/DGi4X1m4Jqtqveoa2s=;
 b=Zii/MKrZmowmgl62gHJ1+plSeNqCx0YRu5qOCDv2nxcwXFSD5HJ2SFQSL7TB90XdvH
 yW40lGSHPysk0tVN2QelbcQ5DU4+DrzYE5oSOlOzPx+YgeD0tsvhxA42kmWch1WA7NWT
 YzCvqjEpVywO59MwQrIYnUxlPpBe8WaZAAV/eLEkFyKNNmpxStwSQFUt7yrbGCbzUkv/
 nQakhyur7hDbIT3NzuILh4PJ4bSOkeLcOxeljj5WpwF5xmJ5nzyghk2ah37qvLpKdEmd
 XPDp4lFxpiugu1r1xr26WlqqvqJIM1zkiwe8DgzvbCmp+uh0yScLL5Vf0vX1ueN9Ehdq
 igqQ==
X-Gm-Message-State: AOAM531eQMxu0OxiACpIJGIDV1yePgadH0JmxdjD/YAllmhmD7MNzHID
 RraoVGjY0l7llUW845DmsO4d38wDKmY=
X-Google-Smtp-Source: ABdhPJw1LbP5fIQC+7Xgwyr9dRRm4tr6C/gZE1ZkVwzBy71NUpBBqTPBalzIx/peMyZFgO7a03bb9w==
X-Received: by 2002:a05:6e02:541:: with SMTP id
 i1mr1295671ils.156.1603933507396; 
 Wed, 28 Oct 2020 18:05:07 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com.
 [209.85.166.53])
 by smtp.gmail.com with ESMTPSA id p18sm915209ile.72.2020.10.28.18.05.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 18:05:07 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id y20so1616204iod.5
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 18:05:07 -0700 (PDT)
X-Received: by 2002:a05:6638:531:: with SMTP id
 j17mr1643113jar.69.1603933507080; 
 Wed, 28 Oct 2020 18:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-7-j@getutm.app>
 <20201028115358.GJ221115@stefanha-x1.localdomain>
In-Reply-To: <20201028115358.GJ221115@stefanha-x1.localdomain>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 28 Oct 2020 18:04:56 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAPEWFoG01mVVi_04jvdYXj+onNHea0X2KZzPadp+hktQ@mail.gmail.com>
Message-ID: <CA+E+eSAPEWFoG01mVVi_04jvdYXj+onNHea0X2KZzPadp+hktQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tcg: implement JIT for iOS and Apple Silicon
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.194; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 21:05:07
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

Will fix the typo in the commit message.

Re: "reverse engineered functions", Apple does not provide any
documentation on their extensions to ARM architecture. APRR is one
such proprietary feature that is controlled by MRS/MSR writes to an
undocumented system register. We reverse engineered the functionality
by tracing how libsystem_pthread.dylib works and replicating the
MRS/MSR calls.

More details: https://siguza.github.io/APRR/

Legally, I don't think this is any different from reverse engineering
some hardware interface to write a Linux driver but IANAL.

-j

On Wed, Oct 28, 2020 at 4:54 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Tue, Oct 27, 2020 at 08:07:00PM -0700, Joelle van Dyne wrote:
> > On iOS, we cannot allocate RWX pages without special entitlements. As a
> > workaround, we can allocate a RX region and then mirror map it to a separate
> > RX region. Then we can write to one region and execute from the other one.
>
> "separate RW region"? The sentence doesn't seem to make sense if both
> regions are RX.
>
> >
> > When entitlements are available (macOS or jailbroken iOS), a hardware
> > feature called APRR exists on newer Apple Silicon that can cheaply mark JIT
> > pages as either RX or RW. Reverse engineered functions from
> > libsystem_pthread.dylib are implemented to handle this.
>
> What does "Reverse engineered functions" mean? We cannot accept code
> into QEMU that is a potential liability if Apple could claim it has been
> copied, derived, etc without permission. If libsystem_pthread.dylib is
> open source, especially under a permissive license, then it's probably
> okay.
>
> Can you clarify?

