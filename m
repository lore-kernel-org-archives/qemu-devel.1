Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaSAp-0008Cj-A7
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaSAo-0005pa-Ce
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:17:35 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:43630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gaSAk-0005hP-Cf
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:17:32 -0500
Received: by mail-ot1-x333.google.com with SMTP id a11so6333267otr.10
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:17:18 -0800 (PST)
MIME-Version: 1.0
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Dec 2018 21:09:17 +0000
Message-ID: <CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 21 Dec 2018 at 12:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e85c577158a2e8e252414959da9ef15c12eec6=
3d:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
8-12-17' into staging (2018-12-18 14:31:06 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2cbc4ea2a9f9b81d5f4bfee8c412849755b842b0:
>
>   avoid TABs in files that only contain a few (2018-12-21 12:58:28 +0100)
>
> v3->v4: avoid extra long command lines and ease cut-and-paste from make c=
heck logs
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------

Thanks for improving the length of the command lines. Unfortunately
this does not seem to have fixed the 'write error' from make:

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img test
s/boot-order-test -m=3Dquick -k --tap | ./scripts/tap-driver.pl
--test-name=3D"boot-order-test"
PASS 1 boot-order-test /x86_64/boot-order/pc
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img test
s/bios-tables-test -m=3Dquick -k --tap | ./scripts/tap-driver.pl
--test-name=3D"bios-tables-test"

Looking for expected file 'tests/data/acpi/pc/DSDT'
Using expected file 'tests/data/acpi/pc/DSDT'
Looking for expected file 'tests/data/acpi/pc/FACP'
Using expected file 'tests/data/acpi/pc/FACP'
[... omit a bunch of other uninteresting logging from the acpi test]
Looking for expected file 'tests/data/acpi/pc/NFIT.dimmpxm'
Using expected file 'tests/data/acpi/pc/NFIT.dimmpxm'

Looking for expected file 'tests/data/acpi/q35/DSDT.bridge'
Using expected file 'tests/data/acpi/q35/DSDT.bridge'
Looking for expected file 'tests/data/acpi/q35/FACP.bridge'
Looking for expected file 'tests/data/acpi/q35/FACP'
Using expected file 'tests/data/acpi/q35/FACP'
Looking for expected file 'tests/data/acpi/q35/APIC.bridge'
Looking for expected file 'tests/data/acpi/q35/APIC'
Using expected file 'tests/data/acpi/q35/APIC'
Looking for expectfwrite(): Resource temporarily unavailable
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg=
'
make: write error: stdout

I don't really understand what's going on here, or why
it only happens with this one system (my main x86-64
Linux Ubuntu 16.04.5 box) and not the various others I'm
running test builds on. But it does seem to be 100%
reliable with any of these pullreqs with the new test
driver in them :-(

thanks
-- PMM
