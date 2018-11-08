Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKiZ2-00068O-3R
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKiYx-00028L-En
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:33:30 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKiYv-00026z-MK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:33:27 -0500
Received: by mail-ot1-x341.google.com with SMTP id q5so17757516otl.13
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 03:33:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 11:33:03 +0000
Message-ID: <CAFEAcA--8+1HgjSNbiPDQxm9XxhCcGmqAb0FeJh56AN_oZBVXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/17] Misc patches for QEMU 3.1 hard freeze
 (?)
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

On 6 November 2018 at 21:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit fc3d1bad1edf08871275cf469a64e12dae4eba=
96:
>
>   oslib-posix: Use MAP_STACK in qemu_alloc_stack() on OpenBSD (2018-11-06=
 10:52:23 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a458774ad711bceabefbf01e8f0b91d86ec72e0c:
>
>   util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX (2018-11-06 21:=
35:06 +0100)
>
> Vitaly's patch is a bit late; unfortunately I couldn't resend the pull
> request yesterday because of a long weekend.  On the other hand this
> meant I could include three more bugfix series, and also fix some nits
> pointed out by Laszlo who just came back from his own vacation.
>
> ----------------------------------------------------------------
> * icount fix (Clement)
> * dumping fixes for non-volatile memory (Marc-Andr=C3=A9, myself)
> * x86 emulation fix (Rudolf)
> * recent Hyper-V CPUID flag (Vitaly)
> * Q35 doc fix (Daniel)
> * lsi fix (Prasad)
> * SCSI block limits emulation fixes (myself)
> * qemu_thread_atexit rework (Peter)
> * ivshmem memory leak fix (Igor)
>

Applied, thanks.

-- PMM
