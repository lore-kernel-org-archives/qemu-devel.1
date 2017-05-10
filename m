Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Rjp-0001Ey-FR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8Rjm-0000Ch-AU
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:33:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8Rjm-0000CN-4H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:33:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D6127AE9B
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 13:33:05 +0000 (UTC)
Date: Wed, 10 May 2017 14:32:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170510133255.GD4230@work-vm>
References: <20170509184900.GI2089@work-vm>
	<1833628273.9365810.1494355970259.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1833628273.9365810.1494355970259.JavaMail.zimbra@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] VhostUserRequest # 20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: maxime coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> HI
>=20
> ----- Original Message -----
> > Hi,
> >   libvhost-user.h defines:
> >    VHOST_USER_INPUT_GET_CONFIG =3D 20,
>=20
> That slipped by mistake from my vhost-user-input series WIP, please sen=
d a fix.
> (luckily, this is only internal header for now)

OK, just posted.

However, I just spotted, or should I say gcc just spotted another issue:

  CC      tests/vhost-user-bridge.o
/home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warning:=
 variables 'front' and 'iov' used in loop condition not modified in loop =
body [-Wfor-loop-analysis]
    for (cur =3D front; front !=3D iov; cur++) {
                      ^~~~~    ~~~
1 warning generated.


static void
iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes)
{
    struct iovec *cur;

    for (cur =3D front; front !=3D iov; cur++) {
        bytes -=3D cur->iov_len;
    }

    cur->iov_base -=3D bytes;
    cur->iov_len +=3D bytes;
}

What's that actually intending to do?

Dave

> thanks
>=20
> > while
> >   vhost-user.c defines:
> >    VHOST_USER_NET_SET_MTU =3D 20,
> >=20
> > who wins?
> >=20
> > Dave
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
