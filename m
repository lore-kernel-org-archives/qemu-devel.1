Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqwB-0003uX-RL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqw6-0006l5-TC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVqw6-0006ku-N5
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:06:34 -0400
Date: Fri, 14 Jul 2017 11:06:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714030627.GE27284@pxdev.xzpeter.org>
References: <1499842423-21101-1-git-send-email-peterx@redhat.com>
	<1499842423-21101-2-git-send-email-peterx@redhat.com>
	<CAJ+F1CK6xti_5utnP+kb0dTEoT6m4DRCiumX-jhdvJ5SnZPmJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK6xti_5utnP+kb0dTEoT6m4DRCiumX-jhdvJ5SnZPmJw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Jul 13, 2017 at 04:05:32PM +0000, Marc-Andr=C3=A9 Lureau wrote:

[...]

> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-propertie=
s.h
> > index 0604c33..2939614 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -13,6 +13,7 @@ extern PropertyInfo qdev_prop_uint16;
> >  extern PropertyInfo qdev_prop_uint32;
> >  extern PropertyInfo qdev_prop_int32;
> >  extern PropertyInfo qdev_prop_uint64;
> > +extern PropertyInfo qdev_prop_int64;
> >  extern PropertyInfo qdev_prop_size;
> >  extern PropertyInfo qdev_prop_string;
> >  extern PropertyInfo qdev_prop_chr;
> > @@ -127,6 +128,8 @@ extern PropertyInfo qdev_prop_arraylen;
> >      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
> >  #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
> >      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
> > +#define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
> > +    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
> >
>=20
>=20
> Make it SIGNED, with that:

Oops, definitely.

>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

--=20
Peter Xu
