Received: from eggs.gnu.org ([2001:4830:134:3::10]:57974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1ccG2i-0007T6-8i
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juro.bystricky@intel.com>) id 1ccG2d-0000Ag-8R
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:35:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:60201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juro.bystricky@intel.com>)
	id 1ccG2c-00007Z-UY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:35:31 -0500
From: "Bystricky, Juro" <juro.bystricky@intel.com>
Date: Fri, 10 Feb 2017 18:35:24 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6118FCCE4@ORSMSX112.amr.corp.intel.com>
References: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
	<301d03bb-8352-95ad-80c7-638e5ea7a4f5@greensocs.com>
In-Reply-To: <301d03bb-8352-95ad-80c7-638e5ea7a4f5@greensocs.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marex@denx.de" <marex@denx.de>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, "crwulff@gmail.com" <crwulff@gmail.com>

Hello Konrad,=20
I agree with all your comments.

[...]

> > +static void altera_juart_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AlteraJUARTState *s =3D ALTERA_JUART(obj);
> > +
> > +    memory_region_init_io(&s->mmio,  OBJECT(s), &juart_ops, s,
> > +                          TYPE_ALTERA_JUART, 2 * 4);
>=20
> What's this 2 * 4?
> I'd suggest you use a #define for that.

yes, not very clear it is the memory size, will redo

[...]

> > +    chr =3D serial_hds[channel];
> > +    if (!chr) {
> > +        snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
> > +        chr =3D qemu_chr_new(label, "null");
> > +        if (!chr) {
> > +            error_report("Can't assign serial port to altera juart%d",
> channel);
>=20
> Can't you reuse label?
>=20

Will rework the message to use "label"

[...]


> > +#define DEFAULT_FIFO_SIZE 64
>=20
> The name here might conflict with other thing.
> I'd change that by ALTERA_JUART_DEFAULT_FIFO_SZ or something.
>=20
>=20

I agree, will rename

[...]

>=20
> The rest seems ok to me.
>=20


Thanks for reviewing the code.
Juro
