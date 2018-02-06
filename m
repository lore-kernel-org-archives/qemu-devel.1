Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej8lq-0000XH-Na
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej8lp-0002bq-NV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:19:10 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej8lp-0002b4-IG
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:19:09 -0500
Received: by mail-oi0-x22c.google.com with SMTP id m83so2172906oik.8
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 11:19:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 19:18:48 +0000
Message-ID: <CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] Misc patches for 2018-02-05
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

On 5 February 2018 at 19:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8=
fe:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-requ=
est' into staging (2018-02-02 18:54:11 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d2eac10f23a071ddbd2970ed139c6ca077ff2e48:
>
>   Add the WHPX acceleration enlightenments (2018-02-05 18:30:55 +0100)
>
> ----------------------------------------------------------------
> * socket option parsing fix (Daniel)
> * SCSI fixes (Fam)
> * Readline double-free fix (Greg)
> * More HVF attribution fixes (Izik)
> * WHPX (Windows Hypervisor Platform Extensions) support (Justin)
> * POLLHUP handler (Klim)
> * ivshmem fixes (Ladi)
> * memfd memory backend (Marc-Andr=C3=A9)
> * improved error message (Marcelo)
> * Memory fixes (Peter Xu, Zhecheng)
> * Remove obsolete code and comments (Peter M.)
> * qdev API improvements (Philippe)
> * Add CONFIG_I2C switch (Thomas)
>
> ----------------------------------------------------------------

Hi. I'm afraid this fails to build the all-linux-static config:

  LINK    ivshmem-client
[usual linker gripes about getpwuid &c in static binaries deleted]
/usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
In function `__sanitizer::SetEnv(cha
r const*, char const*)':
(.text+0x41b): undefined reference to `dlsym'
/usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
In function `__sanitizer::InitTlsSiz
e()':
(.text+0x553): undefined reference to `dlsym'
collect2: error: ld returned 1 exit status

thanks
-- PMM
