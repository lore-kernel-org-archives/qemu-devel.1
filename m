Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D63C0650E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E81A2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E81A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajYp-0001hj-8K
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40148)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hajFb-0003SQ-Lc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hajFV-0002iU-PF
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hajFS-0002aO-2t
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:03:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A12FB8552E;
 Tue, 11 Jun 2019 16:03:31 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18EEF5B681;
 Tue, 11 Jun 2019 16:03:30 +0000 (UTC)
Date: Tue, 11 Jun 2019 13:03:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190611160329.GH5927@habkost.net>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 11 Jun 2019 16:03:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 04:50:34PM +0100, Peter Maydell wrote:
> On Mon, 10 Jun 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hi. This fails to build on one of my buildtest machines:
> >
> > ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> >        Use --python=/path/to/python to specify a supported Python.
> >
> > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > box; it's one of the gcc compile farm machines so upgrades to its
> > OS are not really under my control.)
> 
> Rereading this, I realise that either the check or the error
> message is wrong here. The machine has 2.7.6, which satisfies
> "python 2 >= 2.7", so we should be OK to build. The bug
> seems to be that we say "prefer python3 over plain python
> on python2" early, but don't revisit that decision if the
> python3 we found isn't actually good enough for us.

Right.  The error message is technically correct, but misleading.
python3 is too old, but python2 would work.

We can make configure not use python3 by default if it's too old,
and fall back to python2 in this case.

-- 
Eduardo

