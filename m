Received: from eggs.gnu.org ([2001:4830:134:3::10]:51385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbBxm-0003Yo-Fx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbBxj-0000iD-DQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:02:06 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:52839)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cbBxj-0000hX-50
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:02:03 -0500
Date: Tue, 7 Feb 2017 15:01:59 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <2003631234.1298629.1486497719887.JavaMail.zimbra@redhat.com>
In-Reply-To: <36848fad-c7b9-21e3-0c6e-78014e9580c4@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-6-marcandre.lureau@redhat.com>
	<36848fad-c7b9-21e3-0c6e-78014e9580c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/22] main: free root container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com

Hi

----- Original Message -----
>=20
>=20
> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> > This should eventually free all objects that are only referenced by
> > their parents.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  vl.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/vl.c b/vl.c
> > index 0b72b12878..945df1d17f 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4640,6 +4640,7 @@ int main(int argc, char **argv, char **envp)
> >      audio_cleanup();
> >      monitor_cleanup();
> >      qemu_chr_cleanup();
> > +    object_unref(object_get_root());
>=20
> This seems dangerous.  I'm pretty sure that a lot of non-hot-unpluggable
> devices would leak or crash.

make check is ok. Any suggestion what else to check?

This patch was added so that /chardevs container is cleaned up (with the fo=
llowing patches). Perhaps I could be more conservative and only unref (oops=
 unparent) /chardevs.
