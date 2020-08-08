Return-Path: <SRS0=zX6u=BS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59994C433E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271282053B
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Aug 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CXm7NU+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271282053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4OWf-0001y1-EG
	for qemu-devel@archiver.kernel.org; Sat, 08 Aug 2020 09:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <briannorris@chromium.org>)
 id 1k4Dlr-000522-NL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 21:35:39 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <briannorris@chromium.org>)
 id 1k4Dlp-0002fR-1v
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 21:35:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id f10so2039720plj.8
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 18:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Qg5AipmbsOqGORh4asctcOLgSmkHVhy7DTpwSSMHlcU=;
 b=CXm7NU+sFKz0z5FhuzBDYLPGduqzipl14SuBf5i0cOjh4ReCaJ+Ofy2E9Xqkju05qa
 HeNQF3LRje2RlIKUHSw0LQQgx96zcugJgQTF1SJxjRVMgikzfb6uOie8NB+XoP+VphVM
 OyGDXrjuMZO1JDzy3k2SaRKrOnqqdgwXhWbY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Qg5AipmbsOqGORh4asctcOLgSmkHVhy7DTpwSSMHlcU=;
 b=Ny8EHwtzUGn/2SWh2k+r67ohI9zm7HdtX48ykAUfOwLsF/PVR0oPHdReL03Qnfd9XG
 +LoWZsJ49whNYInVyVIQuGriY9uE2sp8ZQNJm1cuDAfd2Hfjykh8HcQTtlHzGjfHdyY4
 2ai3Gbmtb/Tc/oKpR/tY3vcE1iH3rUT0/yig2vFrPJxDsfmFS0M6qTKJKLeBOtEHmB2W
 uGdCO16GNGSg+u4N94cJYq+rCNKFNQdHYQSvrvmxpTqnBrHCr0f6TzNoESg8Y/7FQILF
 gbJXKrSN3zQwzjYYGMdLe2f9aR+khyqGE0zVfQxHRgw3P9/jsycBHvPnB3mPy/iGUgqT
 88rQ==
X-Gm-Message-State: AOAM532doQvflB/tWXMJAhSi3y6QAdI3Rr0W+E4JGTazwqOsK/SaWERh
 YNipbd9aP8LTg9PNXfmaqi+PaA==
X-Google-Smtp-Source: ABdhPJzGo/X8QZvyTCC72htn5LBgXseULfbUnWUbFHvb0KsoP2c+WgS+ZbHHeQYwX4bLhJaRjeu67Q==
X-Received: by 2002:a17:90a:6903:: with SMTP id
 r3mr15951458pjj.65.1596850534476; 
 Fri, 07 Aug 2020 18:35:34 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:8edc:d4ff:fe53:350d])
 by smtp.gmail.com with ESMTPSA id q12sm15488646pfg.135.2020.08.07.18.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 18:35:33 -0700 (PDT)
Date: Fri, 7 Aug 2020 18:35:31 -0700
From: Brian Norris <briannorris@chromium.org>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
Message-ID: <20200808013531.GA166030@google.com>
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
 <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
 <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxUqrq77_io9j6k7EU91vm7iEEBaTwLNsKd9YJ9NVR7rw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=briannorris@chromium.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Aug 2020 08:59:47 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joe Slater <joe.slater@windriver.com>, "MacLeod,
 Randy" <randy.macleod@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!

On Wed, Jul 15, 2020 at 11:57:14PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jul 15, 2020 at 11:37 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 16 Jun 2020 at 10:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.com> wrote:
> > > >
> > > > Always look for ../share/qemu then ../pc-bios when looking for datadir.
> > >
> > > Could you provide some more context, please? Why is this
> > > change useful; presumably we broke some setup in 5.0, but
> > > what exactly ?
> > >
> > > I'm guessing this might be a regression introduced by commit
> > > 6dd2dacedd83d12328 so I'm ccing the relevant people.
> >
> > Marco, Paolo: ping? Another user has just asked me the status
> > of this as they also ran into this regression in what directories
> > we search...
> 
> Thanks for the heads-up, I didn't see that bug/mail. Indeed, that
> commit assumed that either we run from a build directory or from an
> installed qemu. It seems this is hybrid approach, which I didn't know
> we supported. I'll check it.

Add one more to the pile! Chrome OS noticed this when upgrading to
5.0.0:

https://bugs.chromium.org/p/chromium/issues/detail?id=1114204#c8

I'd love to see this applied to a release.

I actually wrote basically this exact same patch and was about to submit
it, when I saw that this was already here. I've tested Joe's variant:

Tested-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>

The Chromium bug report is public, so you can see details there, but
it's basically the same -- we sometimes run qemu from a path that's not
the same absolute path noted in ./configure. This is because we build
qemu to run within our SDK (a semi-containerized chroot), but we also
support running that same QEMU binary from outside the container, which
then may be at some arbitrary hierarchy on a developer's machine.

It might be wise to include a tiny bit more verbose of a code comment,
to prevent oversights like this in the future. I'm sure that could be
spliced in when the patch is applied though.

Regards,
Brian

