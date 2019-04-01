Received: from eggs.gnu.org ([209.51.188.92]:51995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hB6fJ-0003an-Q3
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hB6fH-0002ZP-KM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:48:33 -0400
Date: Mon, 1 Apr 2019 20:38:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190401233818.GA22884@habkost.net>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
	<87h8bmuj2d.fsf@zen.linaroharston>
	<2546bf3e-2009-5a76-bc63-0ad73d333a78@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2546bf3e-2009-5a76-bc63-0ad73d333a78@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/9] cpu/topology: add ARM support for smp
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, like.xu@intel.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Apr 01, 2019 at 10:56:30AM +0800, Like Xu wrote:
> On 2019/3/29 17:27, Alex Benn=E9e wrote:
[...]
> > > @@ -1713,6 +1717,9 @@ static void cortex_a9_initfn(Object *obj)
> > >   #ifndef CONFIG_USER_ONLY
> > >   static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegI=
nfo *ri)
> > >   {
> > > +    MachineState *ms =3D MACHINE(qdev_get_machine());
> >=20
> > How expensive is qdev_get_machine? This could potentially be a
> > performance issue if this register is read a lot.
>=20
> It may not bother us cause the MachineState object would be feteched fr=
om
> qemu QOM at its first requested time and save it as static variable for
> incoming requests.

We already have a current_machine variable declared in
include/hw/boards.h.  We normally avoid using it and use
MACHINE(qdev_get_machine()) instead, but I never understood why.

--=20
Eduardo
