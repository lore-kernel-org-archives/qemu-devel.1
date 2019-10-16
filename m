Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A307ECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 03:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F407720854
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 03:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F407720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZam-0004SH-2M
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 23:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKZY9-0002qL-Fc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 23:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKZY7-0006hN-8R
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 23:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKZY7-0006gt-38
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 23:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E82B34627A;
 Wed, 16 Oct 2019 03:00:29 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5B1F60C57;
 Wed, 16 Oct 2019 03:00:23 +0000 (UTC)
Date: Wed, 16 Oct 2019 00:00:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Python 2 and test/vm/netbsd (was Re: [Qemu-devel] [PULL 0/8] Python
 queue, 2019-06-07)
Message-ID: <20191016030021.GD4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 16 Oct 2019 03:00:30 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
[...]
> > > The configure check also spits out deprecation warnings for
> > > the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
> > > to get those updated.
> > 
> > CCing the test/vm maintainers.
> > 
> > Fam, Alex, are you able to fix this and create new BSD VM images
> > with Python 3 available?  I thought the VM image configurations
> > were stored in the source tree, but they are downloaded from
> > download.patchew.org.
> 
> Fam, Alex, can you help us on this?  Python 2 won't be supported
> anymore, so we need the VM images to be updated.

Anyone?

I'm about to submit patches to remove Python 2 support, and this
will break tests/vm/netbsd.

I'm powerless to fix this issue, because the netbsd image is
hosted at download.patchew.org.

-- 
Eduardo

