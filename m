Received: from eggs.gnu.org ([209.51.188.92]:54643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDKD-0001mu-0v
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDGS-0003DI-G4
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:25:05 -0500
References: <20190212074840.13542-1-richard.henderson@linaro.org>
	<20190212074840.13542-2-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8e47e7c3-1903-0a02-dc05-43ddc5b8e299@vivier.eu>
Date: Thu, 14 Feb 2019 10:25:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190212074840.13542-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: Add ELF_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 12/02/2019 08:48, Richard Henderson wrote:
> The 32-bit kernel has strings for v4, v5, v6, v7, v7m.
> The 64-bit kernel, in compat mode, has strings for v8.
> 
> Fixes: https://bugs.launchpad.net/bugs/1813034
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Include v8.
> ---
>  linux-user/elfload.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Applied to my linux-user branch.

Thanks,
Laurent
