Received: from eggs.gnu.org ([2001:4830:134:3::10]:46237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXMiH-00016c-R5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fXMiE-0008Pe-Kf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:19:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fXMiE-0008Op-FU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:19:02 -0400
Date: Mon, 25 Jun 2018 10:18:59 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180625081859.GC18277@paraplu>
References: <20180615141609.20749-1-berrange@redhat.com>
	<20180615185805.GE7451@localhost.localdomain>
	<878t7cskaz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <878t7cskaz.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: add guidance on configuring CPU
 models for x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Jun 18, 2018 at 08:03:32AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Fri, Jun 15, 2018 at 03:16:09PM +0100, Daniel P. Berrang=E9 wrote:
> >> With the recent set of CPU hardware vulnerabilities on x86, it is
> >> increasingly difficult to understand which CPU configurations are
> >> good to use and what flaws they might be vulnerable to.
> >>=20
> >> This doc attempts to help management applications and administrators=
 in
> >> picking sensible CPU configuration on x86 hosts. It outlines which o=
f
> >> the named CPU models are good choices, and describes which extra CPU
> >> flags should be enabled to allow the guest to mitigate hardware flaw=
s.
> >>=20
> >> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> >
> > Thank you very much.
> >
> > I wonder how we could reference this from the man page and
> > qemu-doc.html without saying "look at the QEMU source tree".
>=20
> Same way as the other contents there.
>=20
> > (I'm not willing to rewrite this using texinfo to make that
> > happen.)
>=20
> Texinfo is simple.
>=20
> If all else fails, ask for my help after soft freeze.

If someone already hasn't done it, I can help rewrite it.  (It'll let me
try out 'Texinfo' in real and I have to deal with CPU modelling aspects
elsewhere in the higher-level tools. :-))

--=20
/kashyap
