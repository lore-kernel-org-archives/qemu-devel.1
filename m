Received: from eggs.gnu.org ([2001:4830:134:3::10]:37227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQ8XD-0005zP-4d
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQ8X8-0008R1-VM
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:41:15 -0400
Date: Wed, 28 Jun 2017 16:18:50 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170628081850.GJ12089@umbus>
References: <20170622112648.24815-1-lvivier@redhat.com>
	<caa25331-5005-78e8-fba2-19bf67116d92@redhat.com>
	<20170623092124.GG12089@umbus>
	<c0a0667e-8c60-a8e7-a041-caddac8c8b88@redhat.com>
	<20170628014231.GA791@pacoca>
	<a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fU0UwhtRbpo05rnG"
Content-Disposition: inline
In-Reply-To: <a34435df-8944-ddac-e881-0a2338e4aad4@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: joserz@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sursingh@redhat.com, sbobroff@redhat.com


--fU0UwhtRbpo05rnG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 09:09:24AM +0200, Thomas Huth wrote:
> On 28.06.2017 03:42, joserz@linux.vnet.ibm.com wrote:
> > On Fri, Jun 23, 2017 at 04:10:55PM +0200, Laurent Vivier wrote:
> >> On 23/06/2017 11:21, David Gibson wrote:
> >>> On Thu, Jun 22, 2017 at 01:31:24PM +0200, Thomas Huth wrote:
> >>>> On 22.06.2017 13:26, Laurent Vivier wrote:
> >>>>> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> >>>>>
> >>>>> When we run qemu on a POWER9 DD1 host, we must use either
> >>>>> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> >>>>>
> >>>>>     Unable to find sPAPR CPU Core definition
> >>>>>
> >>>>> because POWER9 DD1 doesn't appear in the list of known CPUs.
> >>>>>
> >>>>> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> >>>>> PVR instead of CPU_POWERPC_POWER9_BASE.
> >>>>>
> >>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>>>> ---
> >>>>>  target/ppc/cpu-models.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> >>>>> index 4d3e635..a22363c 100644
> >>>>> --- a/target/ppc/cpu-models.c
> >>>>> +++ b/target/ppc/cpu-models.c
> >>>>> @@ -1144,7 +1144,7 @@
> >>>>>      POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,             =
   970,
> >>>>>                  "PowerPC 970 v2.2")
> >>>>> =20
> >>>>> -    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_BASE,         =
   POWER9,
> >>>>> +    POWERPC_DEF("POWER9_v1.0",   CPU_POWERPC_POWER9_DD1,          =
   POWER9,
> >>>>>                  "POWER9 v1.0")
> >>>>> =20
> >>>>>      POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,           =
   970,
> >>>>>
> >>>>
> >>>> I think this also makes sense for running in TCG mode to get a valid
> >>>> real PVR there.
> >>>
> >>> I'm not so convinced.
> >>>
> >>> IIUC, this will make TCG default (for now) to a DD1 POWER9.  That's a)
> >>> probably not what anyone wants - who'd select a buggy prototype and b)
> >>> not accurate - TCG does not implement DD1's bugs.
> >>
> >> According to the POWER8 user manual (I didn't fine the POWER9 one):
> >>
> >> "3.6.3.1 Processor Version Register (PVR)
> >>
> >> The processor revision level (PVR[16:31]) starts at x=E2=80=980100=E2=
=80=99, indicating
> >> revision =E2=80=981.0=E2=80=99. As revisions are made, bits [29:31] wi=
ll indicate minor
> >> revisions. Similarly, bits [20:23] indicate major changes."
> >>
> >> POWER9 DD1 PVR is 0x004E0100, so this is really version 1.0 of the POW=
ER9.
> >>
> >> Perhaps we can define POWER9_v1.0 as CPU_POWERPC_POWER9_DD1, and
> >> introduce a POWER9_v0.0 set to CPU_POWERPC_POWER9_BASE and define it as
> >> the default one?
> >=20
> > I like the suggestion to set a v0.0 to CPU_POWERPC_POWER9_BASE. But, I
> > think we could have only that option, removing the
> > CPU_POWERPC_POWER9_DD1 entry.
> I really dislike the idea of having a CPU called "v0.0" ... we do not
> have this for any other CPU generation, and it sounds like it could be
> very confusing for the users (you'd need to document somewhere what the
> v0.0 exactly means). If we really want to go this way, I think we should
> name it "POWER9-generic" or "PowerISA-3.0" or something similar instead.
>=20
> Or does somebody already know the exact PVR for DD2? If so, we could
> simply add a POWER9_v2.0 CPU already and let the POWER9 alias point to
> that version instead.

Yes, I think that's a better idea.  I don't know the DD2 PVR, but I'm
pretty sure we should be able to find out from someone at IBM.

I've CCed Sam & Suraj - can you ask Mikey or someone what the PVR
value for DD2.0 will be?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fU0UwhtRbpo05rnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZU2ZqAAoJEGw4ysog2bOS7HUQAJTtxooK7HS7xE3TkhB4G1Ip
tO57KM9DtuR/3uCcuVGhFjcL/iwzokU8/XkaJlN/XnrtBzgmRyuFrjPvvk3LF9r0
t/8CCcsSSH8vUM8He2kEqRJX41Pwb7+ALUWHvC1xaAInDZNlKx+k68n2fMh0E/HN
aqTV4PEa5HTiGXAwAw7FrCyJfzs0NDk5QBSW0yfsGfQaN2BrJmurqYhwMDHNXvE6
cUNXnVM8IGhBDMdG9cKE/u/ihfosT3J+NDspGEcrqPfVlvyviXhFyRgC0W+81Q/1
zFOn8rvClurpwBHbgOjCpJZAlNYzIg5oUFBC443gz9z0eUFGlI0Rhvcp5byw/3xZ
LMJtcRE1A3CobKNxQV/Oo6MB4m+GXuKK60OMUrqXZ+XqqDHzfdvzbv4aYplyyUiV
GWOBblAMeCMHNPu6hGuOlo1YOGnweg6VsKdP5qP2Jg7SQZCIdkRTpRTZ2aGvF+np
PpwMLPQO+9uy43toMHLRl7+FFgRJzZnTSJ7O0NlXU6WmCRdUL+IAyyhVXmeXv3ST
gvnKCmiY0jmC2+B96LNefayh5e1NTbdinrpU2OZ7/i36IdsdfLKkkL5TFW+qJl7a
sCc8pLdyQV4qHpQ326YD9SWNVVjZMDgxhitROy8Q6lF2IaJxM4CFzLssdQQwlf61
CKgwKXnCbQCCb269U1yS
=YNkH
-----END PGP SIGNATURE-----

--fU0UwhtRbpo05rnG--
