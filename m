Received: from eggs.gnu.org ([2001:4830:134:3::10]:55584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cRh9g-0006m5-4F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cRh9b-0006CL-LK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:19:08 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cRh9b-0006C2-Cf
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:19:03 -0500
Date: Thu, 12 Jan 2017 10:19:03 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1990167562.1925917.1484234343017.JavaMail.zimbra@redhat.com>
In-Reply-To: <2148de4b-9a79-7f6e-13c4-936d24fff04f@redhat.com>
References: <20170110174810.17748-1-marcandre.lureau@redhat.com>
	<20170110174810.17748-21-marcandre.lureau@redhat.com>
	<2148de4b-9a79-7f6e-13c4-936d24fff04f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/20] chardev: qom-ify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi

----- Original Message -----
> On 01/10/2017 11:48 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Turn Chardev into Object.
> >=20
> > qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> > will call qemu_char_open() to open/intialize the chardev with the
> > ChardevCommon *backend settings.
> >=20
>=20
> > -ChardevReturn *qmp_chardev_add(const char *id, ChardevBackend *backend=
,
> > -                               Error **errp)
> > +static const ChardevClass *char_get_class(const char *driver, Error
> > **errp)
> > +{
>=20
> Your followup "[PATCH 16/40] char: get rid of CharDriver" hoists this up
> earlier in the file. Can you minimize churn by just declaring it earlier
> to begin with?

Unless Paolo want me to respin the series, I think we will have to do with =
it ;)

thanks
