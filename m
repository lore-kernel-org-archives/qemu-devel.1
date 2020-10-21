Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D631FC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 11:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3727E20872
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRefQdjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3727E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVCSV-0007QB-20
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 07:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVCR1-0006MI-Jx
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 07:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVCQz-0006Ns-JP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 07:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603280255;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PVy7VWHAT0SJyxXzwBdxhY/I1OYGniiv6zXs6Hc4KM=;
 b=VRefQdjwKe5BIbn+KShBV9XJs+M+oN5rDt9NjTS6FIucNxK10glUEaifSFL7sJV7jenoNw
 Odj4fOpvGfPte5GSmQu6ZoDV3UxCqDiAMI0aQFR0vs+EsxFLgpzxQuKjyFHjs4kLDP1Z8A
 4p3SRRPtuhbwpt8LGNO6qKfK67RezIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-KGEp-oEXNG-qHJDarH5-MA-1; Wed, 21 Oct 2020 07:37:29 -0400
X-MC-Unique: KGEp-oEXNG-qHJDarH5-MA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1692D107B473;
 Wed, 21 Oct 2020 11:37:28 +0000 (UTC)
Received: from redhat.com (ovpn-114-86.ams2.redhat.com [10.36.114.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 366AF27BA3;
 Wed, 21 Oct 2020 11:37:26 +0000 (UTC)
Date: Wed, 21 Oct 2020 12:37:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1
Message-ID: <20201021113723.GK412988@redhat.com>
References: <20201021072308.9224-1-thuth@redhat.com>
 <e7ac0344-24d1-d53f-7e7f-798be452adcb@redhat.com>
 <4ea997ee-a0c9-34da-8ad6-048ed4904fb3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4ea997ee-a0c9-34da-8ad6-048ed4904fb3@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 01:29:10PM +0200, Thomas Huth wrote:
> On 21/10/2020 11.38, Philippe Mathieu-Daudé wrote:
> > On 10/21/20 9:23 AM, Thomas Huth wrote:
> >> We do not support SDL1 in QEMU anymore. Use SDL2 instead.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   tests/docker/dockerfiles/centos7.docker | 2 +-
> >>   tests/docker/dockerfiles/centos8.docker | 2 +-
> >>   2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/docker/dockerfiles/centos7.docker
> >> b/tests/docker/dockerfiles/centos7.docker
> >> index 8b273725ee..6f11af1989 100644
> >> --- a/tests/docker/dockerfiles/centos7.docker
> >> +++ b/tests/docker/dockerfiles/centos7.docker
> >> @@ -31,7 +31,7 @@ ENV PACKAGES \
> >>       perl-Test-Harness \
> >>       pixman-devel \
> >>       python3 \
> >> -    SDL-devel \
> >> +    SDL2-devel \
> >>       spice-glib-devel \
> >>       spice-server-devel \
> >>       tar \
> >> diff --git a/tests/docker/dockerfiles/centos8.docker
> >> b/tests/docker/dockerfiles/centos8.docker
> >> index 585dfad9be..f86931f955 100644
> >> --- a/tests/docker/dockerfiles/centos8.docker
> >> +++ b/tests/docker/dockerfiles/centos8.docker
> >> @@ -2,7 +2,7 @@ FROM centos:8.1.1911
> >>     RUN dnf -y update
> >>   ENV PACKAGES \
> >> -    SDL-devel \
> >> +    SDL2-devel \
> >>       bzip2 \
> >>       bzip2-devel \
> >>       dbus-daemon \
> > 
> > I wonder if we are having docker image caching issues...

Looks more like something related to the artifact caching, rather
than container image caching.

> > 
> > build-system-centos job passed but then in check-system-centos:
> > 
> > FAILED: libcommon.fa.p/ui_sdl2-input.c.o
> > ui/sdl2.h:7:10: fatal error: SDL.h: No such file or directory
> >  #include
> >           ^~~~~~~
> > 
> > And then in acceptance-system-centos:
> > 
> > ./qemu-system-x86_64: error while loading shared libraries:
> > libSDL2-2.0.so.0: cannot open shared object file: No such file or directory
> 
> Uh, weird, now I've got that one, too ... sorry, I only waited for the build
> phase to complete before sending out the patch, I did not expect any trouble
> in the testing stage...
> 
> The check-system-xxx jobs are apparently recompiling lots of files now ...
> not sure yet why that happens... seems to be related to Paolo's PR from last
> weekend?

Presumably this is related to this PR removing use of make, and instead
building everything directly with ninja.

> The previous CI run still looks okayish:
> 
>  https://gitlab.com/qemu-project/qemu/-/jobs/796502985
> 
> then the one from Paolo suddenly recompiled pretty much everything:
> 
>  https://gitlab.com/qemu-project/qemu/-/jobs/796767669
> 
> Does anybody got a clue what happened here?

The log shows that it decided "meson" needed re-running, and as a result
of re-running meson, we in turn rebuild all source.

Best guess is that somewhere in here we are not correctly preserving
timestamps on something, causing  ninja to consider the build out of
date.

Possibly this is because the the check/acceptance jobs re-clome the
git checkout again ? Coud that make ninja thing the sources have
changed, or does git clone set timestamps to match the git commit
date ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


