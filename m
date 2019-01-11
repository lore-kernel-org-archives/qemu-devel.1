Received: from eggs.gnu.org ([209.51.188.92]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi27Z-0007kR-MZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi27Y-0001jy-WC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:05:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gi27Y-0001hl-P8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:05:32 -0500
Date: Fri, 11 Jan 2019 17:05:28 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190111190528.GQ4500@habkost.net>
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
	<87sgxzusb7.fsf@linaro.org>
	<3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
	<87pnt3uqjl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87pnt3uqjl.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, cota@braap.org

On Fri, Jan 11, 2019 at 04:06:54PM +0000, Alex Benn=E9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 11/01/19 16:28, Alex Benn=E9e wrote:
> >>> Why not g_usleep?  It already does a while loop around nanosleep (w=
hich
> >>> returns the remaining time in the wait, like select but unlike slee=
p and
> >>> poll).
> >> Yeah I'm testing that now. However I have managed to trigger:
> >>
> >>   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D=
 0): (35584 =3D=3D 0)
> >
> > I think that's a good old SIGSEGV (0x8B00).
>=20
> According to the PC in the logs:
>=20
>   Line 98 of "mcount.c" starts at address 0x7ffff6e15145 <__mcount_inte=
rnal+69> and ends at 0x7ffff6e15148 <__mcount_internal+72>.

Was this on Travis?  Which architecture?

--=20
Eduardo
