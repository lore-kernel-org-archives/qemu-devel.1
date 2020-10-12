Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B2F206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaGfiuMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B2F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyPz-0003UO-72
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kRyPK-00033b-48
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kRyPG-0002lK-CQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602511345;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L/wXbCRE8iNv5I0W7B2Jhs5nXE07UGP4/PXJKgWzv8s=;
 b=YaGfiuMxYETcBmzJtFBRamkXbvKEbGVOXOdD7692DXv0Tw4uIx8NCohpRVcY4FMd+BdosX
 vHPgs/eqVDSJ7Ql306M28W5IJPnspMhaan2mSffj/j6jEN3y2ypk0exXHM0trP5qDl5ql7
 7GFr3ioakDfSIN7R162rqsvX3NXQF4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-XpAcQafyO02hXKH34ecIEQ-1; Mon, 12 Oct 2020 10:02:17 -0400
X-MC-Unique: XpAcQafyO02hXKH34ecIEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EEEE835B4A;
 Mon, 12 Oct 2020 14:01:43 +0000 (UTC)
Received: from redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F42673669;
 Mon, 12 Oct 2020 14:01:33 +0000 (UTC)
Date: Mon, 12 Oct 2020 15:01:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 5/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
Message-ID: <20201012140131.GH39408@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
 <20200528101039.24600-6-thuth@redhat.com>
 <955bad5e-51ca-5b3f-c68f-a0374fc00a43@redhat.com>
MIME-Version: 1.0
In-Reply-To: <955bad5e-51ca-5b3f-c68f-a0374fc00a43@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 03:44:00PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Thomas, Alex,
> 
> +Daniel
> 
> On 5/28/20 12:10 PM, Thomas Huth wrote:
> > We have a dedicated folder for the gitlab-ci - so there is no need
> > to clutter the top directory with these .yml files.
> > 
> > Message-Id: <20200525131823.715-5-thuth@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml       | 0
> >   .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml | 0
> >   .gitlab-ci.yml                                     | 4 ++--
> >   MAINTAINERS                                        | 2 +-
> >   4 files changed, 3 insertions(+), 3 deletions(-)
> >   rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
> >   rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)
> > 
> > diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> > similarity index 100%
> > rename from .gitlab-ci-edk2.yml
> > rename to .gitlab-ci.d/edk2.yml
> > diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
> > similarity index 100%
> > rename from .gitlab-ci-opensbi.yml
> > rename to .gitlab-ci.d/opensbi.yml
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index bc6aee6aba..5208d93ff8 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -1,6 +1,6 @@
> >   include:
> > -  - local: '/.gitlab-ci-edk2.yml'
> > -  - local: '/.gitlab-ci-opensbi.yml'
> > +  - local: '/.gitlab-ci.d/edk2.yml'
> > +  - local: '/.gitlab-ci.d/opensbi.yml'
> 
> It seems these jobs are now always run, the "rules:changes"
> to restrict them is ignored.
> 
> I searched a bit and found a plausible explanation here:
> https://docs.gitlab.com/ee/ci/yaml/#onlychangesexceptchanges
> 
> "Caution: In pipelines with sources other than the three above changes can’t
> determine if a given file is new or old and always returns true. This
> includes pipelines triggered by pushing new tags. Configuring jobs to use
> only: changes with other only: refs keywords is possible, but not
> recommended."
> 
> I don't understand what they mean by "three", is a directory considered
> a three? Then that would explain the change.

The edk2.yml file as a "when: always" clause attached to every rule,
so surely this negates the point of filtering by making it always
run ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


