Received: from eggs.gnu.org ([208.118.235.92]:51365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1Mm-0006Bo-7G
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <npes87184@gmail.com>) id 1gf1Ml-0000Y7-9r
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:40:48 -0500
MIME-Version: 1.0
References: <20181223025939.15775-1-npes87184@gmail.com>
	<20181223025939.15775-2-npes87184@gmail.com>
	<20190102114919.GJ24009@stefanha-x1.localdomain>
	<CAPTqjH1K3RYH1A2Q8Fhkh5x6hOE5CU9qTqRtjFC8WLk3UBNFOA@mail.gmail.com>
	<20190103100923.GC7733@stefanha-x1.localdomain>
In-Reply-To: <20190103100923.GC7733@stefanha-x1.localdomain>
From: Yu-Chen Lin <npes87184@gmail.com>
Date: Thu, 3 Jan 2019 19:40:10 +0800
Message-ID: <CAPTqjH1x+ZJ9HnsaZ61KQGv-qksHuSm6KDy0P0-zW633tT8ttQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] dmg: fix binary search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Stefan Hajnoczi <stefanha@redhat.com> =E6=96=BC 2019=E5=B9=B41=E6=9C=883=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:09=E5=AF=AB=E9=81=93=EF=BC=9A

> On Wed, Jan 02, 2019 at 08:20:54PM +0800, =E6=9E=97=E8=82=B2=E8=BE=B0 wro=
te:
> > This series is focus on fixing bug #1809304 (see:
> > https://bugs.launchpad.net/qemu/+bug/1809304).
> > There is an example dmg file in #1809304 which will trigger this bug.
>
> Thanks.  It would be great to include a tiny dmg file in
> tests/qemu-iotests/sample_images/ and add a test case for it.
>
> The file should be small (kilobytes, not megabytes) and must be
> redistributable (no proprietary content or even GPL software, which
> requires distributing source code).
>
> Do you have time to do that?
>

Sure!


>
> > About your case, I think we can simply check whether chunk3 is zero
> before
> > we decrease it.
> > if s->sectors[chunk3] > sector_num and chunk3 is zero (i.e.
> s->sectors[0] >
> > sector_num), it means we cannot find the table contains sector_num.
> > We can return s->n_chunks (error) directly.
> >
> > What do you think?
>
> Sounds good.  We have to assume that the file contents are invalid and
> handle all cases.
>
> I'll review the next revision of your patch.  Thanks!
>

Thanks!

Yu-Chen Lin


> Stefan
>
