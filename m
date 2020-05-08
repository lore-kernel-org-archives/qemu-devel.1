Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B310C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45283207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/n/5SQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45283207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyhl-0007ih-El
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWyh2-0007ED-OP
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:49:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWyh1-0007ot-4z
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588927753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=np32KWlFHp/R5FBTcBUL+ha2Z3sdT8VN0/nqzfEWOng=;
 b=F/n/5SQrX1VFDkXBgSlEeTwEc0Z7QkTpEWMJbKqb8dYcOTOTDURSv4Agydbk5ihCOhuZqW
 3e4krEnt59P7+ZSCwV3WeCq7C6fUKx5tid6q8coy9Cf7v0KrAr/TSqtHD44QUjrI3TgCzK
 IIYWZCmVMhx28YM9fFwdr0NxdJOD8i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-azftg7yxMySNEu8l5cYMKg-1; Fri, 08 May 2020 04:49:09 -0400
X-MC-Unique: azftg7yxMySNEu8l5cYMKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18BA5EC1A2;
 Fri,  8 May 2020 08:49:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-190.ams2.redhat.com [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02CDE1001920;
 Fri,  8 May 2020 08:49:04 +0000 (UTC)
Date: Fri, 8 May 2020 10:49:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
Message-ID: <20200508084903.GA4970@linux.fritz.box>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <5a185a4e-1c5d-9887-c88c-6ca71ebeeee1@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.05.2020 um 19:43 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 21.04.2020 19:56, Kevin Wolf wrote:
> > Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Add python script with new logic of searching for tests:
> > >=20
> > > Current ./check behavior:
> > >   - tests are named [0-9][0-9][0-9]
> > >   - tests must be registered in group file (even if test doesn't belo=
ng
> > >     to any group, like 142)
> > >=20
> > > Behavior of new test:
> > >   - group file is dropped
> > >   - tests are searched by file-name instead of group file, so it's no=
t
> > >     needed more to "register the test", just create it with name
> > >     *-test. Old names like [0-9][0-9][0-9] are supported too, but not
> > >     recommended for new tests
> >=20
> > I wonder if a tests/ subdirectory instead of the -test suffix would
> > organise things a bit better.
> >=20
>=20
> It will make more difficult to import iotests.py.. Calling common.rc from
> bash tests will need to be modified too.
>=20
> So, we'll need additional line in all python tests:
>=20
> sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

Hm, yes, this is nasty.

Would it be any better have a wrapper script that just imports the
actual test so that the import path would still contain the main
qemu-iotests/ directory?

> which doesn't seem to be good practice.. So, instead we'd better call
> tests with PYTHONPATH set appropriately..

This is another option, especially if we do want to create a lib/.

> and modify bash tests to do
> . ../common.rc
> . ../common.filter
> <etc>
>=20
> or again, better to export BASH_TEST_LIB directory.

I don't think this is necessary because the working directory wouldn't
change, so bash scripts should just keep working as before.

> Is it worth doing?
>=20
> I think, there are two variants:
>=20
> 1) keep as is: all in one directory, add *-test notation

I think it would make it rather hard to find the files that belong to
the test harness implementation between all the tests. Currently, 'ls'
in the qemu-iotests directory is still kind of usable because all the
test cases are at the start and everything that comes later is not a
test.

> 2) go further and restructure to something like:
>=20
> iotests/<only check script and its dependencies here>
> iotests/tests/<all-tests-here>
> iotests/lib/python/iotests.py
> iotests/lib/bash/<common.rc and friends here>
>=20
> And then, check script will export PYTHONPATH and BASH_TEST_LIB
> variables.

I think leaving everything except named tests where it is, but setting
PYTHONPATH or having a wrapper script, is still a third option that's
worth considering. It sounds like the most attrative option to me.

Kevin


