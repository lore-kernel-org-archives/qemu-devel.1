Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331C3C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA3827C84
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA3827C84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXhYV-0007v4-7v
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:38:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXhXA-00079E-1n
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXhX8-0006yI-Pm
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXhWf-0005nY-BU; Mon, 03 Jun 2019 03:37:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D1CF81DFC;
	Mon,  3 Jun 2019 07:36:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 080211001DE0;
	Mon,  3 Jun 2019 07:36:39 +0000 (UTC)
Date: Mon, 3 Jun 2019 09:36:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190603073633.GA6523@linux.fritz.box>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-3-kwolf@redhat.com>
	<87y32w6kws.fsf@dusky.pond.sub.org>
	<20190529220945.GB3471@localhost.localdomain>
	<87a7ezuqfc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7ezuqfc.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 03 Jun 2019 07:36:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/qapi-schema: Test for good
 feature lists in structs
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.06.2019 um 08:35 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 24.05.2019 um 15:29 hat Markus Armbruster geschrieben:
> >> Let's add
> >> 
> >>    { 'command': 'test-features',
> >>      'data': { 'fs0': 'FeatureStruct0',
> >>                'fs1': 'FeatureStruct1',
> >>                'fs2': 'FeatureStruct2',
> >>                'fs3': 'FeatureStruct3',
> >>                'cfs1': 'CondFeatureStruct1',
> >>                'cfs2': 'CondFeatureStruct2',
> >>                'cfs3': 'CondFeatureStruct3' } }
> >> 
> >> because without it, the feature test cases won't generate introspection
> >> code.
> >
> > Of course, like everything else you requested, I'll just do this to get
> > the series off my table, but I'm still curious: Where would
> > introspection code ever be generated for the test cases? I saw neither
> > test code that generates the source files nor reference output that it
> > would be compared against.
> 
> Asking me to explain why I want something done when you can't see it
> yourself is much, much better than blindly implementing it.

Well, adding a command can't hurt anyway, so doing both in parallel
seemed like a good option. :-)

> Makefile.include feeds the two positive tests qapi-schema-test.json and
> doc-good.json to qapi-gen.py.
> 
> The .o for the former's .c get linked into a bunch of tests via Make
> variable $(test-qapi-obj-y).  One of them is test-qobject-input-visitor.
> Its test case "/visitor/input/qapi-introspect" checks the generated
> QObject conforms to the schema.
> 
> qapi-schema.json gets tested end-to-end instead: qmp-cmd-tests tests
> query-qmp-schema.
> 
> Both tests only check schema conformance, they don't compare to expected
> output.  Perhaps they should.  But I can still diff the generated
> qmp-introspect.c manually, which I routinely do when messing with the
> generator.
> 
> Makes sense?

Ah, so basically we don't fully check the correctness of the
introspection output, but just that two different generated files are
consistent with each other. Yes, makes sense.

I just didn't realise that the generated code is actually compiled and
linked to some other test cases. My expectation was the schema testing
was only in tests/qapi-schema/.

Kevin

