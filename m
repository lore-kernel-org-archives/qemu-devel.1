Received: from eggs.gnu.org ([2001:4830:134:3::10]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYpO-0003sJ-Kj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYpL-0007ut-Iq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:26:42 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYpL-0007t8-D3
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:26:39 -0400
Received: by mail-pf0-x244.google.com with SMTP id c22-v6so3785649pfi.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:26:39 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-19-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5764ab25-6e62-e86b-1a78-d59a82c45f7b@linaro.org>
Date: Thu, 14 Jun 2018 10:26:34 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 18/22] risu_reginfo_aarch64: left
 justify regnums and drop masks
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
> Left justification is more pleasing to the eye than the default. We
> also drop the masking which isn't needed as we are casting to a
> smaller size anyway.
> 
> This was split out of Richard's re-factoring work for SVE.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
