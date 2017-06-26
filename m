Received: from eggs.gnu.org ([2001:4830:134:3::10]:48733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPWqt-0001bi-BM
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPWqq-0001XP-NU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:27:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dPWqq-0001WV-HG
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:27:00 -0400
Date: Mon, 26 Jun 2017 17:26:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626162652.GE24743@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1496975122-16999-1-git-send-email-cota@braap.org>
	<1496975122-16999-8-git-send-email-cota@braap.org>
	<20170626082844.GA4181@redhat.com> <87d19rf6p5.fsf@frigg.lan>
	<877ezy7m7v.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877ezy7m7v.fsf@frigg.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 7/7] trace: [trivial] Statically enable
 all guest events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jun 26, 2017 at 07:22:28PM +0300, Llu=C3=ADs Vilanova wrote:
> Llu=C3=ADs Vilanova writes:
>=20
> > Daniel P Berrange writes:
> >> On Thu, Jun 08, 2017 at 10:25:22PM -0400, Emilio G. Cota wrote:
> >>> From: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> >>>=20
> >>> The optimizations of this series makes it feasible to have them
> >>> available on all builds.
>=20
> >> I'm not saying you're wrong, but where is the data to backup this
> >> assertion ?
>=20
> >> IMHO, this commit message should be describing how performance was
> >> tested and what the results were.
>=20
> > I can submit a new series with the performance measurements now that =
you've
> > informally OK'ed Emilio's new patch.
>=20
> > Is there some public script to automate that or do I have to cook my =
own?
>=20
> BTW, I just realized that my original cover for v7 did include results:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02741.html
>=20
> Do such numbers need to be in this commit or is the cover fine?

Please do copy that info to the commit message - when someone looks back
at git history in a year's time, they'll have the commit message right
there, but will rarely think to look through the mailing list for a cover
letter with data.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
