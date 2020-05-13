Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E41CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB00E204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOH4TjgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB00E204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsHZ-0006d3-4t
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYsGp-0005dt-IH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:22:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYsGo-00082V-GH
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtjbMMUyZEHTAbWhJkpg5xpJ0LOxw8U3skZEitllsgs=;
 b=fOH4TjgSrP6M2I08rZvSbjrZF228I1aJMag+2uqVSiW8x0dOwBJQdDBqycKzaQF998wX5Q
 lXefVInamlZtb1ihbSD4wrJtPqefngwv0kaW/28PZYI2KzfuJ1ZKJ50Fuux+uhDtaLzMnH
 R2PjlVnWBem5UUSzcQtThnHN4uP6R0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-USIYScjtOaKvmNClffCzsw-1; Wed, 13 May 2020 10:21:57 -0400
X-MC-Unique: USIYScjtOaKvmNClffCzsw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DE018FF661;
 Wed, 13 May 2020 14:21:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32BB66A94A;
 Wed, 13 May 2020 14:21:55 +0000 (UTC)
Date: Wed, 13 May 2020 16:21:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 4/4] iotests: Mirror with different source/target size
Message-ID: <20200513142153.GI6202@linux.fritz.box>
References: <20200511135825.219437-1-kwolf@redhat.com>
 <20200511135825.219437-5-kwolf@redhat.com>
 <bb5b1e29-652f-6765-edb7-55a7fb63328d@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <bb5b1e29-652f-6765-edb7-55a7fb63328d@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.05.2020 um 13:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 11.05.2020 16:58, Kevin Wolf wrote:
> > This tests that the mirror job catches situations where the target node
> > has a different size than the source node. It must also forbid resize
> > operations when the job is already running.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Message-Id: <20200507145228.323412-4-kwolf@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> > ---
> >   tests/qemu-iotests/041     | 45 ++++++++++++++++++++++++++++++++++++++
> >   tests/qemu-iotests/041.out |  4 ++--
> >   2 files changed, 47 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> > index 1812dd8479..601c756117 100755
> > --- a/tests/qemu-iotests/041
> > +++ b/tests/qemu-iotests/041
> > @@ -240,6 +240,49 @@ class TestSingleBlockdev(TestSingleDrive):
> 
> 
> Hmm, probably resize tests would be good in the TestSingleDrive, to
> cover drive-mirror too. Still, there shouldn't be any difference.. So,
> I don't think it worth doing.

At first, I tried to do a single implementation that works for both, but
it wasn't easily possible. I'm not sure any more if it was the only
problem, but at least drive-mirror targets don't have a known node-name,
so we would have to guess it from query-named-block-nodes. Not
impossible, but maybe not worth it...

> >                                target=self.qmp_target)
> >           self.assert_qmp(result, 'error/class', 'GenericError')
> > +    def do_test_resize(self, device, node):
> > +        def pre_finalize():
> 
> [..]
> 
> > +    def do_test_target_size(self, size):
> > +        result = self.vm.qmp('block_resize', node_name=self.qmp_target,
> > +                             size=size)
> > +        self.assert_qmp(result, 'return', {})
> > +
> > +        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
> > +                             device='drive0', sync='full', auto_dismiss=False,
> > +                             target=self.qmp_target)
> > +        self.assert_qmp(result, 'return', {})
> > +
> > +        result = self.vm.run_job('job0')
> > +        self.assertEqual(result, 'Source and target image have different sizes')
> 
> Hmm, and this proves, that we are not very good with handling early
> errors. A lot better would be to fail earlier, on blockdev-mirror
> command. And, as shown by your previous series, backup works better in
> this case. But again, it's for another series.

At least it shows that errp does make it to the client. :-)

I'm not sure which way is currently better. QMP handlers are still
synchronous code that blocks the rest of QEMU, so doing things only
inside the coroutine does have some benefits. Maybe with coroutine QMP
handlers this will become less of a concern, though.

Kevin


