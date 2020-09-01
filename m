Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C8DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF35B21534
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fskv0wG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF35B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8JL-0006Zu-43
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD8CD-0000fo-0v
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:27:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD8CB-0007V8-03
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598974058;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+JNtO5odleeqYVzdLyAgHNJyorv6ejgMQ5H6aaAlMc=;
 b=fskv0wG/9ZpnNRztQ7eGehaPAdl2ft3x7KbDKB4N3y5Mvs8jTnuxkK1TKdqyu4oI2uYLrR
 2Lq/3v0CPsyaUyGINz0F7fG3NNiuNa4EBaNyG/96biLYiaIiwr5ZS478PmQvwPf0Q/XoTd
 WqXvACoWJPmQtfBt0sev2wzN0+EpIOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-3wc9d-I7MjmZitbohlgsDA-1; Tue, 01 Sep 2020 11:27:36 -0400
X-MC-Unique: 3wc9d-I7MjmZitbohlgsDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66D91DDF8;
 Tue,  1 Sep 2020 15:27:34 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E9395D9CC;
 Tue,  1 Sep 2020 15:27:29 +0000 (UTC)
Date: Tue, 1 Sep 2020 16:27:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/2] gitlab: expand test coverage for crypto builds
Message-ID: <20200901152721.GP345480@redhat.com>
References: <20200901133050.381844-1-berrange@redhat.com>
 <20200901133050.381844-3-berrange@redhat.com>
 <577ced18-4a9a-3532-e797-0fe0708340bc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <577ced18-4a9a-3532-e797-0fe0708340bc@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 05:10:20PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/1/20 3:30 PM, Daniel P. Berrangé wrote:
> > Most jobs test the latest nettle library. This adds explicit coverage
> > for latest gcrypt using Fedora, and old gcrypt and nettle using
> > CentOS-7. The latter does a minimal tools-only build, as we only need to
> > validate that the crypto code builds and unit tests pass. Finally a job
> > disabling both nettle and gcrypt is provided to validate that gnutls
> > still works.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  .gitlab-ci.yml                          | 69 +++++++++++++++++++++++++
> >  tests/docker/dockerfiles/centos7.docker |  2 +
> >  tests/docker/dockerfiles/centos8.docker |  1 +
> >  3 files changed, 72 insertions(+)
> > 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index b7967b9a13..a74b16ff04 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -130,6 +130,7 @@ build-system-fedora:
> >    <<: *native_build_job_definition
> >    variables:
> >      IMAGE: fedora
> > +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
> >      TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
> >        xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
> >      MAKE_CHECK_ARGS: check-build
> > @@ -160,6 +161,7 @@ build-system-centos:
> >    <<: *native_build_job_definition
> >    variables:
> >      IMAGE: centos8
> > +    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
> >      TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
> >        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
> >      MAKE_CHECK_ARGS: check-build
> > @@ -196,6 +198,7 @@ build-disabled:
> >        --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
> >        --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
> >        --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
> > +      --disable-nettle --disable-gcrypt --disable-gnutls
> >      TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
> >      MAKE_CHECK_ARGS: check-qtest SPEED=slow
> >  
> > @@ -271,3 +274,69 @@ build-tci:
> >        done
> >      - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
> >      - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
> > +
> > +# Most jobs test latest gcrypt or nettle builds
> > +#
> > +# These jobs test old gcrypt and nettle from RHEL7
> > +# which had some API differences.
> > +build-crypto-old-nettle:
> > +  <<: *native_build_job_definition
> > +  variables:
> > +    IMAGE: centos7
> > +    TARGETS: x86_64-softmmu x86_64-linux-user
> > +    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
> > +    MAKE_CHECK_ARGS: check-build
> > +  artifacts:
> > +    paths:
> > +      - build
> > +
> > +check-crypto-old-nettle:
> > +  <<: *native_test_job_definition
> > +  needs:
> > +    - job: build-crypto-old-nettle
> > +      artifacts: true
> > +  variables:
> > +    IMAGE: centos7
> > +    MAKE_CHECK_ARGS: check
> > +
> > +
> 
> I'd copy the same comment for each library... In case
> we add more jobs in the middle.
> 
> > +build-crypto-old-gcrypt:
> > +  <<: *native_build_job_definition
> > +  variables:
> > +    IMAGE: centos7
> > +    TARGETS: x86_64-softmmu x86_64-linux-user
> > +    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
> > +    MAKE_CHECK_ARGS: check-build
> > +  artifacts:
> > +    paths:
> > +      - build
> > +
> > +check-crypto-old-gcrypt:
> > +  <<: *native_test_job_definition
> > +  needs:
> > +    - job: build-crypto-old-gcrypt
> > +      artifacts: true
> > +  variables:
> > +    IMAGE: centos7
> > +    MAKE_CHECK_ARGS: check
> > +
> > +
> > +build-crypto-only-gnutls:
> 
> Aren't these 'old' jobs too (centos 7, not 8)?

It doesn't matter what distro this job builds on - centos 7 was
essentially just a cut+paste choice. The key point is this is only
enabling GNUTLS - the age of gnutls/gcrypt/nettle doesn't matter.

> 
> > +  <<: *native_build_job_definition
> > +  variables:
> > +    IMAGE: centos7
> > +    TARGETS: x86_64-softmmu x86_64-linux-user
> > +    CONFIGURE_ARGS: --disable-nettle --disable-gcrypt --enable-gnutls
> > +    MAKE_CHECK_ARGS: check-build
> > +  artifacts:
> > +    paths:
> > +      - build
> > +
> > +check-crypto-only-gnutls:
> > +  <<: *native_test_job_definition
> > +  needs:
> > +    - job: build-crypto-only-gnutls
> > +      artifacts: true
> > +  variables:
> > +    IMAGE: centos7
> > +    MAKE_CHECK_ARGS: check

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


