Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C18C2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C18C2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xhG-0008WH-MP
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2xfz-0007e2-Mt
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2xfy-0000g5-Ad
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i2xfy-0000ei-48
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:07:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1AA3F3083391;
 Wed, 28 Aug 2019 13:07:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6231D194B2;
 Wed, 28 Aug 2019 13:07:47 +0000 (UTC)
Date: Wed, 28 Aug 2019 14:07:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190828130745.GH2991@redhat.com>
References: <20190823163931.7442-1-berrange@redhat.com>
 <CAJ+F1CJsYQDAMwD9pHifGzFT=vPanBeKrCDvYmzqO522MeLhgg@mail.gmail.com>
 <87d0gp5v6w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0gp5v6w.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 28 Aug 2019 13:07:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] docs: add docs about use of automatic
 cleanup functions
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 01:30:15PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>=20
> > Hi
> >
> > On Fri, Aug 23, 2019 at 8:41 PM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> >>
> >> This is ostensibly about adding docs for the g_autofree/g_autoptr
> >> macros. As part of doing that, however, the existing HACKING doc
> >> is merged into the CODING_STYLE doc and the text is converted to
> >> markdown with a table of contents.
> >
> > Why not rst, so it can integrate with the rest of qemu sphinx doc?
> >
> > (markdown is quite poor when it comes to documenting code or
> > cross-referencing etc)
>=20
> I was going to say markdown does have the advantage of being renderable
> on the fly on code hosting sites but it appears it works on
> gitlab/github so that is an argument for being consistent with the rest
> of the docs.

I picked markdown because most projects seem to use a README.md
and CONTRIBUTING.md file with github/gitlab, but if those sites
cope with .rst for those files too, there's no reason not to use
.rst.

> Does anyone know what is left to get the publishing pipeline up and
> running and the results linked to from www.qemu.org?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

