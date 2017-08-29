Received: from eggs.gnu.org ([2001:4830:134:3::10]:46463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiSc-0000nE-Ey
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiSZ-0002vC-C4
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:29:50 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiSZ-0002uD-7I
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:29:47 -0400
Received: by mail-pg0-x22f.google.com with SMTP id r133so11751232pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:29:47 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0ddcc01-ef6d-828a-8d6b-9c777c21c0e3@linaro.org>
Date: Tue, 29 Aug 2017 08:29:43 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/20] target/arm: Register second
 AddressSpace for secure v8M CPUs
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
> If a v8M CPU supports the security extension then we need to
> give it two AddressSpaces, the same way we do already for
> an A profile core with EL3.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
