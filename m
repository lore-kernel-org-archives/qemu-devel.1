Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DBC388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 19:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E4A20885
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 19:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E4A20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWlfB-0005A1-PO
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWldL-0004aR-Iu
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 15:24:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kWldJ-0005Cl-Am
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 15:24:50 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so7691830ioo.7
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 12:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TYvd8kTszBV0ayRD5xcRtEdhwj0++OH/qbFi5+Auu+E=;
 b=BVnTE87tgP6M/yJpDVyN6KtVCGYjOcoXZpHzuwhRgMFNVrItVGBWYLb5/d7KFcl9Iz
 tlrhU2QVU29lEUngCutpFab/LSXgrBgB8QE/TnNnQA0voYCQGJwQXv16gwQIqDPqPu4Z
 Ajf9zEx2ZYe8G86Rmh/Dc7X462WuFvVJ6QaF6sxXeSkA35j70GnQc0uQjvEfdTau3nWt
 /UXuC7n7FvhgqCq2S5ij8bY4ZWT4vQuhEkqOg9KkQeB8oZF/JhZv/M2g332PzS/b1ezo
 uwH+IkvZx7W4tV0+XyvJHpRVN+PQKEH1Cr+w0R9/RusZcas0wozUuOtUg6ZgeIGTffzL
 lFig==
X-Gm-Message-State: AOAM5303ccpbb45i3zYFFwhpMGwrqykGtgjprU13O0sJ03MxThw1Hpio
 x4kf2gIcTVKUQ7GAOz3I5Ebw/HKf6MA=
X-Google-Smtp-Source: ABdhPJxRSYiiGFp/c/dpxWD9Kd1AREtAdj1JsRruOLjUdtsm7xy20IICesSmf/sxeCLpTDUJh6rglQ==
X-Received: by 2002:a5d:91c7:: with SMTP id k7mr8037229ior.74.1603653887502;
 Sun, 25 Oct 2020 12:24:47 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com.
 [209.85.166.170])
 by smtp.gmail.com with ESMTPSA id c2sm4350892ioc.29.2020.10.25.12.24.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 12:24:47 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id c11so3145659iln.9
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 12:24:47 -0700 (PDT)
X-Received: by 2002:a05:6e02:931:: with SMTP id
 o17mr8591816ilt.273.1603653886920; 
 Sun, 25 Oct 2020 12:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
 <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
In-Reply-To: <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Sun, 25 Oct 2020 12:24:36 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
Message-ID: <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.67; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 15:24:47
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the patch stands --cross-prefix="" works but I like having the
--enable-cross-compile option because it's more clear of the intention
(in logs and such). I've been struggling to come up with a concise
modification to the help text for --cross-prefix that explains that
empty PREFIX is allowed and why you would want to do that.

-j

On Tue, Oct 20, 2020 at 1:35 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/10/20 07:15, Thomas Huth wrote:
> >>>>>> +  ;;
> >>>>>> +  --enable-cross-compile) cross_compile="yes"
> >>>>>> +  ;;
> >>>>>> +  --disable-cross-compile) cross_compile="no"
> >>>>>
> >>>>> Can't you simply use --cros-prefix="" instead?
> >>>>
> >>>> I mean, still introduce the "cross_compile=yes" variable, just omit the new
> >>>> options.
> >>>
> >>> That seems less intuitive for people trying to find this option. If --help
> >>> lists --enable-cross-compile I can guess what that means but there's no
> >>> way I could guess --cros-prefix="" unless I've been told or searched and
> >>> stumbled upon it. So unless it's a big problem I like the explicit options
> >>> better. Or is that a convention in other projects to use empty prefix to
> >>> enable cross compile that I don't know about?
> >
> > I don't think that --cross-prefix is a "standard" option... Most other
> > (GNU-tools related) projects use "--build" and "--host" instead... so I
> > guess we're free to chose here. Let's see whether other people here have an
> > opionion on this...
>
> Yeah, the way GNU tools do it is that you specify --build and --host,
> and --host triggers cross compilation.  I'm not sure how they'd handle
> the situation where the cross prefix is empty.
>
> For QEMU, I agree with Thomas that --cross-prefix="" is enough.
>
> Paolo
>

