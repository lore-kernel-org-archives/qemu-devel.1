Received: from eggs.gnu.org ([2001:4830:134:3::10]:56016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1yXq-00071v-WD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e1yXn-00054A-24
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e1yXm-00053r-PT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:42:14 -0400
Date: Tue, 10 Oct 2017 13:42:13 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
	<CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, changpeng liu <changpeng.liu@intel.com>

Hi

----- Original Message -----
> On 10 October 2017 at 18:10, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > The following changes since commit
> > 567d0a19c7998fa366598b83d5a6e5f0759d3ea9:
> >
> >   Merge remote-tracking branch
> >   'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging
> >   (2017-10-10 13:25:46 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/elmarco/qemu.git tags/vus-pull-request
> >
> > for you to fetch changes up to 25f1fe82c64c8c4922254d63195e1d9cffbb0507=
:
> >
> >   vhost-user-scsi: remove server_sock from VusDev (2017-10-10 19:06:06
> >   +0200)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
>=20
> Hi. I'm afraid this fails to build:
>=20
> On ppc host:
>   CC      contrib/libvhost-user/libvhost-user.o
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
> =E2=80=98vu_set_vring_addr_exec=E2=80=99:
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:524:5: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>      DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
>      ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:525:5: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>      DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
>      ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:526:5: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>      DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
>      ^
> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:527:5: error:
> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>      DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
>      ^
>=20
>=20
> On NetBSD, OpenBSD, FreeBSD, OSX:
>=20
>   CC      contrib/libvhost-user/libvhost-user.o
> /root/qemu/contrib/libvhost-user/libvhost-user.c:27:25: fatal error:
> sys/eventfd.h: No such file or directory
>  #include <sys/eventfd.h>
>                          ^
> compilation terminated.
>=20

That was quick!

It looks like the solution is to remove libvhost-user.a from $(SUBDIR_RULES=
) target. I have checked with 'make vm-build-freebsd'.

(the printf format errors are pre-existing - I think should be addressed in=
 a different series)=20
