Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmifp-0003Xp-3h
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmifk-0001vJ-7N
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:43:29 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:37927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmifk-0001ut-20
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:43:24 -0400
Received: by mail-pg0-x22f.google.com with SMTP id b8so11862374pgn.5
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:43:23 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-10-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66795cd3-db3d-4d6c-6012-0886d95c5352@linaro.org>
Date: Tue, 29 Aug 2017 08:43:20 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/20] target/arm: Make CONTROL register
 banked for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Make the CONTROL register banked if v8M security extensions are enabled.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  5 +++--
>  target/arm/helper.c    | 21 +++++++++++----------
>  target/arm/machine.c   |  3 ++-
>  target/arm/translate.c |  2 +-
>  4 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
