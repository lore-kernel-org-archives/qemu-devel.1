Received: from eggs.gnu.org ([2001:4830:134:3::10]:35603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmr9R-0000jT-F3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 20:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmr9N-0000NU-Ed
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 20:46:37 -0400
Date: Wed, 30 Aug 2017 10:43:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170830004309.GA3386@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170828175356.GB26893@ram.oc3035372033.ibm.com>
	<20170829014030.GD2578@umbus.fritz.box>
	<20170829163107.GC26893@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20170829163107.GC26893@ram.oc3035372033.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2017 at 09:31:07AM -0700, Ram Pai wrote:
> On Tue, Aug 29, 2017 at 11:40:30AM +1000, David Gibson wrote:
> > On Mon, Aug 28, 2017 at 10:53:56AM -0700, Ram Pai wrote:
> > > On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > > >=20
> > > > We could either have two u16 fields for the number of keys for data
> > > > and instruction, or we could have a u32 field for the number of keys
> > > > and a separate bit in the flags field to indicate that instruction
> > > > keys are supported.  Which would be preferable?
> > >=20
> > > the second choice is more confusion-proof; to me atleast.
> > >=20
> > > The first choice gives a illusion that there are 'x' number of data k=
eys
> > > and 'y' number of instruction keys; which is not exactly true.
> >=20
> > Ah.. can you elaborate?
>=20
> On power8 and power9, there are only 32 keys, each key can be configured =
to
> disable data-access and instruction-access.  The first choice, will
> report 32 keys for data-access and 32 keys for instruction-access. To a
> casual on-looker it gives an impresssion that there are 32 keys for
> data-access and 32 keys for instruction-access; 64 keys in total. And
> that is what I think can be the cause for confusion.

Ah, I see.

Paul, sorry, I hadn't realized the above when I said I preferred
separate values for data and instr keys.  In view of the above, I
change my preference to a single # of keys and a flag that they can be
used for instructions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmmChoACgkQbDjKyiDZ
s5LRUw/+PMBnRS0AgJbaFU0tg+XQoksKQYyCMls8cNCEKaOZYK5MZHmJuOQshOpL
xzxQjzKKof8Wc4uX7XzRDnl9wd1B+E0/dgnOZQTxxGzq2itWQ/cbcvOr1KZRZ/0T
DQwKn5uHymV4J85782MSXHI6SL8H6ejrDK8ALz9J702feb9tSM3mlKOgzk2XwAWk
/PaylXyo0xAi7qk8EPLWM6xO5V8WaxRsvUCMsB9+77cCMiyLpYFcIV+jQWbLp6HW
70xZV93Qt7usN7hbmiDjJvaW4z/KY9qIHffhgCusvcuUldgUaH2WyeFxzq7/e1op
0E+SovjTdne/4t6ZGASzxZpD43TACKaorb2fCXbgfVwhcRm+X8mlinD+vZHKpeq7
WdgqNLJKxuRU1TuJFLPaMCv/W6OebXAb04uYsAkoTIwdW5jtghrELt0YWTnlhLSg
P7Phhcelqqkp4OAf3+mfR4c96K8V64PtoRBN5xdpuICdpUUkLdiIg6gtZsRXoc2Z
lEej8/xbu59ZrwsLhiUu8sO+6vmtsODua13GipAnEs3nY5Cu9vM5bmJMDh0CsWlE
9lBuJGfSDvbmTESuy6+h91LjWiBT9ktQca2lQnSduyq+Vap+xHvN9u7/jLxAJpNu
zg/SoMGNsTxQKLJ885V5LDvAGBhxzTyHYm3YyLlOk2dhRnVGA6A=
=C0Q2
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
