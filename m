Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB163C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE62521872
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE62521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2M52-0006so-20
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2M4E-0006Pz-Hm
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2M4C-00076I-7S
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:58:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2M4B-00075k-V7
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 16:58:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0C39281D1;
 Mon, 26 Aug 2019 20:58:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65B0F60CC0;
 Mon, 26 Aug 2019 20:58:15 +0000 (UTC)
Message-ID: <7d92f795d80ae7a2bc2db9f7af6ae7e20ff5d3b1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?UTF-8?Q?Zolt=C3=A1n_K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>, 
 qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 23:58:14 +0300
In-Reply-To: <8ca01890-b337-6590-c415-48563ca938d1@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
 <9db7233c490836c221bab463305d08e34db9f037.1566779143.git.DirtY.iCE.hu@gmail.com>
 <117a307ac9ec4169d173eb80e68288a89d181386.camel@redhat.com>
 <8ca01890-b337-6590-c415-48563ca938d1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 26 Aug 2019 20:58:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] audio: paaudio: fix client name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-08-26 at 21:28 +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrot=
e:
> On 2019-08-26 10:21, Maxim Levitsky wrote:
> > On Mon, 2019-08-26 at 02:29 +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n=
 wrote:
> > > pa_context_new expects a client name, not a server socket path.
> > >=20
> > > Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gma=
il.com>
> > > ---
> > >  audio/paaudio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/audio/paaudio.c b/audio/paaudio.c
> > > index bfef9acaad..777b8e4718 100644
> > > --- a/audio/paaudio.c
> > > +++ b/audio/paaudio.c
> > > @@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
> > >      }
> > > =20
> > >      c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->=
mainloop),
> > > -                                server);
> > > +                                "qemu");
> > >      if (!c->context) {
> > >          goto fail;
> > >      }
> >=20
> > Also tested, and this works.
> >=20
> > May I suggest though to make this configurable as well, for the sake =
of
> > usability since gnome sound settings show only the client name, and i=
t
> > is per each sound card.
> > Although on the other thing the client name is qemu.
>=20
> There is a small problem with that.  Currently we only open one
> connection to pa, even with multiple -audiodevs (they will just create
> different streams), which means we can only use a single client name pe=
r
> qemu process.  Because of that, I wouldn't turn this into an audiodev
> property.  Some other kind of global setting could work, but I'm not
> sure whether it's worth it or not.
>=20
> Regards,
> Zoltan

All right.
We could use the VM name for that though, so that at least multiple VMs
would show up as different client.


Best regards,
	Maxim Levitsky




