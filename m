Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21378C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97ECD2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5+tFJUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ECD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrlP-0001Pm-Ml
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHrjE-0007uk-4o
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kHrjB-000215-1O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600102395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ov8Bhu4ae4fqCDkReThPcan1ZJxToMQhzKzMYWj7uE=;
 b=f5+tFJUqNrpIbO/RT7CJa3j8lEggzEyyEcfy3J26kZyLSFeKufYUGTNyjxItNtqNkUzVGn
 hPWNkTnimLpJZ2huT8jtnvZn1ckJp/gLbXLwbkwPNYiX/6QYPxJrkVnktxF75HFwNXKYvf
 gzFnXJf6vsvT6LauM00cgLAxpJIK1U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-8H6XKEWDPJi8GVUSYM2wZg-1; Mon, 14 Sep 2020 12:53:08 -0400
X-MC-Unique: 8H6XKEWDPJi8GVUSYM2wZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF634802B7C;
 Mon, 14 Sep 2020 16:53:07 +0000 (UTC)
Received: from localhost (unknown [10.10.67.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 936D327BC5;
 Mon, 14 Sep 2020 16:53:07 +0000 (UTC)
Date: Mon, 14 Sep 2020 12:53:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Moving to C11? (was Re: Redefinition of typedefs (C11 feature))
Message-ID: <20200914165306.GA8079@habkost.net>
References: <20200911184919.GV1618070@habkost.net>
 <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
 <20200911200649.GW1618070@habkost.net>
 <e2e2a955-693d-1372-f2e2-c58b7f88d0d7@redhat.com>
 <20200913025151.GX1618070@habkost.net>
 <329a1ae1-7b74-4045-3305-0577fcbb447a@redhat.com>
 <20200914134636.GZ1618070@habkost.net>
 <dfa5fff5-af96-d207-2d0c-66b5f265efa7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dfa5fff5-af96-d207-2d0c-66b5f265efa7@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 05:36:30PM +0200, Thomas Huth wrote:
> On 14/09/2020 15.46, Eduardo Habkost wrote:
> > On Mon, Sep 14, 2020 at 07:39:09AM +0200, Thomas Huth wrote:
> >> On 13/09/2020 04.51, Eduardo Habkost wrote:
> >>> On Sat, Sep 12, 2020 at 08:45:19AM +0200, Thomas Huth wrote:
> >>>> On 11/09/2020 22.06, Eduardo Habkost wrote:
> >>>>> On Fri, Sep 11, 2020 at 08:06:10PM +0100, Peter Maydell wrote:
> >>>>>> On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>>>>>
> >>>>>>> I'm wondering: do our supported build host platforms all include
> >>>>>>> compilers that are new enough to let us redefine typedefs?
> >>>>>>>
> >>>>>>> The ability to redefine typedefs is a C11 feature which would be
> >>>>>>> very useful for simplifying our QOM boilerplate code.  The
> >>>>>>> feature is supported by GCC since 2011 (v4.6.0)[1], and by clang
> >>>>>>> since 2012 (v3.1)[2].
> >>>>>>
> >>>>>> In configure we mandate either GCC v4.8 or better, or
> >>>>>> clang v3.4 or better, or XCode Clang v5.1 or better
> >>>>>> (Apple uses a different version numbering setup to upstream).
> >>>>>> So you should probably double-check that that xcode clang has
> >>>>>> what you want, but it looks like we're good to go otherwise.
> >>>>>
> >>>>> Can anybody confirm if the following is accurate?
> >>>>>
> >>>>> https://gist.github.com/yamaya/2924292#file-xcode-clang-vers-L67
> >>>>> # Xcode 5.1 (5B130a)
> >>>>> Apple LLVM version 5.1 (clang-503.0.38) (based on LLVM 3.4svn)
> >>>>> Target: x86_64-apple-darwin13.1.0
> >>>>> Thread model: posix
> >>>>>
> >>>>> If we know we have GCC 4.8+ or clang 3.4+, can we move to C11 and
> >>>>> start using -std=gnu11?
> >>>>
> >>>> You don't have to switch to gnu11, redefintions of typedefs are already
> >>>> fine in gnu99, they are a gnu extension there to the c99 standard.
> >>>>
> >>>> See also:
> >>>> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=7be41675f7cb16b
> >>>>
> >>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg585581.html
> >>>
> >>> They still trigger a warning with gnu99 on clang:
> >>>
> >>> $ clang --version
> >>> clang version 10.0.0 (Fedora 10.0.0-2.fc32)
> >>> Target: x86_64-unknown-linux-gnu
> >>> Thread model: posix
> >>> InstalledDir: /usr/bin
> >>> $ cat test.c
> >>> typedef struct A A;
> >>> typedef struct A A;
> >>> $ clang -std=gnu11 -c test.c
> >>> $ clang -std=gnu99 -c test.c
> >>> test.c:2:18: warning: redefinition of typedef 'A' is a C11 feature [-Wtypedef-redefinition]
> >>> typedef struct A A;
> >>
> >> Ah, right, I forgot about that ... so for clang, we silence that warning
> >> via CFLAGS in the configure script. See commit e6e90feedb706b1.
> > 
> > Nice, I hadn't seen that.  This means we don't need C11 for
> > supporting redefinition of typedefs.
> > 
> > Now, do we have other reasons for not moving to C11?  It would be
> > nice to make QEMU_GENERIC unnecessary and just use _Generic, for
> > example.
> 
> See https://www.mail-archive.com/qemu-devel@nongnu.org/msg585581.html
> ... c11 is still "experimental" in GCC 4.8, so I think we likely have to
> wait 'till summer next year - then we do not have to support
> RHEL7/CentOS7 anymore according our support policy, and thus we can bump
> the minimum required compiler versions.

Thanks Thomas and Daniel for the pointers.  Staying with gnu99
for a little longer sounds reasonable, now that we typedef
redefinitions are allowed.

-- 
Eduardo


