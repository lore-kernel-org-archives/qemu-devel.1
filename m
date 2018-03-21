Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyYqB-0005cC-L4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyYq8-0006hj-9i
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:11:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyYq8-0006gt-1r
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 04:11:20 -0400
Date: Wed, 21 Mar 2018 16:11:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180321081112.GE26017@lemon.usersys.redhat.com>
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
	<e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
	<128f62e5-9184-57e5-88c1-d5cc4bf27d4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <128f62e5-9184-57e5-88c1-d5cc4bf27d4f@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] make vm-test [was: [PATCH] maintainers: Add myself
 as a OpenBSD maintainer]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org

On Mon, 03/19 17:06, Eric Blake wrote:
> On 02/16/2018 11:44 AM, Philippe Mathieu-Daud=E9 wrote:
> > On 02/16/2018 02:41 PM, Kamil Rytarowski wrote:
> > > On 16.02.2018 18:30, Philippe Mathieu-Daud=E9 wrote:
> > > > But before announcing the host OS being supported again, I'd rath=
er see
> > > > reproducible build/tests logs, in a (public - if possible) contin=
uous
> > > > integration system. Else it is hard to notice when it get broken.
> > > >=20
> > >=20
> > > This is already done for FreeBSD, NetBSD and OpenBSD.
> >=20
> > We have the ability to run those, but afaik no CI are using them.
> >=20
> > $ make vm-test
> > vm-test: Test QEMU in preconfigured virtual machines
> >=20
> >    vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM
> >    vm-build-freebsd                - Build QEMU in FreeBSD VM
> >    vm-build-netbsd                 - Build QEMU in NetBSD VM
> >    vm-build-openbsd                - Build QEMU in OpenBSD VM
> >=20
> > >=20
> > > CC: Fam who can confirm this.
>=20
> Thanks for this; today was my first day trying the various vm-build-
> targets.
>=20
> Question: is this expected behavior?
>=20
> $ make vm-build-ubuntu.i386
>     VM-IMAGE ubuntu.i386
> ...
> Image resized.
> debconf: unable to initialize frontend: Dialog
> debconf: (TERM is not set, so the dialog frontend is not usable.)
> debconf: falling back to frontend: Readline
> debconf: unable to initialize frontend: Readline
> debconf: (This frontend requires a controlling tty.)
> debconf: falling back to frontend: Teletype
> dpkg-preconfigure: unable to re-open stdin:
> Connection to 127.0.0.1 closed by remote host.
> ...
> Cloning into '/home/eblake/qemu/vm-test-VoVkBv.tmp/data-5ba3c.tar.vroot=
/ui/keycodemapdb'...
> sudo: unable to resolve host ubuntu-guest
> make[1]: flex: Command not found
> ...
> make[1]: flex: Command not found
> Could not access KVM kernel module: No such file or directory
> qemu-system-i386: failed to initialize KVM: No such file or directory
> qemu-system-i386: Back to tcg accelerator
>=20
> I'm wondering if the image initialized incorrectly, and as a result can=
't do
> as much as it's supposed to do, or runs way slower than it needs to?  T=
he
> command eventually completed with status 0, but failed to find a 32-bit
> compile error in the rdma code, and the output log does not look like i=
t
> actually attempted to compile anything in qemu (unless it did compile i=
t,
> but the logs were not output to stdout/stderr).
>=20
> make vm-build-freebsd was a lot faster at completing for me (but shows =
that
> we still have a lot of clang warnings about address of a packed struct
> member).
>=20

Was it a clean repo? Did you try "rm -rf ~/.cache/qemu-vm"? This morning =
the
command worked for me from a clean env (on RHEL 7, using a QEMU built fro=
m
qemu.git), and I didn't see the errors/warnings you pasted. (BTW I don't
understand how sudo has anything to do with the dummy host name.)

Fam
