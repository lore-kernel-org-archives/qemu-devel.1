Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6FjK-0002uu-QW
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6FjJ-0003qg-Tk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:24:06 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6FjJ-0003qW-O9
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:24:05 -0400
Received: by mail-ot0-x242.google.com with SMTP id f47-v6so1947759oth.2
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 06:24:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410160142.21096-1-laurent@vivier.eu>
References: <20180410160142.21096-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Apr 2018 14:23:44 +0100
Message-ID: <CAFEAcA-xND9NUBMpz18D-aZ9LE+opvM27zpyrEk8xM5H_d9d5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] linux-user fixes for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 10 April 2018 at 17:01, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit df6378eb0e6cfd58a22a1c3ff8fa4a9039f1eaa8:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180410-pull-request' into staging (2018-04-10 14:04:27 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to 46a1ee4f397ffd305da95fb65dc73be49667ff6d:
>
>   linux-user: implement HWCAP bits on MIPS (2018-04-10 18:00:14 +0200)
>
> ----------------------------------------------------------------
> Trivial fixes for microblaze
> v2: add HWCAP bits on MIPS
> ----------------------------------------------------------------
>
> James Cowgill (1):
>   linux-user: implement HWCAP bits on MIPS
>
> Laurent Vivier (2):
>   linux-user: fix microblaze get_sp_from_cpustate()
>   linux-user: add microblaze/microblazeel magic numbers in
>     qemu-binfmt-conf.sh
>
>  linux-user/elfload.c                  | 24 ++++++++++++++++++++++++
>  linux-user/microblaze/target_signal.h |  2 +-
>  scripts/qemu-binfmt-conf.sh           | 12 ++++++++++--
>  3 files changed, 35 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
