Received: from eggs.gnu.org ([2001:4830:134:3::10]:56682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX8Jv-0002uZ-T1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX8Ju-0001OV-SL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:20:11 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:36467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX8Ju-0001OD-NQ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:20:10 -0500
Received: by mail-vk0-x22e.google.com with SMTP id t8so177237373vke.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:20:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485447262-27014-1-git-send-email-mst@redhat.com>
References: <1485447262-27014-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:19:49 +0000
Message-ID: <CAFEAcA8avJj04_w_GSriA5MsMKGAwLOar1-e1MgVroe+OyUGqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/18] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2017 at 16:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit ae5045ae5b2bbd8ce1335d1b05f9ecacca83a6=
cf:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-nios-20170124' into=
 staging (2017-01-25 13:30:23 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1954d8b17bbccad723c193edba961d49b7ac4a43:
>
>   hw/pci: disable pci-bridge's shpc by default (2017-01-26 18:13:33 +0200=
)
>
> ----------------------------------------------------------------
> virtio, vhost, pci: fixes, features
>
> generic pci root port support
> disable shpc by default
> safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
> fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Failure to build, x86:

/home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c: In function
=E2=80=98spapr_phb_placement=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2643:20: error:
bit-field =E2=80=98<anonymous>=E2=80=99 width n
ot an integer constant
     QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) >
SPAPR_PCI_MEM32_WIN_SIZE);
                    ^
/home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2644:20: error:
bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer constant
     QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) >
SPAPR_PCI_MEM64_WIN_SIZE);
                    ^

Failure to build, aarch64 and aarch32:

In file included from /home/petmay01/qemu/target/arm/cpu.h:23:0,
                 from /home/petmay01/qemu/trace/control-target.c:11:
/home/petmay01/qemu/target/arm/kvm-consts.h:35:1: error: expected ','
or ';' before 'typedef'
 MISMATCH_CHECK(CP_REG_SIZE_MASK, KVM_REG_SIZE_MASK)
 ^
/home/petmay01/qemu/target/arm/kvm-consts.h:35:83: error: data
definition has no type or storage cla
ss [-Werror]
 MISMATCH_CHECK(CP_REG_SIZE_MASK, KVM_REG_SIZE_MASK)

            ^
/home/petmay01/qemu/target/arm/kvm-consts.h:35:83: error: type
defaults to 'int' in declaration of '
qemu_build_bug_on__35' [-Werror=3Dimplicit-int]

(repeated for all the other uses of MISMATCH_CHECK in that header)

thanks
-- PMM
