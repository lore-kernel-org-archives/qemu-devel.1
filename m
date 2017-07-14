Received: from eggs.gnu.org ([2001:4830:134:3::10]:41263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxUH-0003oc-5b
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxUG-0003f1-5Q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:06:17 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVxUF-0003ef-Ut
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:06:16 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u110so594142wrb.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:06:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:05:54 +0100
Message-ID: <CAFEAcA9-vGu17ajxP2ZdTNie=NU9GCfG2_c+-kb4zjHxmmoa3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Error reporting patches for 2017-07-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 July 2017 at 14:27, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 31fe1c414501047cbb91b695bdccc0068496dcf6:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-07-11 17:13:49 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-07-13
>
> for you to fetch changes up to 88f83f3539fdedd5f315c5fe434ffcb7a010cc73:
>
>   Convert error_report*_err() to warn_report*_err() (2017-07-13 13:50:24 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2017-07-13
>
> ----------------------------------------------------------------
> Alistair Francis (6):
>       util/qemu-error: Rename error_print_loc() to be more generic
>       error: Functions to report warnings and informational messages
>       Convert error_report() to warn_report()
>       char-socket: Report TCP socket waiting as information
>       error: Implement the warn and free Error functions
>       Convert error_report*_err() to warn_report*_err()
>
> Eduardo Habkost (3):
>       xilinx: Fix latent error handling bug
>       block: Don't try to set *errp directly
>       websock: Don't try to set *errp directly

On my FreeBSD test setup test-char resulted in a warning:


TEST: tests/test-char... (pid=68152)
  /char/null:                                                          OK
  /char/invalid:                                                       OK
  /char/ringbuf:                                                       OK
  /char/mux:                                                           OK
  /char/stdio:                                                         OK
  /char/pipe:                                                          OK
  /char/file:                                                          OK
  /char/socket:                                                        main-loop
: WARNING: I/O thread spun for 1000 iterations
OK
  /char/udp:                                                           OK
  /char/serial:                                                        OK
PASS: tests/test-char

but I can't repro that and it doesn't look like it ought to be
related to the patches in this series, so I'm going to assume it
was just that the box got heavily loaded briefly or something.

Applied to master, thanks.

-- PMM
