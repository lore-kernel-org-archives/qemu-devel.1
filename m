Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE09FC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856B20856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 05:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36381 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJks-0004Nj-1U
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 01:25:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTJiw-0002o1-58
	for qemu-devel@nongnu.org; Wed, 22 May 2019 01:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTJiu-0004u0-Am
	for qemu-devel@nongnu.org; Wed, 22 May 2019 01:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTJiu-0004sK-0w
	for qemu-devel@nongnu.org; Wed, 22 May 2019 01:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A7473092656;
	Wed, 22 May 2019 05:23:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55D797C492;
	Wed, 22 May 2019 05:23:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 74A2911AB7; Wed, 22 May 2019 07:23:22 +0200 (CEST)
Date: Wed, 22 May 2019 07:23:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190522052322.wd4b5vynbd7ae6bm@sirius.home.kraxel.org>
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
	<20190514104126.6294-3-marcandre.lureau@redhat.com>
	<36d35842-d872-427b-accf-2d206a6c6b61@redhat.com>
	<CAJ+F1CL3KJpE_+XCXUMyffuCPwUOaqZCzHpxqv2q_BKdQVF_4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL3KJpE_+XCXUMyffuCPwUOaqZCzHpxqv2q_BKdQVF_4w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 22 May 2019 05:23:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/3] libvhost-user: fix -Werror=format=
 on ppc64
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 02:33:41PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, May 14, 2019 at 2:10 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Marc-Andr=C3=A9,
> >
> > On 5/14/19 12:41 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > That should fix the following warning:
> > >
> > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> > > =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
> > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error=
:
> > > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98lon=
g long unsigned int=E2=80=99, but
> > > argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> > >          DPRINT("%s: region %d: Registered userfault for %llx + %ll=
x\n",
> > >          ^
> > > /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error=
:
> > > format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98lon=
g long unsigned int=E2=80=99, but
> > > argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
> > > cc1: all warnings being treated as errors
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  contrib/libvhost-user/libvhost-user.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvho=
st-user/libvhost-user.c
> > > index 40443a3daa..ab85166b15 100644
> > > --- a/contrib/libvhost-user/libvhost-user.c
> > > +++ b/contrib/libvhost-user/libvhost-user.c
> > > @@ -663,8 +663,10 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, Vho=
stUserMsg *vmsg)
> > >                       __func__, i);
> > >              return false;
> > >          }
> > > -        DPRINT("%s: region %d: Registered userfault for %llx + %ll=
x\n",
> > > -                __func__, i, reg_struct.range.start, reg_struct.ra=
nge.len);
> > > +        DPRINT("%s: region %d: Registered userfault for %"
> > > +               PRIu64 " + %" PRIu64 "\n", __func__, i,
> >
> > I guess you want PRIx64 in both places here.
> >
> > I'd put the '%' on the next line:
> >
> >            DPRINT("%s: region %d: Registered userfault for "
> >                   "%" PRIx64 " + %" PRIx64 "\n", __func__, i,
> >
> > Using PRIx64:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> indeed, thanks
> Gerd, can you change it on commit?

Fixed & queued.

What is the status of the vhost-gpu series btw?
It doesn't apply cleanly (simliar to v3 of this series),
IIRC I've mentioned that a while back ...

cheers,
  Gerd


