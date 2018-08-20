Received: from eggs.gnu.org ([2001:4830:134:3::10]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frlPw-0003bO-La
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frlPw-0007Cp-0q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:44:28 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frlPv-0007CA-Pa
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:44:27 -0400
Received: by mail-oi0-x244.google.com with SMTP id m11-v6so26265991oic.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 07:44:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180819221707.20693-1-laurent@vivier.eu>
References: <20180819221707.20693-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:44:06 +0100
Message-ID: <CAFEAcA8k0Pe0k4rRaMTs39iUenOT5wJNKM-hva6ZnZ2n4fxoPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 19 August 2018 at 23:17, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d194=
28:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2018-08-17 09:46:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to c072a24c11e713f14ab969799433218d8ceebe19:
>
>   linux-user: add QEMU_IFLA_INFO_KIND nested type for tun (2018-08-20 00:=
11:06 +0200)
>
> ----------------------------------------------------------------
> linux-user fixes:
> - netlink fixes (add missing types, fix MSG_TRUNC)
> - sh4 fix (tcg state)
> - sparc32plus fix (truncate address space to 32bit)
> - add x86_64 binfmt data
>
> ----------------------------------------------------------------

Hi -- I'm afraid this doesn't build on my ppc64 test box:

/home/pm215/qemu/linux-user/syscall.c: In function
=E2=80=98host_to_target_data_route_rtattr=E2=80=99:
/home/pm215/qemu/linux-user/syscall.c:2719:10: error: =E2=80=98RTA_PREF=E2=
=80=99
undeclared (first use in this function)
     case RTA_PREF:
          ^

thanks
-- PMM
