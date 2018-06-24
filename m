Received: from eggs.gnu.org ([2001:4830:134:3::10]:59075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDy3-0002MQ-JM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDy0-0002co-NO
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:58:47 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXDy0-0002c8-I1
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:58:44 -0400
Received: by mail-pg0-x243.google.com with SMTP id w8-v6so5207407pgp.7
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 15:58:44 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfdc22ae-aad9-be50-7613-86eb179580fa@linaro.org>
Date: Sun, 24 Jun 2018 15:58:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 20/22] risu_reginfo_aarch64: add
 SVE support to reginfo_dump_mismatch
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

On 06/22/2018 07:12 AM, Alex Bennée wrote:
> We also tweak the justification of the rest of the registers so the :
> lines up nicely across the register dump and diff dump.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - include ffr in comparison
>   - mild re-factor of preg cmp/diff
> v3
>   - re-factoring
> v4
>   - alignment/justification tweaks
>   - merge chunks from the variable VQ patch
> ---
>  risu_reginfo_aarch64.c | 140 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 124 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
