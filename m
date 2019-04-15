Received: from eggs.gnu.org ([209.51.188.92]:46278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3tQ-0005FD-M9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG3tP-00073T-Fq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG3tP-00071e-7B
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:51:35 -0400
Date: Mon, 15 Apr 2019 16:51:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415155125.GN5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190415141547.15444-1-berrange@redhat.com>
	<CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
	<0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 15, 2019 at 10:25:03AM -0500, Eric Blake wrote:
> On 4/15/19 9:25 AM, Peter Maydell wrote:
> > On Mon, 15 Apr 2019 at 15:17, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >>
>=20
> > A few typo nits below...
>=20
> Also:
>=20
> >=20
> >>
> >> +    /*
> >> +     * Ideally we would set LC_ALL, but QEMU currently isn't able t=
o cope
> >> +     * with arbitrary localization settings. In particular there ar=
e two
> >> +     * known problems
>=20
> "two known problems" but...
>=20
> >> +     *
> >> +     *   - The QMP monitor needs to use the C locale rules for nume=
ric
> >> +     *     formatting. This would need a double/int -> string forma=
tter
> >> +     *     that is locale independant.
> >=20
> > "independent"
> >=20
> >> +     *
> >> +     *   - The QMP monitor needs to encode all data as UTF-8. This =
needs
> >> +     *     to be updated to use iconv(3) to explicitly convert the =
current
> >> +     *     locale's charset into utf-8
> >> +     *
> >> +     *   - Lots of codes uses is{upper,lower,alnum,...} functions, =
expecting
> >=20
> > "code"
> >=20
> >> +     *     C locale sorting behaviour. Most QEMU usage should likel=
y be
> >> +     *     changed to g_ascii_is{upper,lower,alnum...} to match cod=
e
> >> +     *     assumptions, without being broken by locale settnigs.
> >=20
> > "settings"
>=20
> ...three bullet points.

Heh, I knew I should have used "some" instead of "two" earlier when
first writing this. It was inevitable I'd think of another problem
to add :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
