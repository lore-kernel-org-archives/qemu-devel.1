Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F2DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFE82075E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 11:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi+t+rte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFE82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8M03-0004Uk-E1
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 07:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8Lz0-0003wg-21
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:10:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k8Lyx-0006uM-Sx
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 07:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597835414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tj89ak4f2foItYIbbnnGDRgHdY9HVN7+pZ7ckAWbEkA=;
 b=Yi+t+rteKJZ/L0MBMmliSg6Qv1usPe0+Ur2NbPEqvSbURBQIX2NsxX5tV+kLDkge98pRgv
 yNlXU5jAB6omBbFqeN3u3YStu3ijnDFYu747gErAnCp5nR+qtSHhU/Qir/Zs49g6UdAvew
 vkyrNDRS4pxk4XBUnGfLMsyt2/t1aOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-lb2AhoNrNqSRbv3cH_rjlg-1; Wed, 19 Aug 2020 07:09:59 -0400
X-MC-Unique: lb2AhoNrNqSRbv3cH_rjlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C21D1DDF7;
 Wed, 19 Aug 2020 11:09:58 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F051A19C4F;
 Wed, 19 Aug 2020 11:09:56 +0000 (UTC)
Date: Wed, 19 Aug 2020 12:09:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: docker: support mxe-based mingw builds
Message-ID: <20200819110954.GG69261@redhat.com>
References: <20200819080206.27423-1-pbonzini@redhat.com>
 <20200819082013.GB69261@redhat.com>
 <a83d1d0d-3f5e-8aa1-801a-aaf844c29587@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a83d1d0d-3f5e-8aa1-801a-aaf844c29587@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 12:42:44PM +0200, Paolo Bonzini wrote:
> On 19/08/20 10:20, Daniel P. Berrangé wrote:
> > We already have docker containers with MXE based on Debian:
> > 
> >   debian-win32-cross.docker
> >   debian-win64-cross.docker
> > 
> > your image uses a different naming convention, and puts both
> > 32 and 64 bit in the same image.
> 
> Yeah, that's what test-mingw expects.

Ah, I missed that.

> 
> > I feel like we should have the Ubuntu variant follow the same
> > structure and naming as the Debian variant for consistency.
> 
> My patch follows the Fedora variant, so that test-mingw runs.  That
> ensures that NSIS is covered as well.  One possibility could be:
> 
> - create fedora-win*-cross dockerfiles

Yeah, I think that'd make sense, as it'd enable a simple trick we
do in libvirt.

In all the dockerfile recipe we set an env

  ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw32.meson"

And in other linux-cross builds, we do similar

  ENV MESON_OPTS "--cross-file=i686-linux-gnu"

So now from host side can just invoke  "meson $MESON_OPTS" and it will
do the right thing according to whatever the container image was
installed with, regardless of whether it is a cross, or native build.

This obviously only works if you have separate images for win32
and win64.

> - add ENV FEATURES $FEATURES mingw to the win*-cross dockerfiles
> 
> - look for the feature in test-full and test-quick, and run "make
> installer" if so.

I'd suggest that "make installer" should be a part of "make" not
a separate thing that needs running manually.

eg if we're configure'ing for mingw, configure should check whether
we have the NSIS tools available and if so, then enable NSIS as a
standard build output. We could have a configure option to enable/disable
NSIS explicitly.

This  eliminates the second bit of special casing for mingw

> - drop test-mingw completely, and adjust Patchew to use
> docker-test-quick@fedora-win{32,64}-cross instead

Yes, dropping test-mingw would be better, but I'm not sure you can
use 'test-quick' as that runs unit tests which would require wine
to be present.  'test-build' would be closer to what test-mingw
does.

Anyway, if the images and make rules are created & setup in a suitable
way, there should be no need to do anything special in the host side
for cross-builds - just pick the image you want and it should "just work".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


