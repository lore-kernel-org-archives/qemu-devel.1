Received: from eggs.gnu.org ([2001:4830:134:3::10]:41897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFGFT-0002Vh-T6
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFGFO-0001tH-Us
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:14:15 -0500
Date: Thu, 16 Nov 2017 10:14:05 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171116091405.pleud7qrqzu5nzhb@eukaryote>
References: <20171115090947.29883-1-kchamart@redhat.com>
	<0b29e074-6548-d42e-12ab-67419342773e@redhat.com>
	<20171115215433.fpihpl645mlholgo@eukaryote>
	<6ac3e1b3-d3b0-afe4-4d87-e8c421084d7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ac3e1b3-d3b0-afe4-4d87-e8c421084d7f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qapi: block-core: Clarify
 events emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com

On Wed, Nov 15, 2017 at 04:56:13PM -0500, John Snow wrote:
>=20
>=20
> On 11/15/2017 04:54 PM, Kashyap Chamarthy wrote:
> > On Wed, Nov 15, 2017 at 02:15:57PM -0500, John Snow wrote:

[...]

> >> is it covered sufficiently in live-block-operations.rst ?
> >=20
> > I looked in there[2] too.  Short answer: no.  Long: In the "Live disk
> > synchronization =E2=80=94 drive-mirror and blockdev-mirror" section, =
I simply
> > seemed to declare:=20
> >=20
> >     "Issuing the command ``block-job-cancel`` after it emits the even=
t
> >     ``BLOCK_JOB_CANCELLED``"
> >=20
> > As if that's the *only* event it emits, which is clearly not the case=
.
> > So while at it, wonder if should I also update it
> > ('live-block-operations.rst') too.
> >=20
>=20
> It's an interesting gotcha that I wasn't really acutely aware of myself=
,
> so having it in the doc format for API programmers who aren't
> necessarily digging through our source sounds like a pleasant courtesy.

Indeed, will do.  (Just for my own clarity, did you imply: don't update
it in block-core.json?  FWIW, my first instinct is to check the QAPI
documentation for such things, that's why I wrote there first :-))

Thanks for looking.

[...]

--=20
/kashyap
