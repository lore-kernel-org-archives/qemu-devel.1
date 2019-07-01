Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5013DC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211952064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211952064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxfh-0004gK-CQ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hhxQy-0007UV-1E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:37:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hhxQw-0004op-Cx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15269)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hhxQt-0004mD-JE; Mon, 01 Jul 2019 10:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F3085D674;
 Mon,  1 Jul 2019 14:37:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5B8878551;
 Mon,  1 Jul 2019 14:37:00 +0000 (UTC)
Date: Mon, 1 Jul 2019 15:36:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190701143657.GM3573@redhat.com>
References: <20190614100718.14019-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614100718.14019-1-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 01 Jul 2019 14:37:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/9] configure: Fix softmmu --static
 linking
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 12:07:09PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi,
>=20
> Apparently QEMU static linking is slowly bitroting. Obviously it
> depends the libraries an user has installed, anyway it seems there
> are not much testing done.

Bitrotting implies that it actually worked in the first place.

AFAIK, configure has never been capable of auto-enabling the
correct set of libraries for static linking, if you have the
equiv dyn libraries present.

I always assumed that anyone who is static loinking QEMU is
passing a big long list of --disable-XXXX args to turn off
all the 3rd party libs for which they don't have a static
build present.

> This series fixes few issues, enough to build QEMU on a Ubuntu
> 18.04 host.
>=20
> Peter commented on v1:
>=20
>   The main reason for supporting static linking is so we can build
>   the user-mode emulators. Almost always the problems with
>   static linking the softmmu binaries and the tools are
>   issues with the distro's packaging of the static libraries
>   (pkg-config files which specify things that don't work for
>   static is a common one).
>=20
>   So we could put in a lot of checking of "is what pkg-config
>   tells us broken". Or we could just say "we don't support static
>   linking for anything except the usermode binaries". We
>   should probably phase in deprecation of that because it's
>   possible somebody's using it seriously, but it seems like
>   a fairly weird thing to do to me.
>=20
> I share his view on this (restricting static linking to qemu-user)
> but since the work was already done when I read his comment, I still
> send the v2.

I share Peter's view that we ought to restrict static linking to be
allowed exclusively for user-mode-only builds of QEMU. This is a use
case with a compelling reason to need static builds. It is not bitrotting
as the main distros all do a static user-mode only QEMU build, alongside
the main everything, fully dynamic build.

Static builds of system emulators & other tools get essentially no
testing by developers, distros, or our CI systems. If they do work
it is largely by luck, and likely requires the user to pass many
--disable-XXX flags. While your patches do make configure a bit
nicer in this respect, if we're going to deprecate static builds
of non-user-mode parts, then making static builds easier feels
undesirable.

Lets just get a deprecation warning in right now for this imminent
release.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

