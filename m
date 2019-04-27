Received: from eggs.gnu.org ([209.51.188.92]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hKQxd-0007gH-5w
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hKQxc-0005wK-9Z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:18:01 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190427154539.11336-1-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <82672e3e-b7e4-4b07-a31b-c600e1374607@twiddle.net>
Date: Sat, 27 Apr 2019 10:17:51 -0700
MIME-Version: 1.0
In-Reply-To: <20190427154539.11336-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Add -Wno-typedef-redefinition
 to CFLAGS (for Clang)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org

On 4/27/19 8:45 AM, Thomas Huth wrote:
> Without the -Wno-typedef-redefinition option, clang complains if a typedef
> gets redefined in gnu99 mode (since this is officially a C11 feature). This
> used to also happen with older versions of GCC, but since we've bumped our
> minimum GCC version to 4.8, all versions of GCC that we support do not seem
> to issue this warning in gnu99 mode anymore. So this has become a common
> problem for people who only test their code with GCC - they do not notice
> the issue until they submit their patches and suddenly patchew or a
> maintainer complains.
> 
> Now that we do not urgently need to keep the code clean from typedef
> redefintions anymore with recent versions of GCC, we can ease the
> situation with clang, too, and simply shut these warnings off for good.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
