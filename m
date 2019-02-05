Received: from eggs.gnu.org ([209.51.188.92]:55630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqpu6-00028M-8r
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqpu5-0005YB-Ea
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:52:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqpu5-0005Y2-8s
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:52:01 -0500
Date: Mon, 4 Feb 2019 20:51:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204205105-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Feb 04, 2019 at 05:59:16PM +0000, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 14:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc=
7313b4:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into=
 staging (2019-02-01 17:58:27 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstrea=
m
> >
> > for you to fetch changes up to 5feab30ea98e30446361d184331b7b5ff94b41=
16:
> >
> >   contrib/libvhost-user: cleanup casts (2019-02-04 09:23:56 -0500)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, cleanups, features
> >
> > vhost user blk discard/write zeroes features
> > misc cleanups and fixes all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Hi; I'm afraid this failed build/test on various platforms.
>=20
>=20
> Format string issues on ppc64 host:
>=20
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> =E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:636:9: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>          DPRINT("%s: region %d: Registered userfault for %llx + %llx\n"=
,
>          ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:636:9: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long lo=
ng unsigned int=E2=80=99, but
> argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]

So I think I fixed the build errors. And who knows maybe
that will fix the runtime ones somehow ..
Could you try pls? Re-pushed to same tag.

--=20
MST
