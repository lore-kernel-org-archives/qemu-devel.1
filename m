Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B7CC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267322067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267322067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44284 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXZr-0007ip-Cu
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:11:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXYh-00077f-Ex
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYXYf-0000YA-1n
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYXYc-0000Jh-Sk
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 536DE30ADC8F;
	Wed,  5 Jun 2019 15:10:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E524619C4;
	Wed,  5 Jun 2019 15:10:11 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:10:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190605151008.GE8956@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
	<20190523234011.583-4-marcandre.lureau@redhat.com>
	<e0cf3112-62f6-aaff-0821-f472297dbb93@redhat.com>
	<CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvay+ZrdjhJg-juU0aTOtcy=cLshC+WGyPBQ6VysXZksa5w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 05 Jun 2019 15:10:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] docker: update fedora to f30
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 01:17:17PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, May 24, 2019 at 9:41 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 5/24/19 1:40 AM, Marc-Andr=C3=A9 Lureau wrote:
> > > Released last month.
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  tests/docker/dockerfiles/fedora.docker | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/=
dockerfiles/fedora.docker
> > > index 69d4a7f5d7..1496b68ba1 100644
> > > --- a/tests/docker/dockerfiles/fedora.docker
> > > +++ b/tests/docker/dockerfiles/fedora.docker
> > > @@ -1,4 +1,4 @@
> > > -FROM fedora:29
> > > +FROM fedora:30
> >
> > Hmm this patch is pending for review:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00819.html
>=20
> Oh I missed that. Maybe we should use "latest" to avoid bumping the
> version every 6 months.
>=20
> fwiw we have different versions:
>=20
> tests/docker/dockerfiles/fedora-cris-cross.docker:FROM fedora:latest
> tests/docker/dockerfiles/fedora-i386-cross.docker:FROM fedora:29
> tests/docker/dockerfiles/fedora.docker:FROM fedora:29
>=20
> In 62559b916 "tests: update Fedora i386 cross image to Fedora 29", Dani=
el said:
>=20
>     Using the "latest" tag is not a good idea because this changes what
>     release it points to every 6 months. Together with caching of docke=
r
>     builds this can cause confusion where CI has cached & built with Fe=
dora
>     N, while a developer tries to reproduce a CI problem with Fedora N =
+ 1,
>     or vica-verca.
>=20
> But at the same time, Daniel bumped f28 to f29 in commit 19a9978db1.
>=20
> It's confusing, do we need some stability or follow the latest?

The problem is introduced by local caching. "latest" may point to "29"
today, but the CI system had cached content meaining its use of "latest"
still resolved to "28".

Using "29" meant both CI & developers saw the same image, even when
caching is used.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

