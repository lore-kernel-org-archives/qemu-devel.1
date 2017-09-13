Received: from eggs.gnu.org ([2001:4830:134:3::10]:42492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA0p-0002rw-MW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA0l-0000Rp-KQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:55:39 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:45519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsA0l-0000QX-F4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:55:35 -0400
Received: by mail-pf0-x22e.google.com with SMTP id q76so905375pfq.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:55:35 -0700 (PDT)
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <608a9eba-8a22-aa87-aa2d-b67669bad17f@linaro.org>
Date: Wed, 13 Sep 2017 08:55:31 -0700
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/arm: Clear exclusive monitor on
 v7M reset, exception entry/exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/11/2017 06:52 AM, Peter Maydell wrote:
> For M profile we must clear the exclusive monitor on reset, exception
> entry and exception exit.  We weren't doing any of these things; fix
> this bug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 10 ++++++++++
>  target/arm/cpu.c       |  6 ++++++
>  target/arm/helper.c    |  2 ++
>  target/arm/op_helper.c |  2 +-
>  4 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
