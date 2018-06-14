Received: from eggs.gnu.org ([2001:4830:134:3::10]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYod-0003Bu-WB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYob-0006z2-10
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:55 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYoa-0006xj-Ra
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:25:52 -0400
Received: by mail-pg0-x233.google.com with SMTP id c9-v6so3421727pgf.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:25:52 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <118766dd-d000-f5bc-17f4-fa00685df5ef@linaro.org>
Date: Thu, 14 Jun 2018 10:25:48 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 17/22] risu_reginfo: introduce
 reginfo_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> In preparation for conditionally supporting SVE we need to be able to
> have different sized reginfos. This introduces reginfo_size() to
> abstract the size away to the code the actually knows. For aarch64 we
> also use this while initialising the block.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  reginfo.c              |  6 +++---
>  risu.h                 |  3 +++
>  risu_reginfo_aarch64.c | 11 ++++++++++-
>  risu_reginfo_aarch64.h |  1 +
>  risu_reginfo_arm.c     |  5 +++++
>  risu_reginfo_m68k.c    |  5 +++++
>  risu_reginfo_ppc64.c   |  5 +++++
>  7 files changed, 32 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
