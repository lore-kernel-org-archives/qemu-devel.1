Received: from eggs.gnu.org ([2001:4830:134:3::10]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gYPn3-00072l-6D
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gYPmz-00017j-3L
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:20:37 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gYPmv-00012n-4V
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:20:30 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so9126119wrx.9
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 22:20:26 -0800 (PST)
Date: Sun, 16 Dec 2018 06:20:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181216062024.GA6123@stefanha-x1.localdomain>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-6-contrib@steffen-goertz.de>
	<CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
	<e1e4c8d7-cb81-7f1d-ae38-a4cac5c85a48@steffen-goertz.de>
	<CAFEAcA_Du4OTLqfNECY=BTvW089RTNu3qpxm2yv=iLL9g-m5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Du4OTLqfNECY=BTvW089RTNu3qpxm2yv=iLL9g-m5qQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/14] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:43:59PM +0000, Peter Maydell wrote:
> On Mon, 26 Nov 2018 at 00:24, Steffen G=F6rtz <mail@steffen-goertz.de> wr=
ote:
> >
> > Hi Peter,
> >
> > thank you for your remarks!
> >
> > >> +};
> > >> +
> > >> +static uint64_t ficr_read(void *opaque, hwaddr offset
> > >
> > >> +            value &=3D ~(NRF51_PAGE_SIZE - 1);
> > >> +            if (value < (s->flash_size - NRF51_PAGE_SIZE)) {
> > >> +                memset(s->storage + value / 4, 0xFF, NRF51_PAGE_SIZ=
E);
> > >
> > > Can the guest try to execute from the flash storage? If so
> > > then just updating the backing storage directly like this is
> > > not sufficient to ensure that QEMU discards any now-stale
> > > translated code blocks from the affected memory.
> >
> > What else is necessary to invalidate stale blocks?
>=20
> You need an AddressSpace that points to the MemoryRegion(s)
> you're altering, and you need to use the operations on
> the AddressSpace like address_space_write(). These will
> under the hood do the right thing with TB invalidation.

I'm not sure about this.  The memory region looks like this:

{parent_obj =3D {class =3D 0x5555565ee350, free =3D 0x0, Python Exception <=
class 'gdb.error'> There is no member named keys.:
properties =3D 0x55555672f860, ref =3D 1, parent =3D 0x5555566620f0}, romd_=
mode =3D true, ram =3D false, subpage =3D false, readonly =3D false,
  nonvolatile =3D false, rom_device =3D true, flush_coalesced_mmio =3D fals=
e, global_locking =3D true, dirty_log_mask =3D 0 '\000', is_iommu =3D false=
, ram_block =3D 0x555556768b40,
  owner =3D 0x5555566620f0, ops =3D 0x55555615d360 <flash_ops>, opaque =3D =
0x5555566620f0, container =3D 0x0, size =3D 262144, addr =3D 0, destructor =
=3D 0x555555893f00 <memory_region_destructor_ram>,
  align =3D 2097152, terminates =3D true, ram_device =3D false, enabled =3D=
 true, warning_printed =3D false, vga_logging_count =3D 0 '\000', alias =3D=
 0x0, alias_offset =3D 0, priority =3D 0, subregions =3D {
    tqh_first =3D 0x0, tqh_last =3D 0x555556662778}, subregions_link =3D {t=
qe_next =3D 0x0, tqe_prev =3D 0x0}, coalesced =3D {tqh_first =3D 0x0, tqh_l=
ast =3D 0x555556662798},
  name =3D 0x5555568033d0 "nrf51_soc.flash", ioeventfd_nb =3D 0, ioeventfds=
 =3D 0x0}

I see nothing that invalidates TBs in the address_space_write() code for
MMIO memory regions (not RAM).  Only the RAM case calls
invalidate_and_set_dirty().

There are a few complications with this device:

1. Stores from the CPU are only honored when the NRF51_NVMC_CONFIG_WEN
   write enable bit is set.  NRF51_NVMC_ERASEPCRx and
   NRF51_NVMC_ERASEALL commands use a separate erase enable bit
   (NRF51_NVMC_CONFIG_EEN) and are therefore different from normal
   writes.

2. Stores from the CPU can only flip 1s to 0s (this is NOR flash).  When
   we erase a page of flash memory it must be set to 0xff (i.e. flip
   0s to 1s).

3. nrf51_nvm.c:flash_write() does not mark the page dirty for live
   migration.

My questions:

1. Is the current rom+mmio device approach okay or should it be modelled
   differently?

2. Erase operations cannot use ordinary address_space_write() for the
   reasons mentioned above.  Should this device directly call
   cpu_physical_memory_set_dirty_range() and tb_invalidate_phys_range()?

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcFe6nAAoJEJykq7OBq3PIwPUH/Rr9HFC3WCDGIYXgxferaVzJ
hmGZad52IsfIivAEeQyF4tSbEevtcaMIARj2A0YWavnbAsIIFAPWX2b8K2oOr5a5
QYYaCYGS7Y7gBVjCXnmmGB/IaXffdfqdC3ji6OvEjxrbn5auavqt8ywud3oYkTfS
MlTf+nPf3rlyNSILt3RM1lpO2ZWOAh1NL+/yFbC6lk1l3h8LWql0Z7WDEAKHeS7l
J1bGHx3Tu9yBCbVF5rx37K7hQkptk3tvzDYlkNmxbC9OxcDaXkRM6Ufj2QEt45w8
ZsIGOz0esEhJsGETKCxB1QpWWV7DXcuvh+zqfUFVTJ5nzlOVuxKtUwzXVq/ADQ4=
=onWr
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
