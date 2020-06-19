Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042F5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72F0204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmiT5fll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72F0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmK9r-0001PB-Vb
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jmK8u-0008En-Hw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:45:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jmK8q-0000Ya-NE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592585123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGia6quD0aHUBF5knc8wahwIBUtGXg12w+qzbmZQEWg=;
 b=QmiT5fllEk5wMmdMGvT8ekY0L/tRAcOybOZZCxxyFlpk2uErwlRHSz2dccB2nXxw/l5Dey
 KZpqHSKkCf5zC9r8WDUygwY75M0zqyzAqwBBgS3SdwfZ7L6M3r1pmgol2hWpEndAJDONDH
 QBUzmbz4/Y8S1ydyz9SY+4+2/+brxls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-FXzeXrcOMamAkaj4JN-sEQ-1; Fri, 19 Jun 2020 12:45:20 -0400
X-MC-Unique: FXzeXrcOMamAkaj4JN-sEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CA36A0BD9;
 Fri, 19 Jun 2020 16:45:19 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-17.ams2.redhat.com [10.36.114.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 324355C298;
 Fri, 19 Jun 2020 16:45:00 +0000 (UTC)
Date: Fri, 19 Jun 2020 18:44:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/7] python: create installable package
Message-ID: <20200619164459.GD5036@linux.fritz.box>
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200617195241.GA434320@localhost.localdomain>
 <32791435-4aa4-7eaa-e2c6-b53165f2e28d@redhat.com>
 <20200618092319.GA6012@linux.fritz.box>
 <5944404f-3833-3bc5-d3e4-1cf459b4c0c1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5944404f-3833-3bc5-d3e4-1cf459b4c0c1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.06.2020 um 17:04 hat John Snow geschrieben:
> On 6/18/20 5:23 AM, Kevin Wolf wrote:
> > Am 17.06.2020 um 22:27 hat John Snow geschrieben:
> >>> In the Avocado project, we have a `make develop` rule that does that
> >>> for the main setup.py file, and for all plugins we carry on the same
> >>> tree, which is similar in some regards to the "not at the project root
> >>> directory" situation here with "qemu/python/setup.py".
> >>>
> >>
> >> Ah, yeah. If we're going this far, I'd prefer using a VENV over
> >> modifying the user's environment. That way you can blast it all away
> >> with a `make distclean`.
> >>
> >> Maybe the "make develop" target could even use the presence of a .venv
> >> directory to know when it needs to make the environment or not ...
> > [..]
> >> For QEMU developers, installing with develop is going to be the smart
> >> way to go. When your git tree is updated, your package will be updated
> >> along with it. You can do it once and then probably forget about it.
> > 
> > I don't think we can make this a manual step at all. Building QEMU
> > requires running some Python scripts (e.g. the QAPI generator), so the
> > setup needs to be done either in configure or in a Makefile target that
> > is specified as a dependency of any rule that would run a Python script.
> > Building QEMU once would then be enough.
> 
> I am imagining that we might treat "building" and "testing" separately
> -- as it is, builds require python3.5 and tests requires 3.6 which
> definitely necessitates two distinct environments.

I'm not sure what the exact definition of "end of life" of a distro is
that we're using. I seem to remember that the reason for using Python
3.5 was Debian Stretch. Its official end of life is in about three
weeks, but then there is still some LTS thing with reduced support done
by a different group.

If we read our policy literally and use the regular end of life, I guess
we could just move QEMU to 3.6 for everything.

> I will admit that I haven't constructed a full, coherent vision of
> python management that encapsulates both building ad testing yet. For
> example, should configure/make expect to be run inside of a venv, or
> should they expect to create and then enter the venv? That's not clear
> to me yet. I'm simultaneously trying to work out with Peter Maydell how
> the sphinx dependency should work. Sphinx is presently our only python
> dependency for our build environment.)

It's kind of obvious that this can't require user interaction because we
want ./configure; make to work. So I guess this means the venv needs to
be set up automatically by configure/make?

> Perhaps starting with the testing step is a good starting point and we
> can use an implicit dependency on a `make develop` style step so it
> happens automatically.
> 
> (But perhaps keeping it as a standalone target that CAN be invoked
> manually would be nice if you want to do some more intensive debugging
> or development of new tests.)

Yes. And you'll have many dependencies on it, so it would be a separate
target anyway.

> > Doing it automatically also means that we have to keep things local to
> > the QEMU directory rather than installing them globally into the user
> > directory. This is desirable anyway: Most of us deal with more than one
> > QEMU source tree, so conflicts would be inevitable.
> 
> I think it should be easy enough to put the VENV in the build directory
> to prevent cross-contamination.

Sure. I'm not overly familiar with all of this, but I guess my point was
just that a venv is needed rather than a global installation into the
user directory. If nobody ever suggested the latter, blame the
misunderstanding on my non-existent experience with more complex Python
setups.

Kevin


