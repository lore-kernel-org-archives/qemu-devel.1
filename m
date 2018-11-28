Received: from eggs.gnu.org ([2001:4830:134:3::10]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gS0Xg-0007wr-NQ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gS0Xf-0000SP-2h
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:10:16 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cd4d71e5-e24a-17c6-d49d-27ed87bc7f9d@twiddle.net>
Date: Wed, 28 Nov 2018 06:09:59 -0800
MIME-Version: 1.0
In-Reply-To: <1543399094-2260-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 11/28/18 1:58 AM, Thomas Huth wrote:
> Clang 3.4 does not know the "flatten" attribute yet. We've already
> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
> so use this macro now here, too, to fix this issue.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/sve_helper.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
