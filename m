Received: from eggs.gnu.org ([2001:4830:134:3::10]:55802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIZ5-0006U4-9C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIZ2-0002tp-5v
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:40:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRIZ2-0002tR-0S
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:40:28 -0400
Date: Fri, 8 Jun 2018 15:40:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608144023.GS18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608143026.20167-1-ehabkost@redhat.com>
	<24e7a171-33b6-e9ca-9d9c-d61a7a2c5047@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24e7a171-33b6-e9ca-9d9c-d61a7a2c5047@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 08, 2018 at 11:37:36AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Cc'ing Eric
>=20
> On 06/08/2018 11:30 AM, Eduardo Habkost wrote:
> > All of the supported build platforms documented in qemu-doc.texi
> > should already support Python 2.7.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05173.html
>=20
>   On 08/25/2017 11:40 AM, Peter Maydell wrote:
>   > Our choices about our dependencies are generally driven by "what
>   > are the versions available on the oldest distros which we wish
>   > to support building QEMU on", which typically is whatever the
>   > long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
>   >
>   > Has somebody checked what that means for our Python version
>   > requirements?
>=20
>   At least this one:
>=20
>   RHEL/CentOS 6: Python-2.6.6

RHEL6 is no longer a target we care about and is being explicitly
broken as a result of the min glib bump:

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02104.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
