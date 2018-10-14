Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj1L-0000zJ-B1
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBj1K-0005nx-Le
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:13:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBj1K-0005nh-Eq
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:13:34 -0400
Received: by mail-pf1-x441.google.com with SMTP id f78-v6so2691538pfe.1
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 09:13:34 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5cce92fa-12e7-c0a4-b689-1f5cfc4520fb@linaro.org>
Date: Sun, 14 Oct 2018 09:13:30 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] target/arm: Make switch_mode()
 file-local
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

On 10/12/18 7:42 AM, Peter Maydell wrote:
> The switch_mode() function is defined in target/arm/helper.c and used
> only in that file and nowhere else, so we can make it file-local
> rather than global.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 1 -
>  target/arm/helper.c    | 6 ++++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
