Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BEC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2072067B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 07:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2072067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAUnd-0004x8-6V
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 03:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAUjf-00030S-9w
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAUjd-0008LA-R5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iAUjd-0008KY-IW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82A653082145;
 Wed, 18 Sep 2019 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-230.ams2.redhat.com
 [10.36.116.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8753600C8;
 Wed, 18 Sep 2019 07:50:40 +0000 (UTC)
Date: Wed, 18 Sep 2019 09:50:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190918075039.GB5207@localhost.localdomain>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
 <20190611160329.GH5927@habkost.net>
 <CAFEAcA-cv8vPT=7YraioJvW7-WnvGy9YoJXOc_E+UEWUehE+Bg@mail.gmail.com>
 <20190611171257.GI5927@habkost.net>
 <20190917135726.GD4824@localhost.localdomain>
 <20190917214808.GH4082@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917214808.GH4082@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 18 Sep 2019 07:50:44 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, mreitz@redhat.com,
 jsnow@redhat.com, QEMU Developers <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.09.2019 um 23:48 hat Eduardo Habkost geschrieben:
> On Tue, Sep 17, 2019 at 03:57:26PM +0200, Kevin Wolf wrote:
> > Am 11.06.2019 um 19:12 hat Eduardo Habkost geschrieben:
> > > On Tue, Jun 11, 2019 at 05:07:55PM +0100, Peter Maydell wrote:
> > > > On Tue, 11 Jun 2019 at 17:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 11, 2019 at 04:50:34PM +0100, Peter Maydell wrote:
> > > > > > On Mon, 10 Jun 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > > > > Hi. This fails to build on one of my buildtest machines:
> > > > > > >
> > > > > > > ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> > > > > > >        Use --python=/path/to/python to specify a supported Python.
> > > > > > >
> > > > > > > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > > > > > > box; it's one of the gcc compile farm machines so upgrades to its
> > > > > > > OS are not really under my control.)
> > > > > >
> > > > > > Rereading this, I realise that either the check or the error
> > > > > > message is wrong here. The machine has 2.7.6, which satisfies
> > > > > > "python 2 >= 2.7", so we should be OK to build. The bug
> > > > > > seems to be that we say "prefer python3 over plain python
> > > > > > on python2" early, but don't revisit that decision if the
> > > > > > python3 we found isn't actually good enough for us.
> > > > >
> > > > > Right.  The error message is technically correct, but misleading.
> > > > > python3 is too old, but python2 would work.
> > > > >
> > > > > We can make configure not use python3 by default if it's too old,
> > > > > and fall back to python2 in this case.
> > > > 
> > > > Sounds good. Since I have now managed to get my alternate
> > > > aarch64 box set up, how about I apply this pullreq and you
> > > > send a followup patch which does the fallback to python/python2 ?
> > > 
> > > I will remove the python2/python3 patches and send a new pull
> > > request.
> > 
> > What is the plan forward with this? Are the patches dropped for good?
> > 
> > I think the plan was to drop Python 2 after QEMU 4.2, and then it
> > becomes really relevant what our minimum Python 3 version is. We've just
> > had another Python version discussion in the context of iotests (John
> > suggested using function annotations, but these are >= 3.5 only).
> > 
> > Also, the fallback to Python 2 obviously makes no sense any more then,
> > so maybe it's not that important to add for a single QEMU release?
> > 
> > As Peter seems to have indicated above that he found a replacement for
> > the test machine with an OS that isn't out of support, can we just
> > revive this patch as it is?
> 
> My plan is to remove Python 2 support in QEMU 4.2 (making the
> fallback to Python 2 a non-issue), and require Python >= 3.5.

Then I think it would be best to make (or propose at least) that change
early in the release cycle. In other words, now. :-)

> Now, even if my plan is rejected and we keep supporting Python 2
> when building QEMU 4.2, my suggestion for the iotest maintainers
> is to make it require Python 3.5+ immediately, just like we do
> for tests/acceptance.  I don't see why we should keep wasting our
> energy supporting ancient Python versions in a test suite that is
> not a requirement for building QEMU.

Okay, if you as the Python maintainer say so, I'll gladly follow your
advice.

Maybe we can modify iotests so that it just skips Python tests if the
minimum version isn't available to keep the impact of deviating from the
global minimum version as small as possible. Of course, this will only
be necessary if your proposal to make 3.5 the minimum for all of QEMU is
rejected.

Kevin

