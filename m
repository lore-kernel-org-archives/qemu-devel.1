Received: from eggs.gnu.org ([2001:4830:134:3::10]:49482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdCA-0005CX-4x
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdC6-0001Ih-Tm
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:04:46 -0500
Received: from mail.avalus.com ([89.16.176.221]:52583)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cMdC6-0001Gh-Nf
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:04:42 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161228001855.ukrtvzeictke4ex2@grep.be>
Date: Thu, 29 Dec 2016 16:04:38 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <E57C32F9-8732-4F5F-AA67-997BB729F339@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<0F1DC4AE-5C9E-4AE6-8141-AE6B398EBF73@alex.org.uk>
	<2812e3e2-983a-42de-a55f-590a87b7fece@virtuozzo.com>
	<20161228001855.ukrtvzeictke4ex2@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


> On 28 Dec 2016, at 00:18, Wouter Verhelst <w@uter.be> wrote:
>=20
> On Mon, Dec 26, 2016 at 05:52:54PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Shouldn't we add some flags to REP_META_CONTEXT, for client to be =
insure, is
>> returned string a direct context name or some kind of wildcard? Just =
a flags
>> field, with one flag defined for now: NBD_REP_META_CONTEXT_LEAF and =
others
>> reserved.
>=20
> I think it should be up to the metadata context namespace definition =
to
> define which syntax represents a direct context name and which
> represents a wildcard (if the latter are supported).
>=20
> A client which doesn't know what a given metadata context implements
> can't reasonably ask for information from that context anyway (since
> then the client wouldn't know what to do with the returned =
information),
> so it doesn't help much to add a flag here.

I agree.

Vladimir: if this isn't clear from the text, please suggest a change.

--=20
Alex Bligh
