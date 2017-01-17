Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTREL-0006RG-N1
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cTREH-0008Ku-0m
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:43:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cTREG-0008JA-Rl
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:43:04 -0500
Date: Tue, 17 Jan 2017 10:42:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170117104258.GD2053@work-vm>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
	<CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Liviu Ionescu <ilg@livius.net>, QEMU Developer <Qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 9 January 2017 at 17:47, Liviu Ionescu <ilg@livius.net> wrote:
> > I can't dispute this, but does't the GPLv2 requirements apply to
> > the qemu executable only? my JSON files are not compiled into the
> > binary, but are data files, read by the executable when required.
> > and anyway, the original license covers the original XML files,
> > mine are not only JSON, but are also slightly different.
>=20
> I'm not a lawyer, and this isn't legal advice, but merely
> my own opinion:
>  (1) if you're reading in the data files at runtime then there's
> a spectrum between "just reading data provided by the user which
> didn't ship with QEMU, and QEMU works OK without this particular
> data" (clearly OK) and "reading data that shipped with QEMU
> and where QEMU won't work at all without it" (the data files
> are clearly part of the program as a whole and the GPL
> applies to them even if they don't happen to be binaries);
> where you stand legally probably depends on where on the
> spectrum you are.
>=20
>  (2) your JSON files are a derived work from the original
> XML, so the license of those XML files (whatever it is) still
> applies to them. Making modifications or a mechanical
> transformation of the original files is not sufficient to
> allow you to discard the license...
>=20
> With my project maintainer hat on, I prefer to avoid
> grey areas, because it avoids potential trouble later on.

Being able to read a machine description from a file at run time
sounds reasonable, as do tools to manipulate those descriptions.
I don't see why such a description file would be any different
=66rom a firmware file or config file, especially if you were to think
of QEMU in this case more like a simulation environment
which I think is what Liviu is trying to use it as.

I agree actually including/distributing those description files is a comple=
tely
different issue if they're derived from someone elses files;
but that wouldn't stop you creating some simple examples (e.g.
the existing related machine types) from scratch.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
