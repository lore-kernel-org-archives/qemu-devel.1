Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07006C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC302087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsrbdKgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC302087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIt2f-000677-Nh
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIsy9-0001RW-7L
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIsy7-0003aI-D2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600345494;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68rzf0qFCAvhJVL17IFov/XZjTfm1/qeHx5V/g97HqA=;
 b=SsrbdKgkqBwCrHnlgcsZINLQxOd4Xf2epGDXYSAk5bgezsay4B+B03QxQw4UCWQ//YShbR
 pR2VPuCc1nmbys5yy38Xa0+t8u8rPpr5DktEF86A8QXRwDTte5DavBB89XxGlpGQE5EHab
 QutTPGgBzw28QO1cHi3AQyVeAZsA6rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-EsI2ihI0NLit7LZPULfxEw-1; Thu, 17 Sep 2020 08:24:52 -0400
X-MC-Unique: EsI2ihI0NLit7LZPULfxEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1304F9CC03;
 Thu, 17 Sep 2020 12:24:51 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEB4057;
 Thu, 17 Sep 2020 12:24:48 +0000 (UTC)
Date: Thu, 17 Sep 2020 13:24:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: QEMU policy for real file tests
Message-ID: <20200917122445.GB1597829@redhat.com>
References: <1836935.RIYQIvKipu@silver> <20200917093756.GC1568038@redhat.com>
 <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
 <2029663.ApTj1TM13Z@silver>
MIME-Version: 1.0
In-Reply-To: <2029663.ApTj1TM13Z@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 02:06:33PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 17. September 2020 11:55:00 CEST Thomas Huth wrote:
> > On 17/09/2020 11.37, Daniel P. Berrangé wrote:
> > > On Thu, Sep 17, 2020 at 10:26:36AM +0100, Alex Bennée wrote:
> > >> Christian Schoenebeck <qemu_oss@crudebyte.com> writes:
> > >>> Hi,
> > >>> 
> > >>> is there a QEMU policy for test cases that create/write/read/delete real
> > >>> files and directories? E.g. should they be situated at a certain
> > >>> location and is any measure of sandboxing required?
> > >> 
> > >> I don't think we have a hard and fast policy. It also depends on what
> > >> you are doing the test in - but ideally you should use a secure mktempd
> > >> (that can't clash) and clean-up after you are finished. This is a bit
> > >> easier in python than shell I think.
> > > 
> > > mktempd will end up on /tmp usually which can be tmpfs and size limited,
> > > so be mindful of the size of files you create. Don't assume you can
> > > create multi-GB sized files !  Creating a temp dir underneath the build
> > > dir (effectively CWD of the test) is a reasonable alternative.
> > 
> > Another thing to consider: If you want to create Unix sockets in your
> > tests, make sure that the file name does not get too long, since there
> > are limits on certain systems - i.e. socket files should be created in a
> > /tmp subdirectory, indeed.
> > 
> >  Thomas
> 
> These answers already cover everything I need right now. Thanks!
> 
> Final question: if at some later point one large file needs to be created for 
> some test case, is there some approximate size limit to stay below for not 
> causing issues with free CI cloud services?

A GIT source tree checkout of QEMU is approx 1 GB in size right now.
A build with just one target enable takes another 1 GB.
So if creating files in the source tree, or a build tree then, I'd
suggest a rule of thumb is to stay below that level as a rough
order of magnitude.

If creating in /tmp then stay below 100 MB, as it can be surprisingly
space constrained in some cases.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


