Received: from eggs.gnu.org ([2001:4830:134:3::10]:53030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cKM1o-0001KA-Ky
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cKM1j-00008d-Hy
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:20:40 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:57742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cKM1j-00007Q-AT
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:20:35 -0500
Date: Fri, 23 Dec 2016 04:20:32 -0500 (EST)
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <1742192160.5141190.1482484832078.JavaMail.zimbra@redhat.com>
In-Reply-To: <6897002c-9618-ba6b-3d42-8595bb13ac09@tuxfamily.org>
References: <585c0f59.2350c20a.e5711.e639@mx.google.com>
	<6897002c-9618-ba6b-3d42-8595bb13ac09@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virus in colibriOS QEMU iso?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: vilcadam@gmail.com, qemu-devel@nongnu.org, Kashyap Chamarthy <kashyapc@fedoraproject.org>

[...]

> On 22.12.2016 18:37, vilcadam@gmail.com wrote:
> > Hi, just letting you know that Avira found some crypto-locker virus in
> > ColibriOS iso that you featured in QEMU Advent Calendar 2016. Maybe you
> > should look into that. I am not sure if it=E2=80=99s a false positive o=
r not.. You
> > can check the attachment for a screenshot  of the result.
>=20
> That sounds ugly ...=20

That sounds super ugly indeed :-(

> I think we just packaged the .iso from the official
> KolibriOS website here (Kashyap, can you confirm?),

Yes, I can confirm that I have downloaded the ISO from the=20
official website -- it's a nightly build of their=20
SVN revision 6766.

These are local notes on preparing sources from=20
the day I made the image (where the SVN revision=20
was at 6766):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
$ svn checkout svn://kolibrios.org -r 6766

$ svn log | head -5
------------------------------------------------------------------------
r6766 | IgorA | 2016-11-26 23:57:24 +0100 (Sat, 26 Nov 2016) | 1 line

fix bugs

$ du -sh ../sources-kolibrios/
1.4G    ../sources-kolibrios/

$ du -sh .svn/
662M    .svn/

$ rm -rf .svn

$ du -sh ../sources-kolibrios-rev-6766/
691M    ../sources-kolibrios-rev-6766/

$ tar -cJf sources-kolibrios-rev-6766.tar.xz sources-kolibrios-rev-6766/

$ du -sh sources-kolibrios-rev-6766.tar.xz=20
93M     sources-kolibrios-rev-6766.tar.xz
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> so if this is not
> just a false positive, the problem very likely comes from there.

Indeed.

> If you've got some spare minutes, could you maybe check the download
> from http://kolibrios.org/en/download , too?
>=20
> As far as I can see, there should not be any real danger here unless you
> put the .iso file onto a real CD-ROM or USB stick and start the .exe
> files in there (which is of course not necessary for starting a VM with
> the .iso file).=20

Yes, exactly, but still this incident is not nice to hear.

> But anyway, this needs some closer investigation, to see
> whether it's a false positive or not, so I've disabled that download for
> now. We'll let you know when we know more ... Thanks for reporting the
> issue!

Yes, thanks for bringing it up. I'm afraid, I'm a little short=20
on time, but will try to investigate later today.

Regards,
Kashyap
