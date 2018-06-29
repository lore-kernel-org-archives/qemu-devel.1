Received: from eggs.gnu.org ([2001:4830:134:3::10]:42737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpfO-0002R5-TL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYpfO-00077a-1G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:26:10 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:36846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYpfN-00075g-Px
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:26:09 -0400
Received: by mail-oi0-x22a.google.com with SMTP id r16-v6so7348861oie.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 02:26:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 10:25:48 +0100
Message-ID: <CAFEAcA9i=tEQuOpuUksRDapLAuONJ6sSDiJY20pujOYo7GPeJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/60] Misc patches for soft freeze
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

On 28 June 2018 at 21:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 4a83bf2f339d4b63ecd5ef48b9816c3b7ee24553:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180627' into staging (2018-06-28 15:31:42 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4cd00cd65e8f3d6301426c1f223f676935b3e9b8:
>
>   tests/boot-serial: Do not delete the output file in case of errors (2018-06-28 19:05:39 +0200)
>
> A separate pull request will come with Philippe's IEC unit series.
> This one is already big enough!
>
> ----------------------------------------------------------------

Hi; this fails to link the i386 linux-user binaries
(x86-64 Linux host, debug build):

  LINK    i386-linux-user/qemu-i386
target/i386/cpu.o: In function `x86_cpu_realizefn':
/home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4814:
undefined reference to `enable_cpu_pm'

because enable_cpu_pm is defined in vl.c but used
in code in target/i386 which isn't softmmu-specific.

thanks
-- PMM
