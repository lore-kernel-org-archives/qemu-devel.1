Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7BDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C7D20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqGVwVi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C7D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnecQ-0000jF-QW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnebH-0008II-LP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:48:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnebE-0007Ff-J3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592902091;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aIFX1jPYsisx30VIeKUnmFO678t6u7WvuF2DZQG4NpA=;
 b=XqGVwVi5b5dRX+HnwwBwN8uI5vJnJJjGH7ujJaznSI+xFlEpaZlNA/O8jQgTlZBTnrOzi7
 lKeC1+CaJbVHLCUhHoyoxXNGNpkoKPhJG/eTis3b3uIpJhaFyA77KZGnJqXsurQYlUO/NO
 2dVLDMi3L8mYlQ/i8c/eInNHR3gIay8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-0uAHYM5dMYivk7I8oyY-DQ-1; Tue, 23 Jun 2020 04:48:09 -0400
X-MC-Unique: 0uAHYM5dMYivk7I8oyY-DQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F390318A073B;
 Tue, 23 Jun 2020 08:48:08 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAAF17CCC0;
 Tue, 23 Jun 2020 08:48:03 +0000 (UTC)
Date: Tue, 23 Jun 2020 09:47:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
Message-ID: <20200623084759.GB751477@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <87a70v9ctc.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87a70v9ctc.fsf@linaro.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 07:26:39PM +0100, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > We have a number of container images in tests/docker/dockerfiles
> > that are intended to provide well defined environments for doing
> > test builds. We want our CI system to use these containers too.
> >
> > This introduces builds of all of them as the first stage in the
> > CI, so that the built containers are available for later build
> > jobs. The containers are setup to use the GitLab container
> > registry as the cache, so we only pay the penalty of the full
> > build when the dockerfiles change. The main qemu-project/qemu
> > repo is used as a second cache, so that users forking QEMU will
> > see a fast turnaround time on their CI jobs.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
> >  .gitlab-ci.yml              |   3 +
> >  2 files changed, 251 insertions(+)
> >  create mode 100644 .gitlab-ci.d/containers.yml
> >
> > diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> > new file mode 100644
> > index 0000000000..ea1edbb196
> > --- /dev/null
> > +++ b/.gitlab-ci.d/containers.yml
> > @@ -0,0 +1,248 @@
> > +
> > +
> > +.container_job_template: &container_job_definition
> > +  image: docker:stable
> > +  stage: containers
> > +  services:
> > +    - docker:dind
> > +  before_script:
> > +    - export TAG="$CI_REGISTRY_IMAGE/ci-$NAME:latest"
> > +    - export
> > COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
> 
> It would be nice if we could keep the same form as they have in the
> local registry which would make it easier to integrate with the rest of
> the tooling, e.g. "$CI_REGISTRY/qemu-project/qemu:$NAME"

Every time I re-discover it, I find the QEMU container naming really
surprising. It is not following the normal best practice for naming
containers. Expected container naming convention is that the image
name reflects the general content set, and the tag reflects a version
number. QEMU has shifted it along, so container name is just a fixed
string, and the tag reflects the contenet set, and there is no version.

QEMU's naming will cause problems with caching in GitLab. As GitLab
expects the normal container naming scheme, it has a job which expires
old versions of an image once there are more than 10 tags. So we have
to use the normal naming scheme. Ideally we would change rest of QEMU
to use the normal scheme too.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


