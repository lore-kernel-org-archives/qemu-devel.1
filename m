Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4892EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147C721655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ix2vcWEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147C721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNEc-0007CE-A4
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifNDm-0006jw-KS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifNDl-000377-6z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:05:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60804
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifNDl-00036D-1C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576152328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7MJCSiUFUzspXMdpzei95ZeQhWPvvDbcNut2w89k1Y=;
 b=Ix2vcWEaXUvfLT5XPLLozjyn9VT1dtrCEiElRG7P+e4tKwUGyP7OMaJpyuDIZcrZvglXMr
 kLLEyvHogg5RZLWGuQTgMlF7d6BTuMbg6jqRyH9FzBAubU2m5w+5AK62uM049dTXp2Z7G3
 9UW2PdjVKRBTc2oWqKbjlhPFGytADlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-57wJGWWQOMWZGACKnYDokw-1; Thu, 12 Dec 2019 07:05:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B1C1800D41
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:05:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 568A719C58;
 Thu, 12 Dec 2019 12:05:22 +0000 (UTC)
Date: Thu, 12 Dec 2019 12:05:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 6/8] configure: add GDBUS_CODEGEN
Message-ID: <20191212120520.GJ1829331@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-7-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 57wJGWWQOMWZGACKnYDokw-1
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
Cc: mprivozn@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 05:45:04PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> gdbus-codegen generated code requires gio-unix on Unix, so add it to
> GIO libs/cflags.

What is the situation on Windows, is it still supported ?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/configure b/configure
> index 6099be1d84..68a7705df7 100755
> --- a/configure
> +++ b/configure
> @@ -3720,10 +3720,16 @@ if $pkg_config --atleast-version=3D$glib_req_ver =
gio-2.0; then
>      gio=3Dyes
>      gio_cflags=3D$($pkg_config --cflags gio-2.0)
>      gio_libs=3D$($pkg_config --libs gio-2.0)
> +    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen gio-2.0)
>  else
>      gio=3Dno
>  fi
> =20
> +if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0; then
> +    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-2.0)"
> +    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
> +fi
> +
>  # Sanity check that the current size_t matches the
>  # size that glib thinks it should be. This catches
>  # problems on multi-arch where people try to build
> @@ -6949,6 +6955,7 @@ if test "$gio" =3D "yes" ; then
>      echo "CONFIG_GIO=3Dy" >> $config_host_mak
>      echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
>      echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
> +    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
>  fi
>  echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host_mak
>  if test "$gnutls" =3D "yes" ; then

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


