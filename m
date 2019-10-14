Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC73ECE58E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761D021882
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761D021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1ts-0004M4-Kv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iK1ro-0002Kj-9W
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iK1rm-0005n3-JG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:02:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iK1rm-0005mH-9N
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 440DA7F74A;
 Mon, 14 Oct 2019 15:02:33 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C040360566;
 Mon, 14 Oct 2019 15:02:25 +0000 (UTC)
Date: Mon, 14 Oct 2019 12:02:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: sphinx-build parallel build failures (was Re: [PATCH v3]
 target/i386: Add Snowridge-v2 (no MPX) CPU model)
Message-ID: <20191014150224.GQ4084@habkost.net>
References: <157087059993.19261.12706853972165466894@37313f22b938>
 <00a6687037f90374605d8f4f69b9d2b3d614040b.camel@intel.com>
 <20191012135158.GN4084@habkost.net>
 <CAFEAcA8x-6zsz-aZShCheOnE_d-VnvJ9u7=0qmxXStBF7EUsNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8x-6zsz-aZShCheOnE_d-VnvJ9u7=0qmxXStBF7EUsNg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 14 Oct 2019 15:02:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 01:02:44PM +0100, Peter Maydell wrote:
> On Sat, 12 Oct 2019 at 14:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 07:40:30PM +0800, Xiaoyao Li wrote:
> > > On Sat, 2019-10-12 at 01:56 -0700, no-reply@patchew.org wrote:
> > > > Patchew URL:
> > > > https://patchew.org/QEMU/20191012024748.127135-1-xiaoyao.li@intel.com/
> > > >
> > > >
> > > >
> > > > Hi,
> > > >
> > > > This series failed the docker-mingw@fedora build test. Please find the testing
> > > > commands and
> > > > their output below. If you have Docker installed, you can probably reproduce
> > > > it
> > > > locally.
> > > >
> > > > === TEST SCRIPT BEGIN ===
> > > > #! /bin/bash
> > > > export ARCH=x86_64
> > > > make docker-image-fedora V=1 NETWORK=1
> > > > time make docker-test-mingw@fedora J=14 NETWORK=1
> > > > === TEST SCRIPT END ===
> > > >
> > > >   CC      stubs/machine-init-done.o
> > > >   CC      stubs/migr-blocker.o
> > > >   CC      stubs/change-state-handler.o
> > > > make: *** [Makefile:994: docs/interop/index.html] Error 2
> > > > make: *** Waiting for unfinished jobs....
> >
> > This looks like the sphinx-build parallel build failures I am
> > also seeing in my builds:
> > https://github.com/sphinx-doc/sphinx/issues/2946
> 
> Could you send your workaround patch:
> https://github.com/ehabkost/qemu-hacks/commit/569f1dcb5764fccd5942ebbe39d3a8ed91cd632b
> to qemu-devel? It seems like a reasonable way to avoid
> the problem (just use different doctrees) and less complicated
> than trying to serialize the two builds in the QEMU makefiles.
> I think my only review comment would be to add a couple of
> comment lines to the makefile, something like:
>  # Note use of different doctrees for each (manual, builder) tuple;
>  # this works around Sphinx not handling parallel invocation on
>  # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
> 
> so we don't forget why we had to do this.
> 
> If you do that you can add my
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> tag when you send the patch.

Done, including the comment you've suggested above and your
Reviewed-by line.  Thanks!

-- 
Eduardo

