Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C051C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDA720709
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pl3+HAw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDA720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb0dQ-0001Qo-Eq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb0cY-0000vx-Pz
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:41:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb0cY-000145-1M
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589888476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j17fUJ26tORDLTqI3V3c/q/AV7YRR6+QCaef52qtFEA=;
 b=Pl3+HAw4tpPP5qUlzTlY6XSj6DE3bfLYSG3QgjSvDdZpPnUiyk5WiLvJ3e2IDqAximIF8e
 cepKwsHn//G5gZI8jwdhKnUhqhcoSLa2zf8EXM+KwHWE1VjYmRB3F5MCkZa4e/xza9Gc+p
 ObyxDn2OD3EIZVzVhOGAnU9qZgQ90/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-QmN8l6poPA6DFsBAibWCsQ-1; Tue, 19 May 2020 07:41:11 -0400
X-MC-Unique: QmN8l6poPA6DFsBAibWCsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C39F919057A6;
 Tue, 19 May 2020 11:41:10 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B881002395;
 Tue, 19 May 2020 11:41:08 +0000 (UTC)
Date: Tue, 19 May 2020 13:41:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
Message-ID: <20200519114107.GL7652@linux.fritz.box>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
 <20200515211505.3042-10-vsementsov@virtuozzo.com>
 <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
 <20200519090709.GC7652@linux.fritz.box>
 <2dfeb643-bbb2-d50b-d14c-ea2db04aa3c5@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <2dfeb643-bbb2-d50b-d14c-ea2db04aa3c5@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.05.2020 um 13:32 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 19.05.2020 12:07, Kevin Wolf wrote:
> > Am 18.05.2020 um 18:12 hat Thomas Huth geschrieben:
> > > On 15/05/2020 23.15, Vladimir Sementsov-Ogievskiy wrote:
> > > > Rename bitmaps migration tests and move them to tests subdirectory to
> > > > demonstrate new human-friendly test naming.
> > > > 
> > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > > > ---
> > > >   tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
> > > >   .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
> > > >   tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
> > > >   tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
> > > >   4 files changed, 0 insertions(+), 0 deletions(-)
> > > >   rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
> > > >   rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
> > > >   rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
> > > >   rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
> > > > 
> > > > diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> > > > similarity index 100%
> > > > rename from tests/qemu-iotests/199
> > > > rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> > > > diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
> > > > similarity index 100%
> > > > rename from tests/qemu-iotests/199.out
> > > > rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
> > > > diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
> > > > similarity index 100%
> > > > rename from tests/qemu-iotests/169
> > > > rename to tests/qemu-iotests/tests/migrate-bitmaps-test
> > > > diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
> > > > similarity index 100%
> > > > rename from tests/qemu-iotests/169.out
> > > > rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
> > > 
> > > I like the idea ... but the path name + file names get now quite long.
> > > While you're at it, what about renaming the "qemu-iotests" directory to
> > > just "iotests" or even just "io" now?
> > 
> > Renames are always kind of painful. Do we have a real reason for the
> > rename except that the paths feel a bit long subjectively?
> > 
> > Of course, if we're renaming all files anyway, changing the directory
> > name at the same time shouldn't give any additional pain, so it would be
> > completely reasonable then. We're not renaming the test harness files,
> > though, and even only two test cases in this patch.
> > 
> > Maybe this final patch should stay RFC until we have the infrastructure
> > in and then we can have a single series that moves all tests and also
> > renames the directory? Maybe a not strictly necessary rename of the
> > tooling would be bearable in the context of a mass rename of tests.
> 
> I'm absolutely not hurrying about this thing. And actual aim of the
> series is another. I even doubt that we will mass rename the tests:
> who knows what they all test?) I don't.

Good point.

And conversely, there are a few test cases that I do know (like 026 030
040 041 055) and probably wouldn't recognise for a while after a rename.
:-)

> Still we may rename some tests, and we'll create new named tests which
> is good enough.. OK, if I resend a new version, I'll add an RFC patch
> on renaming the directory, up to maintainers, take it now or not :)

I guess a final patch to rename the directory as an RFC makes sense.
Then we can continue the discussion there and decide whether or not to
apply it without holding up the rest of the series.

I think I would be inclined to leave the name unchanged as long as we
don't have a real reason, but if people overwhelmingly think otherwise,
we can still rename.

Kevin


