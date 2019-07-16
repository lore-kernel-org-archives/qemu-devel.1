Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB57C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97D82145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97D82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKme-0003Je-QE
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49555)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnKmR-0002uL-TV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnKmQ-0007uN-PW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:33:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnKmQ-0007tf-Ir
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:33:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so4920064pfn.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jmBUEnKoHwR0GteeUv3h+aV2FyhsHOGnEIGTMj+N1t0=;
 b=h28y9vauRH5G/OaxUG4VmY7eRGD1zHdsCOVVdoO9ex7ewmM7jdO1NKNLjfn7h+Wp2D
 +4DeeHOmb40mj6y6CO1gv+iPGUmIC+xrx+XS4wpq17pwyFMbZ3N7bPzawzpPehERbLFv
 r+S8l0/DTOTqbLdDejrEjT2WpkXl/rdadxUSSnzTcfQ+BGOENgABZVWu+gmyG/v/JSE7
 F1wbjZRevzAeN6OAwGug7a5Z44kZbhFCQ0kCcYk98/teMg2TqnEN5P331wjNo10ti/WC
 3UczzSok5kWN1pWZfAd3AJ68CWxwBZ+a2CJfVY/1rS1UsYXHoSekQL4gwHVzfn/O3lWw
 nq/w==
X-Gm-Message-State: APjAAAXZAsU5hp7e+J+iix0PJxRaPK1sltojchOruVtMN+/xrYgWrxer
 pgQW0oyniDq7k+onl62f8VySiw==
X-Google-Smtp-Source: APXvYqxcn2FlmLsLcHdNhFGJCm/jEM2sG8QW22hEughtC0GRGUC+NUJ1hMUL+pfmRZmDJmAu833J8Q==
X-Received: by 2002:a63:20d:: with SMTP id 13mr20563881pgc.253.1563273233411; 
 Tue, 16 Jul 2019 03:33:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id l1sm26233047pfl.9.2019.07.16.03.33.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 03:33:52 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 16 Jul 2019 18:33:41 +0800
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190716103341.GC30980@xz-x1>
References: <1563261042-15974-1-git-send-email-yan.y.zhao@intel.com>
 <20190716072315.GA30980@xz-x1>
 <20190716072919.GA8912@joy-OptiPlex-7040>
 <20190716075025.GB30980@xz-x1>
 <20190716075749.GB8912@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716075749.GB8912@joy-OptiPlex-7040>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.194
Subject: Re: [Qemu-devel] [PATCH] migration: notify runstate immediately
 before vcpu stops
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 03:57:49AM -0400, Yan Zhao wrote:
> On Tue, Jul 16, 2019 at 03:50:25PM +0800, Peter Xu wrote:
> > On Tue, Jul 16, 2019 at 03:29:19AM -0400, Yan Zhao wrote:
> > > On Tue, Jul 16, 2019 at 03:23:16PM +0800, Peter Xu wrote:
> > > > On Tue, Jul 16, 2019 at 03:10:42PM +0800, Yan Zhao wrote:
> > > > > for some devices to do live migration, it is needed to do something
> > > > > immediately before vcpu stops. add a notification here.
> > > > 
> > > > Hi, Yan,
> > > > 
> > > > Could I ask for a more detailed commit message here?  E.g., what is
> > > > "some devices"?  And, what's the problem behind?
> > > >
> > > hi Peter,
> > > 
> > > Some devices refer to assigned devices, like NICs.
> > > For assigned devices to do live migration, it is sometimes required that
> > > source device is stopped before stopping source vcpus. vcpus can do some
> > > final cleanups (like handling interrupt) in that case.
> > 
> > I see, so this is a prerequisite of another work?
> 
> Yes.
> > 
> > IMHO it would make more sense to have this patch to be with that
> > patchset, then it'll justify itself with reasoning.  Unless I
> > misunderstood - this single patch seems to help nothing if as a
> > standalone one.
> 
> It would be better. but this patch alone is also somewhat general,
> as it only adds an extra notification and wouldn't impact others.
> 
> Only after this patch is upstreamed, can VFIO live migration have a
> second choice for those devices of special requirements.
> 
> Hope it can get understanding from you:)

No you don't need my understanding, as long as the maintainer likes it
it's good enough, so you probably only need to persuade the
maintainers. :)

But again for me I would prefer patch like this to simply be the first
patch of your live migration series.  There can be some exceptions
like that when the prerequisite is too big so we'd better split them
out to do things step by step, but this patch (which is a oneliner)
should not be the case.

Thanks,

> 
> Or do you think I need to change the commit message a little to unbind
> from migration?
> 
> Thanks
> Yan
> 

-- 
Peter Xu

