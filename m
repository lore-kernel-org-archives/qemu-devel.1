Received: from eggs.gnu.org ([2001:4830:134:3::10]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0RBG-0006t1-Gu
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0RBC-000775-L0
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 07:52:38 -0400
Date: Fri, 6 Oct 2017 08:52:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171006115230.GO4015@localhost.localdomain>
References: <1504511031-26834-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<5577a43c-0c60-a1c7-e5ab-7b940225ea85@amsat.org>
	<0476b7f3-e760-273a-7edf-07ff90157dc4@linux.vnet.ibm.com>
	<a2b139bd-f389-be61-b38f-51fa4fe64523@redhat.com>
	<1cc1c650-9b82-0332-6d63-fce3334745da@linux.vnet.ibm.com>
	<20171006041544.GS3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171006041544.GS3260@umbus.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5] vl: exit if maxcpus is
 negative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: seeteena <s1seetee@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Fri, Oct 06, 2017 at 03:15:44PM +1100, David Gibson wrote:
> On Thu, Sep 28, 2017 at 06:38:55PM +0530, seeteena wrote:
> >=20
> > Thanks Thomas. Since you already put them on cc. I will wait for the
> > response.
>=20
> At this point, I think your patch has been lost in the noise, I'm
> afraid.  I suggest reposting, CCing those suggested people from the
> start.  I'd also suggest CCing qemu-trivial@nongnu.org, I think this
> patch meets the guidelines for a trivial patch.

I'm queueing on machine-next, sorry for letting it fall through.

>=20
> >=20
> >=20
> > On 09/25/2017 02:21 PM, Thomas Huth wrote:
> > > On 25.09.2017 10:43, seeteena wrote:
> > > > Hi Philippe,
> > > >=20
> > > > I have not seen patch went upstream..
> > > You need to get the attention of a maintainer who could pick up the
> > > patch, e.g. by putting them on CC:. See the MAINTAINERS file for wh=
o is
> > > responsible for the various parts of QEMU. I've put Eduardo (Numa) =
and
> > > Paolo (vl.c) on CC: now, I hope one of them can pick up the patch.
> > >=20
> > >   Thomas
> > >=20
> > >=20
> > > > On 09/04/2017 09:12 PM, Philippe Mathieu-Daud=E9 wrote:
> > > > > On 09/04/2017 04:43 AM, Seeteena Thoufeek wrote:
> > > > > > ---Steps to Reproduce---
> > > > > >=20
> > > > > > When passed a negative number to 'maxcpus' parameter, Qemu ab=
orts
> > > > > > with a core dump.
> > > > > >=20
> > > > > > Run the following command with maxcpus argument as negative n=
umber
> > > > > >=20
> > > > > > ppc64-softmmu/qemu-system-ppc64 --nographic -vga none -machin=
e
> > > > > > pseries,accel=3Dkvm,kvm-type=3DHV -m size=3D200g -device virt=
io-blk-pci,
> > > > > > drive=3Drootdisk -drive file=3D/home/images/pegas-1.0-ppc64le=
.qcow2,
> > > > > > if=3Dnone,cache=3Dnone,id=3Drootdisk,format=3Dqcow2 -monitor =
telnet
> > > > > > :127.0.0.1:1234,server,nowait -net nic,model=3Dvirtio -net
> > > > > > user -redir tcp:2000::22 -device nec-usb-xhci -smp 8,cores=3D=
1,
> > > > > > threads=3D1,maxcpus=3D-12
> > > > > >=20
> > > > > > (process:12149): GLib-ERROR **: gmem.c:130: failed to allocat=
e
> > > > > >  =A0 18446744073709550568 bytes
> > > > > >=20
> > > > > > Trace/breakpoint trap
> > > > > >=20
> > > > > > Reported-by: R.Nageswara Sastry <rnsastry@linux.vnet.ibm.com>
> > > > > > Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com=
>
> > > > > Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > > >=20
> > > > > > ---
> > > > > > v1 -> v2:
> > > > > >  =A0=A0 - Fix the error check in vl.c to make it generic.
> > > > > > v2 -> v3:
> > > > > >  =A0=A0 - Fix coding style pointed out by patchew.
> > > > > >  =A0=A0 - Fix check for "<=3D 0" instead of just "< 0".
> > > > > > v3 -> v4:
> > > > > >  =A0=A0 - Fix subject line.
> > > > > >  =A0=A0 - Removed space before ":" from vl.c:1248
> > > > > >  =A0=A0 - Removed Reviewed-by: flag
> > > > > > v4-> v5:
> > > > > >  =A0=A0 - Code rework to declare max_cpus as unsigned int in =
sysemu.h
> > > > > >  =A0=A0 - Remove the error check in vl.c referred in v2.
> > > > > >  =A0=A0 - declare max_cpus as unsigned int in vl.c
> > > > > > ---
> > > > > >  =A0 include/sysemu/sysemu.h | 2 +-
> > > > > >  =A0 vl.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 | 6 +++---
> > > > > >  =A0 2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.=
h
> > > > > > index b213696..c083869 100644
> > > > > > --- a/include/sysemu/sysemu.h
> > > > > > +++ b/include/sysemu/sysemu.h
> > > > > > @@ -113,7 +113,7 @@ extern int win2k_install_hack;
> > > > > >  =A0 extern int alt_grab;
> > > > > >  =A0 extern int ctrl_grab;
> > > > > >  =A0 extern int smp_cpus;
> > > > > > -extern int max_cpus;
> > > > > > +extern unsigned int max_cpus;
> > > > > >  =A0 extern int cursor_hide;
> > > > > >  =A0 extern int graphic_rotate;
> > > > > >  =A0 extern int no_quit;
> > > > > > diff --git a/vl.c b/vl.c
> > > > > > index 8e247cc..1470c21 100644
> > > > > > --- a/vl.c
> > > > > > +++ b/vl.c
> > > > > > @@ -164,7 +164,7 @@ Chardev *sclp_hds[MAX_SCLP_CONSOLES];
> > > > > >  =A0 int win2k_install_hack =3D 0;
> > > > > >  =A0 int singlestep =3D 0;
> > > > > >  =A0 int smp_cpus =3D 1;
> > > > > > -int max_cpus =3D 1;
> > > > > > +unsigned int max_cpus =3D 1;
> > > > > >  =A0 int smp_cores =3D 1;
> > > > > >  =A0 int smp_threads =3D 1;
> > > > > >  =A0 int acpi_enabled =3D 1;
> > > > > > @@ -4233,8 +4233,8 @@ int main(int argc, char **argv, char **=
envp)
> > > > > >  =A0 =A0=A0=A0=A0=A0 machine_class->max_cpus =3D machine_clas=
s->max_cpus ?: 1; /*
> > > > > > Default to UP */
> > > > > >  =A0=A0=A0=A0=A0 if (max_cpus > machine_class->max_cpus) {
> > > > > > -=A0=A0=A0=A0=A0=A0=A0 error_report("Number of SMP CPUs reque=
sted (%d) exceeds max
> > > > > > CPUs "
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 "supported by machine '%s' (%d)", max_cpus,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 error_report("Invalid SMP CPUs %d. The=
 max CPUs "
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 "supported by machine '%s' is %d", max_cpus,
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 machine_class->name, machine_class->max_cpus);
> > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(1);
> > > > > >  =A0=A0=A0=A0=A0 }
> > > > > >=20
> > > >=20
> >=20
> >=20
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _oth=
er_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



--=20
Eduardo
