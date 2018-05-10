Received: from eggs.gnu.org ([2001:4830:134:3::10]:36095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGmuG-0005Qa-37
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGmuC-0005kk-Uw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:50:56 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:36202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGmuC-0005jL-OJ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:50:52 -0400
Received: by mail-pl0-x22d.google.com with SMTP id v24-v6so1449335plo.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 07:50:52 -0700 (PDT)
References: <20180510094206.15354-1-alex.bennee@linaro.org>
	<20180510094206.15354-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa6da963-7af2-ef74-8dc8-97486949a0cb@linaro.org>
Date: Thu, 10 May 2018 07:50:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180510094206.15354-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] fpu/softfloat: int_to_float ensure
 r fully initialised
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 05/10/2018 02:42 AM, Alex Bennée wrote:
> Reported by Coverity (CID1390635). We ensure this for uint_to_float
> later on so we might as well mirror that.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
