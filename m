Received: from eggs.gnu.org ([2001:4830:134:3::10]:53792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLus5-0000Sa-Tr
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLus4-0006Gn-Vy
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:45:05 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:32894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLus4-0006Em-S7
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 11:45:04 -0500
Received: by mail-ua0-x233.google.com with SMTP id i68so83088643uad.0
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 08:45:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 16:44:43 +0000
Message-ID: <CAFEAcA_ZQT4bh=OJxskhcXJ6DcDQg1dhJjPmZJ83TnUOgRF+-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/12] M68k for 2.9 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 December 2016 at 11:40, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request
>
> for you to fetch changes up to ed3c95af3dd314a58a83b83126633e4efbad817b:
>
>   target-m68k: free TCG variables that are not (2016-12-24 12:31:21 +0100)
>
> ----------------------------------------------------------------
> A series of patches queued since the beginning of the freeze period.
> Compared to the m68k-for-2.9 branch, 3 patches implementing bitfield
> ops are missing as they need new TCG functions. They will be pushed
> later.
> ----------------------------------------------------------------

clang complains about unused variables:

/Users/pm215/src/qemu-for-merges/target/m68k/op_helper.c:413:14: error: unused
      variable 'c' [-Werror,-Wunused-variable]
    uint64_t c, u, l;
             ^
/Users/pm215/src/qemu-for-merges/target/m68k/op_helper.c:413:20: error: unused
      variable 'l' [-Werror,-Wunused-variable]
    uint64_t c, u, l;
                   ^
/Users/pm215/src/qemu-for-merges/target/m68k/op_helper.c:413:17: error: unused
      variable 'u' [-Werror,-Wunused-variable]
    uint64_t c, u, l;
                ^

thanks
-- PMM
