Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F8C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E296721670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E296721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLlrb-0002cy-6p
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 05:49:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlnT-00083v-1U
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlnP-0000on-Vd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:45:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hLlnP-0000nr-Q7; Wed, 01 May 2019 05:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13924C057F32;
	Wed,  1 May 2019 09:44:59 +0000 (UTC)
Received: from redhat.com (ovpn-112-28.ams2.redhat.com [10.36.112.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5273653;
	Wed,  1 May 2019 09:44:56 +0000 (UTC)
Date: Wed, 1 May 2019 10:44:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190501094452.GQ29808@redhat.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 01 May 2019 09:44:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501094453.Ci0in6NQtgMfEqRCqviLHudXVP1hxtReRR8UTmqQ8JM@z>

On Wed, May 01, 2019 at 11:40:13AM +0200, Laurent Vivier wrote:
> On 01/05/2019 01:28, Alistair Francis wrote:
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/l=
inux-user/uname.c:94:3:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string=
 of length 64 [-Werror=3Dstringop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos=
 (__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> >=20
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/uname.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/linux-user/uname.c b/linux-user/uname.c
> > index 313b79dbad..2fc6096a5b 100644
> > --- a/linux-user/uname.c
> > +++ b/linux-user/uname.c
> > @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
> >  #define COPY_UTSNAME_FIELD(dest, src) \
> >    do { \
> >        /* __NEW_UTS_LEN doesn't include terminating null */ \
> > -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> > +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN));=
 \
>=20
> You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> character if it is present and fit in __NEW_UTS_LEN.

IMHO we shouldn't use strlen at all. I proposed fixing it using sizeof()
instead here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02154.html

>=20
> >        (dest)[__NEW_UTS_LEN] =3D '\0'; \
> >    } while (0)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

