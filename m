Received: from eggs.gnu.org ([209.51.188.92]:36071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEZGu-0002uW-T9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEZ5S-0001NK-B5
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:45:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEZ5S-0001N2-37
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:45:50 -0400
Date: Thu, 11 Apr 2019 13:45:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190411124535.GS3641@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
	<20190411115216.GN3641@redhat.com>
	<87v9zkzqb8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v9zkzqb8.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Lidong Chen <lidong.chen@oracle.com>, "darren.kenny@oracle.com" <darren.kenny@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "f4bug@amsat.org" <f4bug@amsat.org>

On Thu, Apr 11, 2019 at 02:20:27PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Tue, Apr 09, 2019 at 11:37:44AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> [...]
> >> I remember this post from Daniel where he suggests sticking to GLib
> >> G_N_ELEMENTS() (which looks similar to your suggestion):
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html
> >>=20
> >> $ git grep G_N_ELEMENTS|wc -l
> >> 125
> >> $ git grep ARRAY_SIZE|wc -l
> >> 939
> >>=20
> >> Now it is not obvious to me to understand which GLib API we are
> >> encouraged to use and which ones we shouldn't.
> >
> > We have a bunch of duplication that is essentially a historical
> > artifact from before we used GLib in QEMU. IMHO, if GLib provides
> > something that is equivalent with no functional downside that
> > matters to QEMU, then there's no reason to keep QEMU's duplicate.
> >
> > IOW, I would always prefer GLib unless there's a compelling reason
> > not to in order to minimize what we maintain ourselves
>=20
> Without a tree-wide sweep, we won't ever stop maintaining ARRAY_SIZE().

In this case it is a pretty trivial search & replace to do. The main
hard bit would be syncing with various maintainer trees. Global cleanups
are more work if you need to feed patches in via several different trees,
as opposed to one tree-wide series.

> As long as we maintain it anyway, I'd prefer it over G_N_ELEMENTS()
> myself, because I consider latter name in poor taste: elements of
> *what*?

elements of the variable that you are passing into the macro.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
