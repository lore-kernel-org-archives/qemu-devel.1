Received: from eggs.gnu.org ([2001:4830:134:3::10]:54519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duFzh-0006m4-TV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duFze-0006d4-QU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:43:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duFze-0006cl-L4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:43:06 -0400
Date: Tue, 19 Sep 2017 07:42:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919104259.GB3030@localhost.localdomain>
References: <20170918215719.16415-1-f4bug@amsat.org>
	<20170918225552.GM10621@localhost.localdomain>
	<36b5e019-4f30-666b-7479-df8de0a6f936@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <36b5e019-4f30-666b-7479-df8de0a6f936@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 0/2] Add a valid_cpu_types property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, marcel@redhat.com

On Tue, Sep 19, 2017 at 06:51:23AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 09/18/2017 07:55 PM, Eduardo Habkost wrote:
> > On Mon, Sep 18, 2017 at 06:57:19PM -0300, Philippe Mathieu-Daud=E9 wr=
ote:
> > > add a property to restrict the CPU for SoCs once on machine creatio=
n and avoid
> > > duplicate code in each board.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >=20
> > The valid_cpu_types approach implemented by Alistair is more
> > generic:
> >    Subject: [Qemu-devel] [RFC v1 0/2]  Add a valid_cpu_types property
> >    Message-ID: <cover.1504656490.git.alistair.francis@xilinx.com>
> >=20
> > With it, boards that don't support other CPUs just need to set
> > valid_cpu_types =3D { default_cpu_type }.
>=20
> Oh thank for pointing this out, I missed his series.
>=20
> Many people waiting for Igor series to land ;)

I plan to queue it today, and get a pull request out today or
tomorrow.

--=20
Eduardo
