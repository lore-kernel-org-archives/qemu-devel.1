Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddghM-0007k0-Vn
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ddghI-0005Tw-3W
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:47:45 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:36046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ddghH-0005T0-SD
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:47:40 -0400
Received: by mail-pg0-x233.google.com with SMTP id v77so10618253pgb.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 10:47:39 -0700 (PDT)
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7bec1b4f-1fd2-4104-814b-97476d619bf5@linaro.org>
Date: Fri, 4 Aug 2017 10:47:36 -0700
MIME-Version: 1.0
In-Reply-To: <1501867249-1924-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] memory.h: Move MemTxResult type to
 memattrs.h
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

On 08/04/2017 10:20 AM, Peter Maydell wrote:
> Move the MemTxResult type to memattrs.h. We're going to want to
> use it in cpu/qom.h, which doesn't want to include all of
> memory.h. In practice MemTxResult and MemTxAttrs are pretty
> closely linked since both are used for the new-style
> read_with_attrs and write_with_attrs callbacks, so memattrs.h
> is a reasonable home for this rather than creating a whole
> new header file for it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memattrs.h | 10 ++++++++++
>  include/exec/memory.h   | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
