Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2870CC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C8820760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c++5zaW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C8820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3xl-0007j6-6p
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw3x8-00073w-2F
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:29:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jw3x6-0003fg-Io
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594906171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sppEimTEFDUxTLzKJ06AsEIrt8C64AnKlGQ88smCofM=;
 b=c++5zaW9LMt9WYohBi9uPIYAFmKD24yzjz/4wic0PsYAOHJ8gqToe5zWa+J5jbs1v/fBn5
 cgRo4EdqYZZLnXmJM9M3m68iF4ge6OYtgjVB4A0cdgsQrHtjei092V0lA7Za8j6Osy1RiI
 /S7sBAC1YWeLquca1MM5fMbfL8tKgms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-Ue2ANscOPFypiNako3M35g-1; Thu, 16 Jul 2020 09:29:27 -0400
X-MC-Unique: Ue2ANscOPFypiNako3M35g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C91C80183C;
 Thu, 16 Jul 2020 13:29:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-172.ams2.redhat.com [10.36.114.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA6E219D61;
 Thu, 16 Jul 2020 13:29:21 +0000 (UTC)
Date: Thu, 16 Jul 2020 15:29:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/12] Block patches
Message-ID: <20200716132920.GA4498@linux.fritz.box>
References: <20200624100210.59975-1-stefanha@redhat.com>
 <CAFEAcA_K7MtnEjRMZCbmYrJCm6qD4N7ZMHvGuAzXL9gD2zQNuA@mail.gmail.com>
 <20200626102506.GD281902@stefanha-x1.localdomain>
 <cab22670-6804-9ddc-c3ee-b6dcf3a74ac4@redhat.com>
 <20200707220514.GY7276@habkost.net>
 <20200709150206.GC4096@linux.fritz.box>
 <CAFEAcA9r2_O8wZQUAbEb46uwm-HkmnDD8Cv7b0fA2q-Vm7_Mag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9r2_O8wZQUAbEb46uwm-HkmnDD8Cv7b0fA2q-Vm7_Mag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 09:29:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.07.2020 um 14:40 hat Peter Maydell geschrieben:
> On Thu, 9 Jul 2020 at 16:02, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > We can "fix" it for probably all realistic cases by lowering the speed
> > of the block job significantly. It's still not fully fixed for all
> > theoretical cases, but the pattern of starting a block job that is
> > throttled to a low speed so it will keep running for the next part of
> > the test is very common.
> >
> > Kevin
> >
> > diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> > index 256b2bfbc6..31c028306b 100755
> > --- a/tests/qemu-iotests/030
> > +++ b/tests/qemu-iotests/030
> > @@ -243,7 +243,7 @@ class TestParallelOps(iotests.QMPTestCase):
> >              node_name = 'node%d' % i
> >              job_id = 'stream-%s' % node_name
> >              pending_jobs.append(job_id)
> > -            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=512*1024)
> > +            result = self.vm.qmp('block-stream', device=node_name, job_id=job_id, base=self.imgs[i-2], speed=1024)
> >              self.assert_qmp(result, 'return', {})
> >
> >          for job in pending_jobs:
> 
> Any chance we could get this fix into the tree? I've just
> had an unrelated mergebuild test run hit this iotest 030
> failure again...

Sure. I sent a proper patch so I can include it in my next pull request
(probably tomorrow).

Kevin


