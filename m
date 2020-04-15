Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B97C2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41F02076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSgsm16O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41F02076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjOZ-0001yS-W9
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOjNi-0000v7-H0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOjNh-0002Oq-0x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:51:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOjNg-0002OJ-TK
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586962271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROlPzgM1HOP3nd4rz937MZhFHSjGbiuIrE8HxycTsXI=;
 b=BSgsm16OTdIsDSAm8OHy/2iAiygo2mv76dd7AjazkuYRi1Wr8LJcNhaLT5xUoq4zbx1HfM
 pW+BIMBb54RgqrNOV/JwnakKzG9yqLPzIMiT+eGtCyeO+5cBMk0uDLBFLGvE0WQZhnCG0K
 nGCUd9BKyDdXVM+6D5Uu7NmkzgLClW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-xmZjFZyyMruuEYd4YHn7cA-1; Wed, 15 Apr 2020 10:51:02 -0400
X-MC-Unique: xmZjFZyyMruuEYd4YHn7cA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E54A1005510;
 Wed, 15 Apr 2020 14:51:01 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F0A11D2DE;
 Wed, 15 Apr 2020 14:50:59 +0000 (UTC)
Date: Wed, 15 Apr 2020 15:50:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0] docs: Require Sphinx 1.6 or better
Message-ID: <20200415145055.GA4583@redhat.com>
References: <20200414124114.5363-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200414124114.5363-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 01:41:14PM +0100, Peter Maydell wrote:
> Versions of Sphinx older than 1.6 can't build all of our documentation,
> because they are too picky about the syntax of the argument to the
> option:: directive; see Sphinx bugs #646, #3366:
>=20
>   https://github.com/sphinx-doc/sphinx/issues/646
>   https://github.com/sphinx-doc/sphinx/issues/3366
>=20
> Trying to build with a 1.4.x Sphinx fails with
>  docs/system/images.rst:4: SEVERE: Duplicate ID: "cmdoption-qcow2-arg-enc=
rypt"
> and a 1.5.x Sphinx fails with
>  docs/system/invocation.rst:544: WARNING: Malformed option description '[=
enable=3D]PATTERN', should look like "opt", "-opt
> args", "--opt args", "/opt args" or "+opt args"
>=20
> Update our needs_sphinx setting to indicate that we require at least
> 1.6.  This will allow configure to fall back to "don't build the
> docs" rather than causing the build to fail entirely, which is
> probably what most users building on a host old enough to have such
> an old Sphinx would want; if they do want the docs then they'll have
> a useful indication of what they need to do (upgrade Sphinx!) rather
> than a confusing error message.
>=20
> In theory our distro support policy would suggest that we should
> support building on the Sphinx shipped in those distros, but:
>  * EPEL7 has Sphinx 1.2.3 (which we've never supported!)
>  * Debian Stretch has Sphinx 1.4.8
>=20
> Trying to get our docs to work with Sphinx 1.4 is not tractable
> for the 5.0 release and I'm not sure it's worthwhile effort anyway;
> at least with this change the build as a whole now succeeds.

What happens if you try to build QEMU on   RHEL/CentOS-7 / Deb Stretch,
with the new (unsatisfied) needs_sphinx version ?  Does the build fail,
or does configure automagically disable the building of docs ?

> diff --git a/docs/conf.py b/docs/conf.py
> index 7768611e89c..d6e173ef77b 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -59,8 +59,10 @@ sys.path.insert(0, os.path.join(qemu_docdir, "sphinx")=
)
> =20
>  # If your documentation needs a minimal Sphinx version, state it here.
>  #
> -# 1.3 is where the 'alabaster' theme was shipped with Sphinx.
> -needs_sphinx =3D '1.3'
> +# Sphinx 1.5 and earlier can't build our docs because they are too
> +# picky about the syntax of the argument to the option:: directive
> +# (see Sphinx bugs #646, #3366).
> +needs_sphinx =3D '1.6'
> =20
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
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


