Received: from eggs.gnu.org ([2001:4830:134:3::10]:46900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fEJv9-0005Sm-Q5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fEJv6-0004id-Ln
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fEJv6-0004iN-Ed
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:29:36 -0400
Date: Thu, 3 May 2018 16:29:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180503192930.GE25013@localhost.localdomain>
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
	<87604ekl0c.fsf@linaro.org>
	<2f69532c-8651-ef67-0910-1fad91808608@redhat.com>
	<874ljxlseb.fsf@linaro.org>
	<2d9d341e-008e-1f84-7a20-5956b4506db3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2d9d341e-008e-1f84-7a20-5956b4506db3@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Thu, Apr 26, 2018 at 08:53:29PM +0200, Thomas Huth wrote:
> On 26.04.2018 20:44, Alex Benn=E9e wrote:
> >=20
> > Thomas Huth <thuth@redhat.com> writes:
> >=20
> >> On 26.04.2018 18:09, Alex Benn=E9e wrote:
> >>>
> >>> Thomas Huth <thuth@redhat.com> writes:
> >>>
> >>>> On 25.04.2018 17:33, Alex Benn=E9e wrote:
> >>>>> People following old instructions for QEMU get the message "No ma=
chine
> >>>>> specified, and there is no default" and run -machine help to pick=
 a
> >>>>> new machine. Lay people might consider the null-machine to be suc=
h a
> >>>>> basic starting point but they won't get far. This leads to confus=
ion,
> >>>>> see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.
> >>>>>
> >>>>> I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YO=
U
> >>>>> WANT" seemed less helpful though.
> >>>>>
> >>>>> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> ---
> >>>>>  hw/core/null-machine.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> >>>>> index cde4d3eb57..72f0815045 100644
> >>>>> --- a/hw/core/null-machine.c
> >>>>> +++ b/hw/core/null-machine.c
> >>>>> @@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch=
)
> >>>>>
> >>>>>  static void machine_none_machine_init(MachineClass *mc)
> >>>>>  {
> >>>>> -    mc->desc =3D "empty machine";
> >>>>> +    mc->desc =3D "empty machine (for probing/QMP)";
>=20
> Actually, thinking about this again, what about something like:
>=20
>  "empty machine (for experts only)"
>=20
> or:
>=20
>  "empty machine (use only if you know what you are doing)"
>=20
> or something similar?

I think a note like this would be a good idea, but it would be
even better if we actually document the purpose and caveats of
-machine none on the man page.

--=20
Eduardo
