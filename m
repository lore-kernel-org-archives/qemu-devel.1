Received: from eggs.gnu.org ([209.51.188.92]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh1AH-00010Q-DH
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gh1AG-0002jN-H4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:52:09 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gh1AG-0002jC-BO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 18:52:08 -0500
Received: by mail-ot1-x336.google.com with SMTP id 40so5156676oth.4
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 15:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20190108182226.28873-1-pbonzini@redhat.com>
In-Reply-To: <20190108182226.28873-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 23:51:56 +0000
Message-ID: <CAFEAcA-HpZxMH5LoK2waHQ0VGSR2tu_F2J7AFSBm4gRvZTdM3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/35] Misc patches for 2018-12-18
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

On Tue, 8 Jan 2019 at 18:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22=
f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-req=
uest' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to aac9150d775a51cd6c49c466114006ac9f8a3baa:
>
>   avoid TABs in files that only contain a few (2019-01-08 19:20:41 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo, with Peter's fix to hexloader-test)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------
> v4->v5: fix conflicts

unexpected write errors still here :-(

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



I'll try to prod this a bit more on Thursday (and
find out if it's intermittent or consistent).

thanks
-- PMM
