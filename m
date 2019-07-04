Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93998C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 21:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B8621852
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 21:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8621852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj9JF-0000Jt-Tx
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 17:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <SRS0=jKHg=VB=redhat.com=mst@kernel.org>)
 id 1hj9IV-0008Iz-2Q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <SRS0=jKHg=VB=redhat.com=mst@kernel.org>)
 id 1hj9IT-0004y9-EY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <SRS0=jKHg=VB=redhat.com=mst@kernel.org>)
 id 1hj9IT-0004xS-97
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 17:29:41 -0400
Received: from redhat.com (bzq-79-182-9-81.red.bezeqint.net [79.182.9.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA4EF21852;
 Thu,  4 Jul 2019 21:29:38 +0000 (UTC)
Date: Thu, 4 Jul 2019 17:29:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190704172822-mutt-send-email-mst@kernel.org>
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA8ZAHK4bMMUqNU++9h3AN3arOLMcZgUStd5OP_JCEzObQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8ZAHK4bMMUqNU++9h3AN3arOLMcZgUStd5OP_JCEzObQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 198.145.29.99
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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

On Thu, Jul 04, 2019 at 10:25:48AM +0100, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
> >
> >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-24' into staging (2019-07-01 11:28:28 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:
> >
> >   docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 10:39:35 -0400)
> >
> > ----------------------------------------------------------------
> > virtio, pc, pci: features, fixes, cleanups
> >
> > virtio-pmem support.
> > libvhost user mq support.
> > A bunch of fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> This fails to build on all the non-Linux platforms:
> 
> In file included from
> /Users/pm215/src/qemu-for-merges/hw/virtio/virtio-pmem.c:21:
> /Users/pm215/src/qemu-for-merges/include/standard-headers/linux/virtio_pmem.h:13:10:
> fatal error: 'linux/types.h' file not found
> #include <linux/types.h>
>          ^~~~~~~~~~~~~~~
> 
> thanks
> -- PMM

Amended and re-pushed. Pls try again, sorry about that.

-- 
MST

