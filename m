Received: from eggs.gnu.org ([2001:4830:134:3::10]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYqfz-0000Tj-NX
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYqfy-0006C8-PG
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:51 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYqfy-0006BK-IZ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:30:50 -0400
Received: by mail-oi0-x241.google.com with SMTP id 8-v6so3389425oin.10
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 03:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530265890-17213-1-git-send-email-pbonzini@redhat.com>
References: <1530265890-17213-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 11:30:29 +0100
Message-ID: <CAFEAcA-779p+=wkKaPa2LL4k6jAHx-K5fmXxwBhrjED5PjDnaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/60] Misc patches for soft freeze
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

On 29 June 2018 at 10:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 4a83bf2f339d4b63ecd5ef48b9816c3b7ee245=
53:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180=
627' into staging (2018-06-28 15:31:42 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f5a4d8d963a7f87c474a8b16d508321d4e75833c:
>
>   tests/boot-serial: Do not delete the output file in case of errors (201=
8-06-29 11:47:57 +0200)
>
> ----------------------------------------------------------------
> * "info mtree" improvements (Alexey)
> * fake VPD block limits for SCSI passthrough (Daniel Barboza)
> * chardev and main loop fixes (Daniel Berrang=C3=A9, Sergio, Stefan)
> * help fixes (Eduardo)
> * pc-dimm refactoring (David)
> * tests improvements and fixes (Emilio, Thomas)
> * SVM emulation fixes (Jan)
> * MemoryRegionCache fix (Eric)
> * WHPX improvements (Justin)
> * ESP cleanup (Mark)
> * -overcommit option (Michael)
> * qemu-pr-helper fixes (me)
> * "info pic" improvements for x86 (Peter)
> * x86 TCG emulation fixes (Richard)
> * KVM slot handling fix (Shannon)
> * Next round of deprecation (Thomas)
> * Windows dump format support (Viktor)


This still fails in the same way:
  LINK    i386-linux-user/qemu-i386
target/i386/cpu.o: In function `x86_cpu_realizefn':
/home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4815:
undefined reference to `enable_cpu_pm
'
collect2: error: ld returned 1 exit status

thanks
-- PMM
