Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4EEC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C352239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmyRVsyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C352239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdZn-0001Gk-2d
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKdYC-0008RB-Ji
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:21:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKdYA-000600-CH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600762881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AILiRjyj4WpQRgJk1bCY1FtVHLalXsEkvcVvCGK7gJI=;
 b=JmyRVsyO1dgw/MqeB0Khx4zh258PsYZ68/lP5ngfEDtD8ySIKGWpQimSzsIE4KMP/J7AFq
 puVAfNxrgoQF5mmoEgZbMIo50wyzRVBp2JL1r7rzhimxT/DsBkYySn5Q82rYiziD/18aM0
 NBaay8oQ+sVqBk3d0Wmz1lb9lm4+2m8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-3YU3TdOMOdq2l-Whw1_vEA-1; Tue, 22 Sep 2020 04:21:18 -0400
X-MC-Unique: 3YU3TdOMOdq2l-Whw1_vEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EAB5802B45;
 Tue, 22 Sep 2020 08:21:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A95355779;
 Tue, 22 Sep 2020 08:21:12 +0000 (UTC)
Date: Tue, 22 Sep 2020 09:21:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/7] tests/docker: Use Fedora containers for MinGW
 cross-builds in the gitlab-CI
Message-ID: <20200922082109.GE1989025@redhat.com>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-2-thuth@redhat.com>
 <20200921180342.GT1942072@redhat.com>
 <77749876-7b07-efbe-a277-925077d8ff57@redhat.com>
MIME-Version: 1.0
In-Reply-To: <77749876-7b07-efbe-a277-925077d8ff57@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 08:07:42PM +0200, Thomas Huth wrote:
> On 21/09/2020 20.03, Daniel P. Berrangé wrote:
> > On Mon, Sep 21, 2020 at 07:43:14PM +0200, Thomas Huth wrote:
> >> According to our support policy, we do not support Debian 9 in QEMU
> >> anymore, and we only support building the Windows binaries with a
> >> very recent version of the MinGW toolchain. So we should not test
> >> the MinGW cross-compilation with Debian 9 anymore, but switch to
> >> something newer like Fedora. To do this, we need a separate Fedora
> >> container for each build that provides the QEMU_CONFIGURE_OPTS
> >> environment variable.
> >> Unfortunately, the MinGW 64-bit compiler seems to be a little bit
> >> slow, so we also have to disable some features like "capstone" in the
> >> build here to make sure that the CI pipelines still finish within a
> >> reasonable amount of time.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  .gitlab-ci.d/containers.yml                   | 10 +++++
> >>  .gitlab-ci.d/crossbuilds.yml                  |  4 +-
> >>  .../dockerfiles/fedora-win32-cross.docker     | 42 +++++++++++++++++++
> >>  .../dockerfiles/fedora-win64-cross.docker     | 38 +++++++++++++++++
> >>  4 files changed, 92 insertions(+), 2 deletions(-)
> >>  create mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker
> >>  create mode 100644 tests/docker/dockerfiles/fedora-win64-cross.docker
> >>
> >> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> >> index 8c89efeb6d..15e7b564f9 100644
> >> --- a/.gitlab-ci.d/containers.yml
> >> +++ b/.gitlab-ci.d/containers.yml
> >> @@ -248,6 +248,16 @@ i386-fedora-cross-container:
> >>    variables:
> >>      NAME: fedora-i386-cross
> >>  
> >> +win32-fedora-cross-container:
> >> +  <<: *container_job_definition
> >> +  variables:
> >> +    NAME: fedora-win32-cross
> >> +
> >> +win64-fedora-cross-container:
> >> +  <<: *container_job_definition
> >> +  variables:
> >> +    NAME: fedora-win64-cross
> >> +
> >>  amd64-ubuntu1804-container:
> >>    <<: *container_job_definition
> >>    variables:
> >> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> >> index 4ec7226b5c..510cfec03b 100644
> >> --- a/.gitlab-ci.d/crossbuilds.yml
> >> +++ b/.gitlab-ci.d/crossbuilds.yml
> >> @@ -105,9 +105,9 @@ cross-s390x-user:
> >>  cross-win32-system:
> >>    <<: *cross_system_build_job_definition
> >>    variables:
> >> -    IMAGE: debian-win32-cross
> >> +    IMAGE: fedora-win32-cross
> >>  
> >>  cross-win64-system:
> >>    <<: *cross_system_build_job_definition
> >>    variables:
> >> -    IMAGE: debian-win64-cross
> >> +    IMAGE: fedora-win64-cross
> >> diff --git a/tests/docker/dockerfiles/fedora-win32-cross.docker b/tests/docker/dockerfiles/fedora-win32-cross.docker
> >> new file mode 100644
> >> index 0000000000..5903e1b0b4
> >> --- /dev/null
> >> +++ b/tests/docker/dockerfiles/fedora-win32-cross.docker
> >> @@ -0,0 +1,42 @@
> >> +FROM fedora:32
> >> +
> >> +# Please keep this list sorted alphabetically
> >> +ENV PACKAGES \
> >> +    bc \
> >> +    bzip2 \
> >> +    diffutils \
> >> +    findutils \
> >> +    gcc \
> >> +    gettext \
> >> +    git \
> >> +    hostname \
> >> +    make \
> >> +    meson \
> >> +    mingw32-bzip2 \
> >> +    mingw32-curl \
> >> +    mingw32-glib2 \
> >> +    mingw32-gmp \
> >> +    mingw32-gnutls \
> >> +    mingw32-gtk3 \
> >> +    mingw32-libjpeg-turbo \
> >> +    mingw32-libpng \
> >> +    mingw32-libtasn1 \
> >> +    mingw32-nettle \
> >> +    mingw32-nsis \
> >> +    mingw32-pixman \
> >> +    mingw32-pkg-config \
> >> +    mingw32-SDL2 \
> > 
> > It feels like we could be removing the mingw packages from the
> > main fedora.docker now, so it results in smaller images.
> 
> I wasn't quite sure whether anybody uses the mingw packages in that main
> fedora docker image ... Philippe, do you know?

A actually patchew uses this  "docker-mingw@fedora".

So I guess we merge this one. Then update patchew, then delete the
mingw stuff from @fedora.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


