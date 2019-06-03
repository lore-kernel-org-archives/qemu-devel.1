Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30249C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091CD27BFC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091CD27BFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgai-000408-AV
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:37:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXgZO-0003JQ-0z
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXgZN-000832-1c
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hXgZJ-0007j1-JK; Mon, 03 Jun 2019 02:35:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0754A5946A;
	Mon,  3 Jun 2019 06:35:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-223.ams2.redhat.com
	[10.36.117.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B9817F71;
	Mon,  3 Jun 2019 06:35:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 58A9A11386A0; Mon,  3 Jun 2019 08:35:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-3-kwolf@redhat.com>
	<87y32w6kws.fsf@dusky.pond.sub.org>
	<20190529220945.GB3471@localhost.localdomain>
Date: Mon, 03 Jun 2019 08:35:35 +0200
In-Reply-To: <20190529220945.GB3471@localhost.localdomain> (Kevin Wolf's
	message of "Thu, 30 May 2019 00:09:45 +0200")
Message-ID: <87a7ezuqfc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 03 Jun 2019 06:35:37 +0000 (UTC)
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 24.05.2019 um 15:29 hat Markus Armbruster geschrieben:
>> Let's add
>> 
>>    { 'command': 'test-features',
>>      'data': { 'fs0': 'FeatureStruct0',
>>                'fs1': 'FeatureStruct1',
>>                'fs2': 'FeatureStruct2',
>>                'fs3': 'FeatureStruct3',
>>                'cfs1': 'CondFeatureStruct1',
>>                'cfs2': 'CondFeatureStruct2',
>>                'cfs3': 'CondFeatureStruct3' } }
>> 
>> because without it, the feature test cases won't generate introspection
>> code.
>
> Of course, like everything else you requested, I'll just do this to get
> the series off my table, but I'm still curious: Where would
> introspection code ever be generated for the test cases? I saw neither
> test code that generates the source files nor reference output that it
> would be compared against.

Asking me to explain why I want something done when you can't see it
yourself is much, much better than blindly implementing it.

Makefile.include feeds the two positive tests qapi-schema-test.json and
doc-good.json to qapi-gen.py.

The .o for the former's .c get linked into a bunch of tests via Make
variable $(test-qapi-obj-y).  One of them is test-qobject-input-visitor.
Its test case "/visitor/input/qapi-introspect" checks the generated
QObject conforms to the schema.

qapi-schema.json gets tested end-to-end instead: qmp-cmd-tests tests
query-qmp-schema.

Both tests only check schema conformance, they don't compare to expected
output.  Perhaps they should.  But I can still diff the generated
qmp-introspect.c manually, which I routinely do when messing with the
generator.

Makes sense?

