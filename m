Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVzAP-0003Lv-7U
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVzAO-0006aI-EW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:21:37 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVzAO-0006Zw-A7
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:21:36 -0500
Received: by mail-ua0-x236.google.com with SMTP id y9so131950422uae.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 03:21:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123221650.9267-1-rth@twiddle.net>
References: <20170123221650.9267-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 11:21:15 +0000
Message-ID: <CAFEAcA8fqZJQqhN1DeQ-oP0i5T6Z-ZrM4G1qLrtWYDvxK_riTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/7] Nios2 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 22:16, Richard Henderson <rth@twiddle.net> wrote:
> This is me acking this new target.  Hopefully Chris and/or Marek
> will be able to get some gpg keys signed relatively soon.
>
> I had to make one change for the target, updating to rely on the
> common tlb_flush during reset.
>
>
> r~
>
>
> The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-nios-20170123
>
> for you to fetch changes up to 9a6aa7cc59b7ff0535392241e19c73cde146c506:
>
>   nios2: Add support for Nios-II R1 (2017-01-23 13:54:58 -0800)
>
> ----------------------------------------------------------------
> nios2 target support

Fails to build, OSX:

/Users/pm215/src/qemu-for-merges/target/nios2/helper.c:293:63: error:
format specifies type 'unsigne
d long' but the argument has type 'vaddr' (aka 'unsigned long long')
[-Werror,-Wformat]
            qemu_log("cpu_get_phys_page debug MISS: %08lX\n", addr);
                                                    ~~~~~     ^~~~
                                                    %08llX

thanks
-- PMM
