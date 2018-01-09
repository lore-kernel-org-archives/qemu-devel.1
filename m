Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxVr-0007tx-E6
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxVo-0000tU-AV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:16:35 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYxVo-0000t6-3u
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:16:32 -0500
Received: by mail-pg0-x241.google.com with SMTP id c194so7427036pga.12
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:16:32 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <008f6d2b-7ff4-02cd-ed5c-35db6895ccd9@linaro.org>
Date: Tue, 9 Jan 2018 09:16:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 19/20] fpu/softfloat: re-factor minmax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/09/2018 04:22 AM, Alex Bennée wrote:
> Let's do the same re-factor treatment for minmax functions. I still
> use the MACRO trick to expand but now all the checking code is common.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - minor indentation fix
> ---
>  fpu/softfloat.c         | 239 ++++++++++++++++++++++++++----------------------
>  include/fpu/softfloat.h |   6 ++
>  2 files changed, 134 insertions(+), 111 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
