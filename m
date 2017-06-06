Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7EZ-0004Pu-A1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dI7EY-0001ST-Ht
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:51 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:35424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dI7EY-0001SJ-9N
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 01:40:50 -0400
Received: by mail-it0-x242.google.com with SMTP id 67so25803680itx.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 22:40:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496702979-26132-3-git-send-email-cota@braap.org>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
	<1496702979-26132-3-git-send-email-cota@braap.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 6 Jun 2017 01:40:19 -0400
Message-ID: <CAJhHMCCAsY356j=1fA8gd7d=MH+-sSC1TbVYZpGsd26oMDP8mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] tests: use QEMU_CACHELINE_SIZE
 instead of hard-coding it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 5, 2017 at 6:49 PM, Emilio G. Cota <cota@braap.org> wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Pranith Kumar <bobby.prani@gmail.com>

> ---
>  tests/atomic_add-bench.c | 4 ++--
>  tests/qht-bench.c        | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
> index caa1e8e..c219109 100644
> --- a/tests/atomic_add-bench.c
> +++ b/tests/atomic_add-bench.c
> @@ -5,11 +5,11 @@
>
>  struct thread_info {
>      uint64_t r;
> -} QEMU_ALIGNED(64);
> +} QEMU_ALIGNED(QEMU_CACHELINE_SIZE);
>
>  struct count {
>      unsigned long val;
> -} QEMU_ALIGNED(64);
> +} QEMU_ALIGNED(QEMU_CACHELINE_SIZE);
>
>  static QemuThread *threads;
>  static struct thread_info *th_info;
> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
> index 2afa09d..3f4b5eb 100644
> --- a/tests/qht-bench.c
> +++ b/tests/qht-bench.c
> @@ -28,7 +28,7 @@ struct thread_info {
>      uint64_t r;
>      bool write_op; /* writes alternate between insertions and removals */
>      bool resize_down;
> -} QEMU_ALIGNED(64); /* avoid false sharing among threads */
> +} QEMU_ALIGNED(QEMU_CACHELINE_SIZE); /* avoid false sharing among threads */
>
>  static struct qht ht;
>  static QemuThread *rw_threads;
> --
> 2.7.4
>



-- 
Pranith
