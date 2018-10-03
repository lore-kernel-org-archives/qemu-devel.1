Received: from eggs.gnu.org ([2001:4830:134:3::10]:35995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nD8-0004e3-Go
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nD3-0000cX-Dz
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:53:30 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nD0-0000aX-8b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:53:24 -0400
Received: by mail-io1-xd42.google.com with SMTP id w16-v6so6046178iom.7
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:53:17 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <466ca17b-61ee-5881-0f68-2f6837f34ee9@linaro.org>
Date: Wed, 3 Oct 2018 14:53:12 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/13] target/arm: Move v7m_using_psp() to
 internals.h
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

On 10/2/18 11:35 AM, Peter Maydell wrote:
> We're going to want v7m_using_psp() in op_helper.c in the
> next patch, so move it from helper.c to internals.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 15 +++++++++++++++
>  target/arm/helper.c    | 12 ------------
>  2 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
