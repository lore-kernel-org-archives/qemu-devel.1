Received: from eggs.gnu.org ([209.51.188.92]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s4I-0002LG-F2
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1s4H-0003CK-MZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:24:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1s4H-0003C5-G3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:24:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0395307E06A
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 12:24:08 +0000 (UTC)
Date: Thu, 7 Mar 2019 12:23:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307122358.GV32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227145755.26556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227145755.26556-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] ui: support for authorization control
 on TLS connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

ping - soft freeze is less than a week away & i'd like this to get into
a ui queue pull request in time for 4.0 if there's no review objections

On Wed, Feb 27, 2019 at 02:57:53PM +0000, Daniel P. Berrang=C3=A9 wrote:
> This series provides the VNC parts of the authorization control series
> previously posted as:
>=20
>   v1: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg04482.ht=
ml
>   v2: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg05727.ht=
ml
>   v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01639.ht=
ml
>   v4: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg04319.ht=
ml
>=20
> The core authz framework is now merged & these patches have all had
> positive review. Thus these VNC parts are ready to go into the VNC
> maintainer's tree, should the maintainer consider them acceptable.
>=20
> Note the 2nd patch is modifying the HMP, but I considered it part
> of ui/vnc, since that's the only bit of QEMU which ever used these
> HMP commands, and it has a dependancy on the first patch merging
> first.
>=20
> Daniel P. Berrang=C3=A9 (2):
>   vnc: allow specifying a custom authorization object name
>   monitor: deprecate acl_show, acl_reset, acl_policy, acl_add,
>     acl_remove
>=20
>  monitor.c            | 23 ++++++++++++++++++
>  qemu-deprecated.texi | 11 +++++++++
>  qemu-options.hx      | 35 ++++++++++++++++++--------
>  ui/vnc.c             | 58 +++++++++++++++++++++++++++++++++++++-------
>  4 files changed, 108 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
