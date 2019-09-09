Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63049C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C6B218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C6B218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56587 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7JfE-0005RJ-DV
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i7Jde-00047C-Ri
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i7Jdd-0005yk-JB
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i7Jdd-0005yZ-E8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:23:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9F5010A812D
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 13:23:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF63100194E;
 Mon,  9 Sep 2019 13:23:21 +0000 (UTC)
Date: Mon, 9 Sep 2019 14:23:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190909132319.GI24509@redhat.com>
References: <20190909130840.25117-1-pbonzini@redhat.com>
 <325c24e1-60f0-15b6-0f61-3cb8a4a9acea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <325c24e1-60f0-15b6-0f61-3cb8a4a9acea@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 09 Sep 2019 13:23:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] win32: fix README file in NSIS installer
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 09, 2019 at 03:17:00PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 9/9/19 3:08 PM, Paolo Bonzini wrote:
> > Adjust after the rST conversion and consequent renaming.
> >=20
> > Fixes: 336a7451e8803c21a2da6e7d1eca8cfb8e8b219a
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  qemu.nsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/qemu.nsi b/qemu.nsi
> > index d0df0f4e3a..da18438071 100644
> > --- a/qemu.nsi
> > +++ b/qemu.nsi
> > @@ -119,7 +119,7 @@ Section "${PRODUCT} (required)"
> >      File "${SRCDIR}\Changelog"
> >      File "${SRCDIR}\COPYING"
> >      File "${SRCDIR}\COPYING.LIB"
> > -    File "${SRCDIR}\README"
> > +    File "${SRCDIR}\README.rst"
> >      File "${SRCDIR}\VERSION"
> > =20
> >      File "${BINDIR}\*.bmp"
> >=20
>=20
> Also:
>=20
> -- >8 --
> @@ -211,7 +211,7 @@ Section "Uninstall"
>      Delete "$INSTDIR\Changelog"
>      Delete "$INSTDIR\COPYING"
>      Delete "$INSTDIR\COPYING.LIB"
> -    Delete "$INSTDIR\README"
> +    Delete "$INSTDIR\README.rst"
>      Delete "$INSTDIR\VERSION"
>      Delete "$INSTDIR\*.bmp"
>      Delete "$INSTDIR\*.bin"
> ---
>=20
> With the snippet amended:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

