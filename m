Received: from eggs.gnu.org ([2001:4830:134:3::10]:40244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fORkn-00019f-3i
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fORkm-0007AR-6j
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:52:49 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:40445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fORkl-00079k-Kv
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:52:48 -0400
Received: by mail-ot0-x22f.google.com with SMTP id n1-v6so26255694otf.7
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 10:52:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 18:52:26 +0100
Message-ID: <CAFEAcA-aYCbBhDpW+duLeYDbUDJE-piGd19wW8FgOMU8kQTFYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/53] Misc patches for 2018-05-31
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

On 31 May 2018 at 18:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c5308=
2b:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-=
pull-request' into staging (2018-05-25 10:04:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2904754bc2ed976acba66a10cb241d23c24b9bcb:
>
>   memory: Make operations using MemoryRegionIoeventfd struct pass by poin=
ter. (2018-05-31 19:12:13 +0200)
>
> ----------------------------------------------------------------
> * Linux header upgrade (Peter)
> * firmware.json definition (Laszlo)
> * IPMI migration fix (Corey)
> * QOM improvements (Alexey, Philippe, me)
> * Memory API cleanups (Jay, me, Tristan, Peter)
> * WHPX fixes and improvements (Lucian)
> * Chardev fixes (Marc-Andr=C3=A9)
> * IOMMU documentation improvements (Peter)
> * Coverity fixes (Peter, Philippe)
> * Include cleanup (Philippe)
> * -clock deprecation (Thomas)
> * Disable -sandbox unless CONFIG_SECCOMP (Yi Min Zhao)
>
> ----------------------------------------------------------------

Hi. This produces new warnings building on netbsd:

  CC      x86_64-bsd-user/bsd-user/mmap.o
/root/qemu/bsd-user/mmap.c:30:6: warning: no previous prototype for
'mmap_lock' [-Wmissing-prototypes]
 void mmap_lock(void)
      ^
/root/qemu/bsd-user/mmap.c:37:6: warning: no previous prototype for
'mmap_unlock' [-Wmissing-prototypes]
 void mmap_unlock(void)
      ^
/root/qemu/bsd-user/mmap.c:44:6: warning: no previous prototype for
'have_mmap_lock' [-Wmissing-prototypes]
 bool have_mmap_lock(void)
      ^

(ditto for the other *-bsd-user targets)

I assume that bsd-user/mmap.c was previously relying on some
header file dragging in exec-all.h for it, and that is no
longer happening.

thanks
-- PMM
