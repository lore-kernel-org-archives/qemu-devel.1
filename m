Received: from eggs.gnu.org ([2001:4830:134:3::10]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yEp-0008La-9D
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yEo-0004EU-5W
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:22:39 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:51483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1yEn-0004EA-UD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:22:38 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f4so7414267wme.0
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:22:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010171122.9756-1-marcandre.lureau@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 18:22:16 +0100
Message-ID: <CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, changpeng.liu@intel.com

On 10 October 2017 at 18:10, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit 567d0a19c7998fa366598b83d5a6e5f0759d3e=
a9:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2017-10-10 13:25:46 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/vus-pull-request
>
> for you to fetch changes up to 25f1fe82c64c8c4922254d63195e1d9cffbb0507:
>
>   vhost-user-scsi: remove server_sock from VusDev (2017-10-10 19:06:06 +0=
200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi. I'm afraid this fails to build:

On ppc host:
  CC      contrib/libvhost-user/libvhost-user.o
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
=E2=80=98vu_set_vring_addr_exec=E2=80=99:
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:524:5: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
     DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
     ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:525:5: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
     DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
     ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:526:5: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
     DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
     ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:527:5: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
     DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
     ^


On NetBSD, OpenBSD, FreeBSD, OSX:

  CC      contrib/libvhost-user/libvhost-user.o
/root/qemu/contrib/libvhost-user/libvhost-user.c:27:25: fatal error:
sys/eventfd.h: No such file or directory
 #include <sys/eventfd.h>
                         ^
compilation terminated.

thanks
-- PMM
