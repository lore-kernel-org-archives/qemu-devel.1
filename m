Received: from eggs.gnu.org ([2001:4830:134:3::10]:41220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL0Jd-0001bo-Um
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL0JZ-00068f-QR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:54:01 -0400
Date: Wed, 14 Jun 2017 12:53:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614045349.GA25748@lemon>
References: <1497383329-10393-1-git-send-email-thuth@redhat.com>
	<149738389265.243.11409224507286961666@4a9a010726c0>
	<20170614051851-mutt-send-email-mst@kernel.org>
	<20170614023017.GG13420@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614023017.GG13420@umbus>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-bridge/dec: Classify the DEC PCI
 bridge as bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org, marcel@redhat.com

On Wed, 06/14 10:30, David Gibson wrote:
> On Wed, Jun 14, 2017 at 05:19:18AM +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 13, 2017 at 12:58:13PM -0700, no-reply@patchew.org wrote:
> > > In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> > > /tmp/qemu-test/src/include/migration/register.h:18: error: redefini=
tion of typedef =E2=80=98LoadStateHandler=E2=80=99
> > > /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous d=
eclaration of =E2=80=98LoadStateHandler=E2=80=99 was here
> > > make: *** [hw/net/vmxnet3.o] Error 1
> > > make: *** Waiting for unfinished jobs....
> > > tests/docker/Makefile.include:118: recipe for target 'docker-run' f=
ailed
> > > make[1]: *** [docker-run] Error 2
> > > make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-dv2lv743/sr=
c'
> > > tests/docker/Makefile.include:149: recipe for target 'docker-run-te=
st-quick@centos6' failed
> > > make: *** [docker-run-test-quick@centos6] Error 2
> > > =3D=3D=3D OUTPUT END =3D=3D=3D
> > >=20
> > > Test command exited with code: 2
> >=20
> > Any idea what's going on here?

Unrelated to this patch. Every patch from today has it.

>=20
> I _think_ that's unrelated to the patch here.  Looks like the
> autobuilder is using a compiler version that doesn't like typedef
> redefinitions, even if they're identical.

RHEL 6 build was broken by commit f2a8f0a6314 (migration: Split registrat=
ion
functions from vmstate.h). The fix is

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03173.html

Fam
