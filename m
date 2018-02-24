Received: from eggs.gnu.org ([2001:4830:134:3::10]:35803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNvM-0006V8-Ni
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNvJ-0004DB-Ju
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:42:48 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNvJ-0004CN-Cd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:42:45 -0500
Received: by mail-pg0-x241.google.com with SMTP id m19so3985735pgn.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:42:45 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c2ed30f0-f5b0-fec1-0889-e1cb0a786b38@linaro.org>
Date: Fri, 23 Feb 2018 16:42:41 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 28/31] arm/translate-a64: add FP16 FMOV
 to simd_mod_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
> Only one half-precision instruction has been added to this group.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> v3
>   - use vfp_expand_imm
> ---
>  target/arm/translate-a64.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
