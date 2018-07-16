Received: from eggs.gnu.org ([2001:4830:134:3::10]:34836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ff0On-0006zB-TN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ff0Om-0004WF-Uj
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:06:33 -0400
Date: Mon, 16 Jul 2018 12:06:23 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180716100623.GP18181@paraplu>
References: <CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<CAFEAcA9J=Jmd=+9vEo4LLdk0LcL42fchHcAp3fp_+9q1tsCoNg@mail.gmail.com>
	<87tvp8or4u.fsf@dusky.pond.sub.org>
	<20180709130838.16f011a4.cohuck@redhat.com>
	<20180709111701.GF23731@redhat.com>
	<87601lge0i.fsf@dusky.pond.sub.org>
	<751b33cb-d7da-ef47-415d-86b0e3c31129@redhat.com>
	<20180713133502.4e257017.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180713133502.4e257017.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On Fri, Jul 13, 2018 at 01:35:02PM +0200, Cornelia Huck wrote:
> On Thu, 12 Jul 2018 17:47:00 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> > On 12.07.2018 08:32, Markus Armbruster wrote:
> > > Daniel P. Berrang=E9 <berrange@redhat.com> writes: =20

[...]

> > > Our tool to help with getting cc: wrong less often is the MAINTAINE=
RS
> > > file.  Could one of the libvirt developers watch changes to qemu-do=
c
> > > appendix "Deprecated features"?  Would putting the appendix in its =
own
> > > .texi help with that? =20
> >=20
> > Sound like a good idea to put the appendix in its own texi file. Then
> > add an "R: libvir-list" entry for that file to MAINTAINERS and we sho=
uld
> > be fine (at least for the people who use the get_maintainers.pl scrip=
t).
>=20
> +1, like that idea
>=20
> Are there other consumers of QEMU's interfaces which should be cc:ed in
> a similar way?

Perhaps starting with libvirt is fine -- as most of the open source
management applications rely on it.  (But if we do know other consumers,
then they can be trivially added.)

--=20
/kashyap
