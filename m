Received: from eggs.gnu.org ([2001:4830:134:3::10]:49112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQqaL-0006si-PL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQqaI-0001pV-Lq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:47:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQqaI-0001oR-GD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:47:54 -0400
Date: Thu, 7 Jun 2018 09:47:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607084749.GF28827@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
	<183c8b5c-a76c-ce69-4999-19203a1cc0cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <183c8b5c-a76c-ce69-4999-19203a1cc0cf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of
 glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Thu, Jun 07, 2018 at 10:44:15AM +0200, Thomas Huth wrote:
> On 06.06.2018 19:32, Daniel P. Berrang=C3=A9 wrote:
> > Code must only ever include glib.h indirectly via the glib-compat.h
> > header file, because we will need some macros set before glib.h is
> > pulled in. Adding extra includes of glib.h will (soon) cause compile
> > failures such as:
> >=20
> > In file included from /home/berrange/src/virt/qemu/include/qemu/osdep=
.h:107,
> >                  from /home/berrange/src/virt/qemu/include/qemu/iova-=
tree.h:26,
> >                  from util/iova-tree.c:13:
> > /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_V=
ERSION_MIN_REQUIRED" redefined [-Werror]
> >  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> >=20
> > In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
> >                  from /usr/include/glib-2.0/glib/galloca.h:32,
> >                  from /usr/include/glib-2.0/glib.h:30,
> >                  from util/iova-tree.c:12:
> > /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the lo=
cation of the previous definition
> >  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
>=20
> In case you respin this series, should the order of patch 2 and 3 be
> swapped? ... so that we keep the tree bisectable?

Yes it should be.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
