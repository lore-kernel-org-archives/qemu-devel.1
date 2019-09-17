Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C903AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD5F206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD5F206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAN43-0004kb-M4
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iAN2r-0003c7-MY
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iAN2q-0000D4-0l
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iAN2p-0000Cj-Oy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD39A30821AE;
 Tue, 17 Sep 2019 23:38:02 +0000 (UTC)
Received: from localhost (ovpn-116-86.gru2.redhat.com [10.97.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F8C860BFB;
 Tue, 17 Sep 2019 23:37:59 +0000 (UTC)
Date: Tue, 17 Sep 2019 20:37:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190917233758.GL4082@habkost.net>
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <CAFEAcA9ZeB1knLYYQLJG0d5McG2vo6w8P9+vOBWgtSVgPEG0jA@mail.gmail.com>
 <20190611160329.GH5927@habkost.net>
 <CAFEAcA-cv8vPT=7YraioJvW7-WnvGy9YoJXOc_E+UEWUehE+Bg@mail.gmail.com>
 <20190611171257.GI5927@habkost.net>
 <20190917135726.GD4824@localhost.localdomain>
 <20190917214808.GH4082@habkost.net>
 <a6bc1eba-c088-43bf-fa90-e2139c6a6fef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bc1eba-c088-43bf-fa90-e2139c6a6fef@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 17 Sep 2019 23:38:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, mreitz@redhat.com,
 Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 07:10:13PM -0400, John Snow wrote:
> On 9/17/19 5:48 PM, Eduardo Habkost wrote:
> > On Tue, Sep 17, 2019 at 03:57:26PM +0200, Kevin Wolf wrote:
> >> Am 11.06.2019 um 19:12 hat Eduardo Habkost geschrieben:
> >>> On Tue, Jun 11, 2019 at 05:07:55PM +0100, Peter Maydell wrote:
> >>>> On Tue, 11 Jun 2019 at 17:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>>>>
> >>>>> On Tue, Jun 11, 2019 at 04:50:34PM +0100, Peter Maydell wrote:
> >>>>>> On Mon, 10 Jun 2019 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>>>>>> Hi. This fails to build on one of my buildtest machines:
> >>>>>>>
> >>>>>>> ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> >>>>>>>        Use --python=/path/to/python to specify a supported Python.
> >>>>>>>
> >>>>>>> The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> >>>>>>> box; it's one of the gcc compile farm machines so upgrades to its
> >>>>>>> OS are not really under my control.)
> >>>>>>
> >>>>>> Rereading this, I realise that either the check or the error
> >>>>>> message is wrong here. The machine has 2.7.6, which satisfies
> >>>>>> "python 2 >= 2.7", so we should be OK to build. The bug
> >>>>>> seems to be that we say "prefer python3 over plain python
> >>>>>> on python2" early, but don't revisit that decision if the
> >>>>>> python3 we found isn't actually good enough for us.
> >>>>>
> >>>>> Right.  The error message is technically correct, but misleading.
> >>>>> python3 is too old, but python2 would work.
> >>>>>
> >>>>> We can make configure not use python3 by default if it's too old,
> >>>>> and fall back to python2 in this case.
> >>>>
> >>>> Sounds good. Since I have now managed to get my alternate
> >>>> aarch64 box set up, how about I apply this pullreq and you
> >>>> send a followup patch which does the fallback to python/python2 ?
> >>>
> >>> I will remove the python2/python3 patches and send a new pull
> >>> request.
> >>
> >> What is the plan forward with this? Are the patches dropped for good?
> >>
> >> I think the plan was to drop Python 2 after QEMU 4.2, and then it
> >> becomes really relevant what our minimum Python 3 version is. We've just
> >> had another Python version discussion in the context of iotests (John
> >> suggested using function annotations, but these are >= 3.5 only).
> >>
> >> Also, the fallback to Python 2 obviously makes no sense any more then,
> >> so maybe it's not that important to add for a single QEMU release?
> >>
> >> As Peter seems to have indicated above that he found a replacement for
> >> the test machine with an OS that isn't out of support, can we just
> >> revive this patch as it is?
> > 
> > My plan is to remove Python 2 support in QEMU 4.2 (making the
> > fallback to Python 2 a non-issue), and require Python >= 3.5.
> > 
> > Now, even if my plan is rejected and we keep supporting Python 2
> > when building QEMU 4.2, my suggestion for the iotest maintainers
> > is to make it require Python 3.5+ immediately, just like we do
> > for tests/acceptance.  I don't see why we should keep wasting our
> > energy supporting ancient Python versions in a test suite that is
> > not a requirement for building QEMU.
> > 
> 
> It's unfortunately now part of the 'make check' target which we use in
> the vm tests as a default target ... but I think we can make the push to
> change the build requires to 3.5+.

In the worst case, we can make "make check" skip iotests if
Python 2 is detected (after printing a warning).  But requiring
3.5+ for the build would really be the best option.

I've just restarted the thread about Python 2 in tests/vm:
https://lore.kernel.org/qemu-devel/20190917233140.GK4082@habkost.net/

-- 
Eduardo

