Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27484206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McBg/SY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27484206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZajG-0002xb-Nr
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZaie-0002SX-Fp
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZaib-0005kC-HL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604326915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1R01ho6LubO5PxRNaNEYRFaokjRDfrVfD27cvCA9TY=;
 b=McBg/SY7C0CMWpUckx6c7vQ1sy4iZBvV/u7msJTkD0wFdMc2JdBLUW+bEYuU0ulge1l56Y
 VMRhjqbSgFKXOErkalkVl+jc0ClcZXPdZXKhgbw7NuoN28mFbxxdCRHq52YnD28jGZeQd6
 tCIvs1LYhAPqKfQ7z35D3Ite4O+cOTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-ve-6tnuwN1ikHQsax6EFtQ-1; Mon, 02 Nov 2020 09:21:44 -0500
X-MC-Unique: ve-6tnuwN1ikHQsax6EFtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3C8757052;
 Mon,  2 Nov 2020 14:21:42 +0000 (UTC)
Received: from redhat.com (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7504D5579F;
 Mon,  2 Nov 2020 14:21:37 +0000 (UTC)
Date: Mon, 2 Nov 2020 14:21:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] gitlab: publish the docs built during CI
Message-ID: <20201102142134.GC138796@redhat.com>
References: <20201102130926.161183-1-berrange@redhat.com>
 <20201102130926.161183-2-berrange@redhat.com>
 <e496d701-c943-6bac-073b-97a9bb7567f0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e496d701-c943-6bac-073b-97a9bb7567f0@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 02:50:19PM +0100, Philippe Mathieu-Daudé wrote:
> On 11/2/20 2:09 PM, Daniel P. Berrangé wrote:
> > Most of the build jobs will create the sphinx documentation. If we
> > expose this as an artifact of a "pages" job in a "public" directory, it
> > will get published using GitLab Pages. This means a user can push a
> > branch with docs changes to GitLab and view the results at
> > 
> >   https://yourusername.gitlab.io/qemu/
> 
> Do we want that only for forks or also for the main repo?
> 
> For the main repo we need to keep older releases archived
> but accessible.

I'm not suggesting we use this as the actual hosting we direct end
users to.

Instead, whatever cronjob on www.qemu.org currently builds

https://www.qemu.org/docs/master/

can simply download the published artifact from CI for the master
branch, and any release tags, and unpack them on www.qemu.org host.

IOW, we avoid need to run builds on www.qemu.org server.

> 
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.yml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index 3b15ae5c30..a41725d6f7 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -423,3 +423,17 @@ check-dco:
> >        - $CI_PROJECT_NAMESPACE == 'qemu-project' && $CI_COMMIT_BRANCH == 'master'
> >    variables:
> >      GIT_DEPTH: 1000
> > +
> > +pages:
> > +  image: $CI_REGISTRY_IMAGE/qemu/ubuntu2004:latest
> > +  stage: test
> > +  needs:
> > +    - job: build-system-ubuntu
> > +      artifacts: true
> > +  script:
> > +    - mkdir public
> 
> I'd rather use public/$CI_COMMIT_BRANCH, that way we can
> diff between 2 versions.
> 
> What about adding a manual job to clean public/$CI_COMMIT_BRANCH?
> (depending on push-pages success).

The publishing isn't additive - whatever is in the "public" dir
is exactly what is visible on gitlab pages. You can't publish
multiple different branches.

Essentially this "pages" job published an artifact containing
the entire content, and this is unpacked on the gitlab.io
service.

This is why I suggest www.qemu.org cronjob pull down the
artifact for "master", and also pull down the artifacts for
any release git tags, and unpack them in suitable subdirs.

> 
> > +    - mv build/docs/index.html public/
> > +    - for i in devel interop specs system tools user ; do mv build/docs/$i public/ ; done
> > +  artifacts:
> > +    paths:
> > +      - public

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


