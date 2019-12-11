Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A3AC00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDE822B48
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkHbwY+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE822B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3B5-0007PH-Nq
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1if31b-000595-Js
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1if31X-000596-J9
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:31:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1if31X-00057b-Dg
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576074690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFdNYQIyjvbayKmi//5UM3M2LBqK+D80GsKiRYvVMkY=;
 b=IkHbwY+Xpdr7/gVS53hHUilHmzCGGzquHtboXG9TlRogn+IKpk1T4b4Q2z/8j/D2B3Ec5W
 iOxUqV4635ToC2IPs05g3Nq2sEZmjsszR5fJ5Hu+SqoKVKXWoa7cVHFtH4HBgiqqScvVIJ
 Dy/ZuiC8Kk9cPWW3r6C5363J5xPXiAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-6gxKeg_tPKSff984KcPhaQ-1; Wed, 11 Dec 2019 09:31:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87775113619B;
 Wed, 11 Dec 2019 14:31:26 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D4E6016C;
 Wed, 11 Dec 2019 14:31:22 +0000 (UTC)
Date: Wed, 11 Dec 2019 14:31:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] build-sys: build vhost-user-gpu only if CONFIG_TOOLS
Message-ID: <20191211143119.GK955178@redhat.com>
References: <1576074210-52834-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576074210-52834-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6gxKeg_tPKSff984KcPhaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 03:23:22PM +0100, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> vhost-user-gpu is always built and installed, but it is not part of the e=
mulator
> proper.  Cut it if --disable-tools is specified.

I don't feel like this is something that people would really
consider part of "tools" either.  This is something you'd
only ever use in conjunction with the emulators, so I don't
think controlling it with --disable-tools is appropriate.

A new --(enable|disable)-vhost-backends  arg looks more
desirable to me. Disabling the system emulators should
automatically imply --disable-vhost-backends by default
too

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 53823c2..8d921c6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -321,14 +321,10 @@ HELPERS-y =3D
> =20
>  HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D qemu-bridge-h=
elper$(EXESUF)
> =20
> -ifdef CONFIG_LINUX
> -ifdef CONFIG_VIRGL
> -ifdef CONFIG_GBM
> +ifeq ($(CONFIG_LINUX)$(CONFIG_VIRGL)$(CONFIG_GBM)$(CONFIG_TOOLS),yyyy)
>  HELPERS-y +=3D vhost-user-gpu$(EXESUF)
>  vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
>  endif
> -endif
> -endif
> =20
>  # Sphinx does not allow building manuals into the same directory as
>  # the source files, so if we're doing an in-tree QEMU build we must
> --=20
> 1.8.3.1
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


