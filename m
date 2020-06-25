Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3051C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF1820767
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBz0CnWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF1820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSuB-0007ys-Ql
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joSt7-00072p-Ny
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:30:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joSt4-0007Nw-DT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593095396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X81vk2oCUMoJ6a0YTN+RsvApetcAA/vijrZBeZk31m8=;
 b=aBz0CnWNmofmv9GaR+z9hZ1GtDto9UnQe6Ov33ndTqNcoVYkfEn3RbmdG50YELUilqO/2p
 1qN4iq4/ExzEwIEm0LIQV6GQL8jwj0pq9fO/fcK4xFvTHHqx/jm3i/fYAd2iM1EnzwUosm
 os0Kt9DX1tBdK+zrx3IM5gKVcG4N8OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-K-YZvm-dNiqJ2-C3TPGelQ-1; Thu, 25 Jun 2020 10:29:54 -0400
X-MC-Unique: K-YZvm-dNiqJ2-C3TPGelQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5E80107ACCD;
 Thu, 25 Jun 2020 14:29:53 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0FA65C1D0;
 Thu, 25 Jun 2020 14:29:48 +0000 (UTC)
Date: Thu, 25 Jun 2020 15:29:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
Message-ID: <20200625142945.GK1014704@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <745e1e86-3042-7b7c-89c7-81eb9a8f7905@redhat.com>
 <20200625102457.GG1009994@redhat.com>
 <acfb1a3a-e18d-dc4e-e28a-35201bafad86@redhat.com>
MIME-Version: 1.0
In-Reply-To: <acfb1a3a-e18d-dc4e-e28a-35201bafad86@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 03:25:19PM +0200, Thomas Huth wrote:
> On 25/06/2020 12.24, Daniel P. Berrangé wrote:
> > On Thu, Jun 25, 2020 at 12:14:33PM +0200, Thomas Huth wrote:
> > > On 22/06/2020 17.33, Daniel P. Berrangé wrote:
> > > > We have a number of container images in tests/docker/dockerfiles
> > > > that are intended to provide well defined environments for doing
> > > > test builds. We want our CI system to use these containers too.
> > > > 
> > > > This introduces builds of all of them as the first stage in the
> > > > CI, so that the built containers are available for later build
> > > > jobs. The containers are setup to use the GitLab container
> > > > registry as the cache, so we only pay the penalty of the full
> > > > build when the dockerfiles change. The main qemu-project/qemu
> > > > repo is used as a second cache, so that users forking QEMU will
> > > > see a fast turnaround time on their CI jobs.
> > > > 
> > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > ---
> > > >    .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
> > > >    .gitlab-ci.yml              |   3 +
> > > >    2 files changed, 251 insertions(+)
> > > >    create mode 100644 .gitlab-ci.d/containers.yml
> > > > 
> > > > diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> > > > new file mode 100644
> > > > index 0000000000..ea1edbb196
> > > > --- /dev/null
> > > > +++ b/.gitlab-ci.d/containers.yml
> > > > @@ -0,0 +1,248 @@
> > > > +
> > > > +
> > > > +.container_job_template: &container_job_definition
> > > > +  image: docker:stable
> > > > +  stage: containers
> > > > +  services:
> > > > +    - docker:dind
> > > > +  before_script:
> > > > +    - export TAG="$CI_REGISTRY_IMAGE/ci-$NAME:latest"
> > > > +    - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
> > > > +    - docker info
> > > > +    - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
> > > > +  script:
> > > > +    - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
> > > > +    - sed -i -e "s,FROM qemu:,FROM $CI_REGISTRY_IMAGE/ci-," tests/docker/dockerfiles/$NAME.docker
> > > > +    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
> > > > +    - docker push "$TAG"
> > > > +  after_script:
> > > > +    - docker logout
> > > 
> > > .gitlab-ci.d/edk2.yml uses a "changes" rule to only run the pipeline if
> > > something really has been changed. Could you use something similar here?
> > > E.g.:
> > > 
> > > rules:
> > >   - changes:
> > >     - .gitlab-ci.d/containers.yml
> > >     - tests/docker/*
> > >     - tests/docker/dockerfiles/*
> > > 
> > > ?
> > 
> > If the OS distro base image changes, we'll never pick it up with that
> > kind of filtering.  For the main gitlab.com/qemu-project/qemu  you
> > could configure a nightly/weekly/whatever job to force rebuild on a
> > periodic basis to pick up base image changes.  The downside of this
> > is that any users who fork qemu won't have that periodic job and so
> > will be testing their work against potentially outdated content.
> > 
> > Having said all that, I'm not 100% convinced I'm actually picking
> > up changed base images right now anyway, given our use of caching.
> > 
> > It is possible that I would need todo an explict "docker pull" of
> > the base image to force it to trigger a refresh othrewise I have
> > a feeling we're always cached.
> 
> But currently, each of the container stages currently takes > 2 minutes,
> even with the cached containers. I had a quick look, and it takes 7 minutes
> 'till the "build" stage begins. So all the advantages of not having to do
> "yum/apt-get install" in the build containers anymore seem to be crushed by
> the time that the three container stages take now?

That's still not an apples/apples comparison though. The containers have
many mre packages installed and so test more features. Add all those extra
packages into the original apt-get/dnf commands and then compare times.

I do agree though that I don't much like the 3 containers stages. I set
them up so they would parallelize. ie stage 2 can start without waiting
for entire of stage 1 to finish - only the parent container needs to
finish. The builds stage still waits for all the containers to complete.

We could do similar optimize for the actual build jobs, so they don't have
to wait for all containers to finish - they only need wait for their own
required container to finish.

Ultimately it might be a better tradeoff to not have inheritance between
the containers, and instead just duplicate the common packages in each.
This leads to bigger container images, but simpler builds. Libvirt went
this way for its cross compiler images, just duplicating the shared parts
in each.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


