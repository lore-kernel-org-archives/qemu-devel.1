Received: from eggs.gnu.org ([2001:4830:134:3::10]:49077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gVCxm-0006RA-Ar
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gVCxi-0007HH-KE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gVCxi-0007Fq-BA
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:02:22 -0500
Date: Fri, 7 Dec 2018 10:02:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181207100212.GA18699@stefanha-x1.localdomain>
References: <938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
	<20181205132041.GB24623@stefanha-x1.localdomain>
	<669ef62d-06e2-3e6d-9f27-9ae8934b5330@oracle.com>
	<20181206103803.GA30262@stefanha-x1.localdomain>
	<546d6559-893f-0ccf-55e2-a671597a01ae@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <546d6559-893f-0ccf-55e2-a671597a01ae@oracle.com>
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maran Wilson <maran.wilson@oracle.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:47:54AM -0800, Maran Wilson wrote:
> On 12/6/2018 2:38 AM, Stefan Hajnoczi wrote:
> > On Wed, Dec 05, 2018 at 10:04:36AM -0800, Maran Wilson wrote:
> > > On 12/5/2018 5:20 AM, Stefan Hajnoczi wrote:
> > > > On Tue, Dec 04, 2018 at 02:44:33PM -0800, Maran Wilson wrote:
> > > > > On 12/3/2018 8:35 AM, Stefano Garzarella wrote:
> > > > > > On Mon, Dec 3, 2018 at 4:44 PM Rob Bradford <robert.bradford@in=
tel.com> wrote:
> > > > > > > Hi Stefano, thanks for capturing all these numbers,
> > > > > > >=20
> > > > > > > On Mon, 2018-12-03 at 15:27 +0100, Stefano Garzarella wrote:
> > > > > > > > Hi Rob,
> > > > > > > > I continued to investigate the boot time, and as you sugges=
ted I
> > > > > > > > looked also at qemu-lite 2.11.2
> > > > > > > > (https://github.com/kata-containers/qemu) and NEMU "virt" m=
achine. I
> > > > > > > > did the following tests using the Kata kernel configuration
> > > > > > > > (
> > > > > > > > https://github.com/kata-containers/packaging/blob/master/ke=
rnel/configs/x86_64_kata_kvm_4.14.x
> > > > > > > > )
> > > > > > > >=20
> > > > > > > > To compare the results with qemu-lite direct kernel load, I=
 added
> > > > > > > > another tracepoint:
> > > > > > > > - linux_start_kernel: first entry of the Linux kernel
> > > > > > > > (start_kernel())
> > > > > > > >=20
> > > > > > > Great, do you have a set of patches available that all these =
trace
> > > > > > > points. It would be great for reproduction.
> > > > > > For sure! I'm attaching a set of patches for qboot, seabios, ov=
mf,
> > > > > > nemu/qemu/qemu-lite and linux 4.14 whit the tracepoints.
> > > > > > I'm also sharing a python script that I'm using with perf to ex=
tract
> > > > > > the numbers in this way:
> > > > > >=20
> > > > > > $ perf record -a -e kvm:kvm_entry -e kvm:kvm_pio -e
> > > > > > sched:sched_process_exec -o /tmp/qemu_perf.data &
> > > > > > $ # start qemu/nemu multiple times
> > > > > > $ killall perf
> > > > > > $ perf script -s qemu-perf-script.py -i /tmp/qemu_perf.data
> > > > > >=20
> > > > > > > > As you can see, NEMU is faster to jump to the kernel
> > > > > > > > (linux_start_kernel) than qemu-lite when uses qboot or seab=
ios with
> > > > > > > > virt support, but the time to the user space is strangely h=
igh, maybe
> > > > > > > > the kernel configuration that I used is not the best one.
> > > > > > > > Do you suggest another kernel configuration?
> > > > > > > >=20
> > > > > > > This looks very bad. This isn't the kernel configuration we n=
ormally
> > > > > > > test with in our automated test system but is definitely one =
we support
> > > > > > > as part of our partnernship with the Kata team. It's a high p=
riority
> > > > > > > for me to try and investigate that. Have you saved the kernel=
 messages
> > > > > > > as they might be helpful?
> > > > > > Yes, I'm attaching the dmesg output with nemu and qemu.
> > > > > >=20
> > > > > > > > Anyway, I obtained the best boot time with qemu-lite and di=
rect
> > > > > > > > kernel
> > > > > > > > load (vmlinux ELF image). I think because the kernel was not
> > > > > > > > compressed. Indeed, looking to the others test, the kernel
> > > > > > > > decompression (bzImage) takes about 80 ms (linux_start_kern=
el -
> > > > > > > > linux_start_boot). (I'll investigate better)
> > > > > > > >=20
> > > > > > > Yup being able to load an uncompressed kernel is one of the b=
ig
> > > > > > > advantages of qemu-lite. I wonder if we could bring that feat=
ure into
> > > > > > > qemu itself to supplement the existing firmware based kernel =
loading.
> > > > > > I think so, I'll try to understand if we can merge the qemu-lite
> > > > > > direct kernel loading in qemu.
> > > > > An attempt was made a long time ago to push the qemu-lite stuff (=
=66rom the
> > > > > Intel Clear Containers project) upstream. As I understand it, the=
 main
> > > > > stumbling block that seemed to derail the effort was that it invo=
lved adding
> > > > > Linux OS specific code to Qemu so that Qemu could do things like =
create and
> > > > > populate the zero page that Linux expects when entering startup_6=
4().
> > > > >=20
> > > > > That ends up being a lot of very low-level, operating specific kn=
owledge
> > > > > about Linux that ends up getting baked into Qemu code. And unders=
tandably, a
> > > > > number of folks saw problems with going down a path like that.
> > > > >=20
> > > > > Since then, we have put together an alternative solution that wou=
ld allow
> > > > > Qemu to boot an uncompressed Linux binary via the x86/HVM direct =
boot ABI
> > > > > (https://xenbits.xen.org/docs/unstable/misc/pvh.html). The soluti=
on involves
> > > > > first making changes to both the ABI as well as Linux, and then u=
pdating
> > > > > Qemu to take advantage of the updated ABI which is already suppor=
ted by both
> > > > > Linux and Free BSD for booting VMs. As such, Qemu can remain OS a=
gnostic,
> > > > > and just be programmed to the published ABI.
> > > > >=20
> > > > > The canonical definition for the HVM direct boot ABI is in the Xe=
n tree and
> > > > > we needed to make some minor changes to the ABI definition to all=
ow KVM
> > > > > guests to also use the same structure and entry point. Those chan=
ges were
> > > > > accepted to the Xen tree already:
> > > > > https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg0=
0057.html
> > > > >=20
> > > > > The corresponding Linux changes that would allow KVM guests to be=
 booted via
> > > > > this PVH entry point have already been posted and reviewed:
> > > > > https://lkml.org/lkml/2018/4/16/1002
> > > > >=20
> > > > > The final part is the set of Qemu changes to take advantage of th=
e above and
> > > > > boot a KVM guest via an uncompressed kernel binary using the entr=
y point
> > > > > defined by the ABI. Liam Merwick will be posting some RFC patches=
 very soon
> > > > > to allow this.
> > > > Cool, thanks for doing this work!
> > > >=20
> > > > How do the boot times compare to qemu-lite and Firecracker's
> > > > (https://github.com/firecracker-microvm/firecracker/) direct vmlinu=
x ELF
> > > > boot?
> > > Boot times compare very favorably to qemu-lite, since the end result =
is
> > > basically doing a very similar thing. For now, we are going with a QE=
MU +
> > > qboot solution to introduce the PVH entry support in Qemu (meaning we=
 will
> > > be posting Qemu and qboot patches and you will need both to boot an
> > > uncompressed kernel binary). As such we have numbers that Liam will i=
nclude
> > > in the cover letter showing significant boot time improvement over ex=
isting
> > > QEMU + qboot approaches involving a compressed kernel binary. And as =
we all
> > > know, the existing qboot approach already gets boot times down pretty=
 low.
> > The first email in this thread contains benchmark results showing that
> > optimized SeaBIOS is comparable to qboot, so it does not offer anything
> > unique with respect to boot time.
>=20
> To be fair, what I'm saying is that the qboot + PVH approach saves a
> significant percentage of boot time as compared to qboot only. So it does
> provide an important improvement over both existing qboot as well as
> optimized SeaBIOS from what I can tell. Please see:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00957.html
> and
> http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00953.html
>=20
> > We're trying to focus on SeaBIOS because it's actively maintained and
> > already shipped by distros.  Relying on qboot will make it harder to get
> > PVH into the hands of users because distros have to package and ship
> > qboot first.  This might also require users to change their QEMU
> > command-line syntax to benefit from fast kernel booting.
>=20
> But you do make a good point here about distribution and usability. Using
> qboot is just one way to take advantage of the PVH entry -- and the quick=
est
> way for us to get something usable out there for the community to look at
> and play with.
>=20
> There are other ways to take advantage of the PVH entry for KVM guests, o=
nce
> the Linux changes are in place. So qboot is definitely not a hard
> requirement in the long run.

Great, good to hear!

Stefan

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcCkUkAAoJEJykq7OBq3PIF4YIAK4YLIb5DgtGQkHbQL+Pq3tT
DcXZklwywG9irpUAtT470qgeZt+Bin1eefIWCtk2SelX5fBD3xUpaf3dqMYR+GZk
ukv92pyaZuB/1ozToZxwECAgES7D9Iw7mSntskdqMZxWZg2Im2tIDhlDsf3m3D5+
uy5/krhHy3EKvKpc7U1vzWMOQFAh5py42ztV6bQyoIW0GJYpvJdKFbfSoupXblcb
LWVE4l/x6U+lga6BYshBsImTW6vCRK/eE2erc+FIiF3vV0s/+xBDZLYJfWDNaI8j
OCchULf1zuBVzIG3s186OqRsIigC4YpUfrDbF8KAGeu0IPGnusKCSciHHkvYRlg=
=HDd8
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
