Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953D722CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3qh14Bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953D722CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FTj-0004oE-SU
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3FT1-0004GT-Jn
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:12:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3FSy-0003AE-Lh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596618727;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5vjkG9B8JLcP9S90LnFV98sbyeZ+aeC8cHAgcWSrB6Q=;
 b=O3qh14Btp8/jXa1qUy/kopDVcCkj065m7V2qIoPMUseONfAOXYXgm83ojehL0OaNoVK9z7
 /xZ/zeMO1MnbxLB/du5YtSi3Z6e8v4WD8PsMGJOich80bN0aJGj1gPPlbMYAy00APRLQuf
 l2gf1O3DXXv0XXxFsryuai5UlKjkRXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-FylfKgqEP12QuD3_UD3M1Q-1; Wed, 05 Aug 2020 05:12:03 -0400
X-MC-Unique: FylfKgqEP12QuD3_UD3M1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C1751005504;
 Wed,  5 Aug 2020 09:12:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9945A1A922;
 Wed,  5 Aug 2020 09:11:57 +0000 (UTC)
Date: Wed, 5 Aug 2020 10:11:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 11/11] dockerfiles/debian-win64-cross: Download WHPX
 MinGW headers
Message-ID: <20200805091154.GD4127670@redhat.com>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-12-thuth@redhat.com>
 <4cdba8c7-c6a1-e561-9e84-1dae8cf4cd04@weilnetz.de>
MIME-Version: 1.0
In-Reply-To: <4cdba8c7-c6a1-e561-9e84-1dae8cf4cd04@weilnetz.de>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 08:32:18PM +0200, Stefan Weil wrote:
> Am 04.08.20 um 19:00 schrieb Thomas Huth:
> 
> > To compile-test the WHPX accelerator, we need to download these system
> > headers first (they are unfortunately not part of any released and
> > packaged MinGW toolchain yet).
> >
> > Idea taken from another patch by Stefan Weil.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/docker/dockerfiles/debian-win64-cross.docker | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
> > index 2fc9cfcbc6..4cc4a3f365 100644
> > --- a/tests/docker/dockerfiles/debian-win64-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-win64-cross.docker
> > @@ -32,7 +32,14 @@ RUN apt-get update && \
> >          mxe-$TARGET-w64-mingw32.shared-sdl2 \
> >          mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
> >          mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
> > -        mxe-$TARGET-w64-mingw32.shared-zlib
> > +        mxe-$TARGET-w64-mingw32.shared-zlib \
> > +        curl && \
> > +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
> > +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvemulation.h?format=raw" && \
> > +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
> > +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatform.h?format=raw" && \
> > +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
> > +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatformdefs.h?format=raw"
> >  
> >  # Specify the cross prefix for this image (see tests/docker/common.rc)
> >  ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-
> 
> 
> I expect a build failure: Mingw-w64 decided to use lower case filenames,
> and those header files include each other.
> 
> We need both lower case filenames (for Mingw-w64) and camel case
> filenames (for QEMU). That's why I used additional symlinks.

Hmm, this feels wrong. Either QEMU or Mingw-w64 is broken here.

Mingw-w64 needs to match whatever upper/lower case scheme that Windows
has used for these headers. QEMU also needs to match whatever Windows
used.

Mingw originally commited the files with mixed case, and then later
renamed then to lower case, but the commit doing the rename gives
zero information about why it did that.

The microsoft docs appear to show that camel case is required:

  https://docs.microsoft.com/en-us/virtualization/api/hypervisor-platform/hypervisor-platform

so I think mingw just needs fixing to revert that broken commit
the changed to lowercase.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


