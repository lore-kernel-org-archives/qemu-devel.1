Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EE6C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB0620787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9feF34k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB0620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUTkB-0004RU-5L
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jUTjQ-0003vt-1s
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jUTjO-0003cw-2Y
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:21:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jUTjN-0003ah-Io
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588332079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CF9KEqbYjAdlOvvmsRR5n21fkzwIwc9afS5W1l6wfo=;
 b=b9feF34kpLCvQAAvpezAfa7mdZPPVNCVG/quhMY/A90CMv7Wd7wBK/22r0wYMMTYpPtZgE
 kOa6fJWp4BHS3e7+ZukVAIFyWPmlD7sgjTDO3tS/4CUPRHa+3xk4FxIcfNvL0hKvX5FWvS
 YaSAIrT/QM+kE8U+Q/hIlCJnDGmVliU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-95NDQPirPPWJI5NDUU-ZkQ-1; Fri, 01 May 2020 07:21:11 -0400
X-MC-Unique: 95NDQPirPPWJI5NDUU-ZkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3DB2801503;
 Fri,  1 May 2020 11:21:10 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB5AD5C1B0;
 Fri,  1 May 2020 11:21:08 +0000 (UTC)
Date: Fri, 1 May 2020 12:21:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 2/4] .travis.yml: drop MacOSX
Message-ID: <20200501112105.GJ2203114@redhat.com>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-3-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200501111505.4225-3-alex.bennee@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 01, 2020 at 12:15:03PM +0100, Alex Benn=C3=A9e wrote:
> This keeps breaking on Travis so lets just fall back to the Cirrus CI
> builds which seem to be better maintained. Fix up the comments while
> we are doing this as we never had a windows build.

FYI the current problem with macOS biulds is not a Travis problem,
it is a Homebrew problem, fixed by this patch:

https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04234.html


>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 28 +---------------------------
>  1 file changed, 1 insertion(+), 27 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index a4c3c6c805..49267b73b3 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,9 +9,8 @@ compiler:
>  cache:
>    # There is one cache per branch and compiler version.
>    # characteristics of each job are used to identify the cache:
> -  # - OS name (currently, linux, osx, or windows)
> +  # - OS name (currently only linux)
>    # - OS distribution (for Linux, xenial, trusty, or precise)
> -  # - macOS image name (e.g., xcode7.2)
>    # - Names and values of visible environment variables set in .travis.y=
ml or Settings panel
>    timeout: 1200
>    ccache: true
> @@ -271,31 +270,6 @@ jobs:
>          - TEST_CMD=3D""
> =20
> =20
> -    # MacOSX builds - cirrus.yml also tests some MacOS builds including =
latest Xcode
> -
> -    - name: "OSX Xcode 10.3"
> -      env:
> -        - BASE_CONFIG=3D"--disable-docs --enable-tools"
> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
> -      os: osx
> -      osx_image: xcode10.3
> -      compiler: clang
> -      addons:
> -        homebrew:
> -          packages:
> -            - ccache
> -            - glib
> -            - pixman
> -            - gnu-sed
> -            - python
> -          update: true
> -      before_script:
> -        - brew link --overwrite python
> -        - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
> -        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.=
log && exit 1; }
> -
> -
>      # Python builds
>      - name: "GCC Python 3.5 (x86_64-softmmu)"
>        env:
> --=20
> 2.20.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


