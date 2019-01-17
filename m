Received: from eggs.gnu.org ([209.51.188.92]:45487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk765-0004w6-0g
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk763-0001Un-Hp
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:36 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk763-0001UN-C4
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:48:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id a11so10948258otr.10
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 04:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20190115200252.25911-1-mst@redhat.com>
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 12:48:22 +0000
Message-ID: <CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
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

On Tue, 15 Jan 2019 at 20:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v1:
> - fix an out of tree build by unmangling a patch I mangled when applying
> - fix a gcc 8 build by applying philippe's patches
>
>
> The following changes since commit 89bd861c2b470e3fb45596945509079c72af3ac2:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-01-14 17:35:00 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 64ed76db175f7ccb5f47195a7617d0106bf01245:
>
>   migration: Use strnlen() for fixed-size string (2019-01-15 14:56:57 -0500)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
>
> tpm physical presence interface
> rsc support in virtio net
> ivshmem is removed
> misc cleanups and fixes all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
This fails 'make check' on s390x host:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
QTEST_QEMU_IMG=qemu-img tests/bios-tables-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="bios-tables-test"

Looking for expected file 'tests/data/acpi/pc/FACP'
Using expected file 'tests/data/acpi/pc/FACP'
**
ERROR:/home/linux1/qemu/tests/bios-tables-test.c:314:load_expected_aml:
assertion failed: (exp_sdt.aml_len)
ERROR - too few tests run (expected 15, got 0)
Aborted (core dumped)
/home/linux1/qemu/tests/Makefile.include:856: recipe for target
'check-qtest-i386' failed


(all the other build hosts passed)

thanks
-- PMM
