Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5350C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B52824670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B52824670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79LR-0007aC-RW
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79KN-000730-Hx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79KL-0006wK-F1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:55:07 -0500
Received: from relay64.bu.edu ([128.197.228.104]:44426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>)
 id 1j79KH-0006e2-1A; Wed, 26 Feb 2020 21:55:01 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 01R2oP8O032640
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 26 Feb 2020 21:50:28 -0500
Date: Wed, 26 Feb 2020 21:50:25 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PULL 24/31] fuzz: support for fork-based fuzzing.
Message-ID: <20200227025025.vp2m4yojenlneauz@mozz.bu.edu>
References: <20200222085030.1760640-1-stefanha@redhat.com>
 <20200222085030.1760640-25-stefanha@redhat.com>
 <6ffd74e1-d603-f479-e6e4-eb5ef4ce7050@redhat.com>
 <20200224113529.GB1896567@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224113529.GB1896567@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 128.197.228.104
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200224 1135, Stefan Hajnoczi wrote:
> On Sat, Feb 22, 2020 at 05:34:29AM -0600, Eric Blake wrote:
> > On 2/22/20 2:50 AM, Stefan Hajnoczi wrote:
> > > From: Alexander Bulekov <alxndr@bu.edu>
> > > 
> > > fork() is a simple way to ensure that state does not leak in between
> > > fuzzing runs. Unfortunately, the fuzzer mutation engine relies on
> > > bitmaps which contain coverage information for each fuzzing run, and
> > > these bitmaps should be copied from the child to the parent(where the
> > > mutation occurs). These bitmaps are created through compile-time
> > > instrumentation and they are not shared with fork()-ed processes, by
> > > default. To address this, we create a shared memory region, adjust its
> > > size and map it _over_ the counter region. Furthermore, libfuzzer
> > > doesn't generally expose the globals that specify the location of the
> > > counters/coverage bitmap. As a workaround, we rely on a custom linker
> > > script which forces all of the bitmaps we care about to be placed in a
> > > contiguous region, which is easy to locate and mmap over.
> > > 
> > > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> > > Message-id: 20200220041118.23264-16-alxndr@bu.edu
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > 
> > Random drive-by observation:
> > 
> > > +++ b/tests/qtest/fuzz/fork_fuzz.ld
> > > @@ -0,0 +1,37 @@
> > > +/* We adjust linker script modification to place all of the stuff that needs to
> > > + * persist across fuzzing runs into a contiguous seciton of memory. Then, it is
> > 
> > section
> 
> Thanks, Eric!
> 
> Alex, please send follow-up patches to fix this typo and the 80
> character line limit issues identified by patchew (see patch email reply
> to this email thread).

Thank you Eric, Stefan!
Just sent out some fixes.

> Stefan



