Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51018C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CE1206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWX775ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip93x-00087F-BP
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ip933-0007It-Gz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ip931-00030C-W2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ip931-0002ze-S2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578481126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7hwv0uyEfGZGdOpCrsE9NtgAJMuY0gRrW9svwTSdGU=;
 b=DWX775chjdkTg+5UtPr1SQAL7cn1LcCbjCEcKdnw+ll08TX5DcA1ohonM/0EAr9+gYZdBg
 p+HLaPFk2atSJW/nbdXq5OQwrkcY3uHhISJ+OWmrwvbfQtANZWeCiT/4d2aju/0o0R4tr4
 XnjYylNh4bi/22IT501nv18+rkTizkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-FrZgT4qoNUaADI8EHU4QAQ-1; Wed, 08 Jan 2020 05:58:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ADA91800D71;
 Wed,  8 Jan 2020 10:58:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 100AC7C82C;
 Wed,  8 Jan 2020 10:58:38 +0000 (UTC)
Date: Wed, 8 Jan 2020 10:58:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 6/6] travis: install homebrew python for OS X
Message-ID: <20200108105836.GE3386452@redhat.com>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-7-alex.bennee@linaro.org>
 <cf1af57a-c397-9503-cc49-a93dc58a2cc0@redhat.com>
 <87ftgqjuv2.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ftgqjuv2.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FrZgT4qoNUaADI8EHU4QAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Wed, Jan 08, 2020 at 07:00:17AM +0000, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
> > On 1/7/20 2:53 PM, Alex Benn=C3=A9e wrote:
> >> Our python3 requirements now outstrip those of the build.
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>   .travis.yml | 1 +
> >>   1 file changed, 1 insertion(+)
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 848a2714efe..a86ca34f79d 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -57,6 +57,7 @@ addons:
> >>         - glib
> >>         - pixman
> >>         - gnu-sed
> >> +      - python
> >>       update: true
> >>  =20
> >
> > This doesn't seem enough, I'm getting:
> >
> > ./configure --disable-docs --disable-tools
> > ERROR: Cannot use '/usr/local/bin/python', Python >=3D 3.5 is required.
> >
> >        Use --python=3D/path/to/python to specify a supported Python.
> >
> > Apparently we don't set this in PATH ourselves.
>=20
> It looks like brew fell over:
>=20
>   =3D=3D> Downloading https://homebrew.bintray.com/bottles/python-3.7.6_1=
.mojave.bottl
>=20
>   =3D=3D> Downloading from https://akamai.bintray.com/64/643d627c2b4fc03a=
3286c397d2992
>=20
>   #######################################################################=
# 100.0%
>=20
>   =3D=3D> Pouring python-3.7.6_1.mojave.bottle.tar.gz
>=20
>   Error: The `brew link` step did not complete successfully
>=20
>   The formula built, but is not symlinked into /usr/local
>=20
>   Could not symlink Frameworks/Python.framework/Headers
>=20
>   Target /usr/local/Frameworks/Python.framework/Headers
>=20
>   is a symlink belonging to python@2. You can unlink it:
>=20
>     brew unlink python@2
>=20
>   To force the link and overwrite all conflicting files:
>=20
>     brew link --overwrite python

We hit this same problem in Libvirt Travis setup. Something changed in
either Travis or HomeBrew sometime between Dec 23rd and Jan 2nd.

We worked around the problem in libvirt by following the suggestion
above, thus adding

      before_script:
        # Hack to blow away py2
        - brew link --overwrite python


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


