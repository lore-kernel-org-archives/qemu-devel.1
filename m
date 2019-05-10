Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988CBC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E548216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E548216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6Qy-0007Nb-M8
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:23:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP6P7-0006BX-1u
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP6P5-0008KB-55
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:21:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP6P1-0008HP-75; Fri, 10 May 2019 10:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B684D307EAA3;
	Fri, 10 May 2019 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2AB5D9D5;
	Fri, 10 May 2019 14:21:24 +0000 (UTC)
Date: Fri, 10 May 2019 16:21:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190510142122.GC5887@localhost.localdomain>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-7-thuth@redhat.com>
	<87ef5acsce.fsf@dusky.pond.sub.org>
	<b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
	<3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
	<44a3ebee-c717-d953-8e89-c24da99209a6@redhat.com>
	<f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 10 May 2019 14:21:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-block@nongnu.org,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.05.2019 um 10:55 hat Thomas Huth geschrieben:
> On 08/05/2019 07.47, Thomas Huth wrote:
> > On 07/05/2019 17.50, Eric Blake wrote:
> >> On 5/7/19 10:22 AM, Thomas Huth wrote:
> >>> On 07/05/2019 15.22, Markus Armbruster wrote:
> >>>> Thomas Huth <thuth@redhat.com> writes:
> >>>>
> >>>>> Currently, all tests are in the "auto" group. This is a little bit pointless.
> >>>>> OTOH, we need a group for the tests that we can automatically run during
> >>>>> "make check" each time, too. Tests in this new group are supposed to run
> >>>>> with every possible QEMU configuration, for example they must run with every
> >>>>> QEMU binary (also non-x86), without failing when an optional features is
> >>>>> missing (but reporting "skip" is ok), and be able to run on all kind of host
> >>>>> filesystems and users (i.e. also as "nobody" or "root").
> >>>>> So let's use the "auto" group for this class of tests now. The initial
> >>>>> list has been determined by running the iotests with non-x86 QEMU targets
> >>>>> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. including
> >>>>> macOS and FreeBSD).
> >>>>
> >>>> I wonder whether we should additionally limit "make check" to "quick"
> >>>> tests.  How slow are the non-quick auto tests for you?
> >>>
> >>> I already sorted out some of the tests that run veeeery long, since the
> >>> run time on gitlab, cirrus-ci and travis is limited. "make check-block"
> >>> currently takes 3 minutes on my laptop, I think that's still ok?
> >>>
> >>> When I run the tests from the auto group that are not in the quick
> >>> group, I currently get:
> >>>
> >>
> >> My personal threshold is about 5 seconds for quick, so:
> >>
> >>> 003 1s ...
> >>> 007 2s ...
> >>
> >> Should these be moved to quick?
> > 
> > I'll leave that decision up to the blocklayer folks ... I thought that
> > there might have been a different reason that these have not been put
> > into "quick" yet...?
> > 
> >>> 013 5s ...
> >>
> >> this one is borderline
> >>
> >>> 014 15s ...
> >>> 015 9s ...
> >>
> >> Definitely not quick, but if you think they are still okay for auto, I
> >> can live with that.
> >>
> >>> 022 1s ...
> >>
> >> Another candidate for quick?
> >>
> >>> 023 18s ...
> >>
> >> Even longer than 14. Okay for auto?
> > 
> > I think I'd give it a try. If people are complaining later that "make
> > check" is running now way too long, we still can refine the list later.
> 
> Thinking about this again, "make check" now runs quite a bit longer
> indeed. So I now rather tend to remove the tests that run longer than 5s
> from the auto group instead... I think I'll send a v4 of this patch
> where I'll remove them from the auto group.

I don't think time is everything. We should also consider how much
the tests contribute to basic code coverage. There is no point in
removing a test from the list because it takes 10 seconds, but if I
split it in two tests taking each 5 seconds, you would include both
halves.

For example, 030, 040 and 041 are not that quick (14/11/42 seconds,
respectively), but they are the most important tests for block jobs and
covering a lot. Sure, 42 seconds is a lot, but I'd keep 030 and 040 at
least.

Kevin

