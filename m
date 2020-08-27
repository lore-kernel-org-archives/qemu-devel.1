Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A315B20786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A315B20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBAUK-0005wI-T3
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kBATn-0005T0-Oo
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:29:43 -0400
Received: from relay64.bu.edu ([128.197.228.104]:53595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kBATm-0008WV-1C
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:29:43 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07R5T6Jl030826
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2020 01:29:09 -0400
Date: Thu, 27 Aug 2020 01:29:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
Message-ID: <20200827052905.qfpti4wnakvxe5w5@mozz.bu.edu>
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <CAFEAcA8MSzo7+zSWTr8vmU294M3oYkZKk17SFRrBZLmqfxGdmQ@mail.gmail.com>
 <CABgObfaO8TB=LYgpn871c82me8e83CzRuDYyi1UGWZFopLgfbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfaO8TB=LYgpn871c82me8e83CzRuDYyi1UGWZFopLgfbQ@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 01:29:40
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200827 0613, Paolo Bonzini wrote:
> Il mer 26 ago 2020, 21:34 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
> 
> > On Wed, 26 Aug 2020 at 20:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > Otherwise, dollars (such as in the special $ORIGIN rpath) are
> > > eaten by Make.
> >
> > Incidentally, why are we using rpath anyway? I'm pretty
> > sure the old build system didn't need it, and it's one of
> > those features I have mentally filed away under "liable
> > to confusing and non-portable weirdness"...
> >
> 
> It's only done in the build tree, to allow running against uninstalled
> shared_library. Installed binaries have no rpath (distros don't want it
> anyway). QEMU doesn't need it since it has no shared library yet.
> 

Its an obscure example, but we use it in scripts/oss-fuzz/build.sh to
build a qemu-fuzz binary(qemu-system with some bells and whistles) that
is portable between containers and can be deployed on oss-fuzz. The
other option is to build a static binary, which AFAIK is not supported
for softmmu builds.

I guess this is a prime example of "confusing and non-portable
weirdness".
In defense, it wasn't our idea. The oss-fuzz documentation suggests it:
https://google.github.io/oss-fuzz/further-reading/fuzzer-environment/#runtime-dependencies

> Paolo
> 
> >

