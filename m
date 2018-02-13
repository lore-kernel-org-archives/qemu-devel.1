Received: from eggs.gnu.org ([2001:4830:134:3::10]:41377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elejb-00089R-1g
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1elejX-0006WK-TA
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:51:15 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:45216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1elejX-0006W7-Ny
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:51:11 -0500
Received: by mail-io0-x244.google.com with SMTP id p188so22173234ioe.12
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 09:51:11 -0800 (PST)
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<20180206164815.10084-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7158387f-424b-9c63-0acf-b240338920c8@linaro.org>
Date: Tue, 13 Feb 2018 09:50:59 -0800
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 22/22] fpu/softfloat: re-factor sqrt
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

On 02/06/2018 08:48 AM, Alex Bennée wrote:
> This is a little bit of a departure from softfloat's original approach
> as we skip the estimate step in favour of a straight iteration.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - added to series
>   - fixed renames of structs
> v4
>   - fix up comments
>   - use is_nan
>   - use return_nan instead of pick_nan(a,a)
> ---
>  fpu/softfloat.c         | 201 ++++++++++++++++++++++--------------------------
>  include/fpu/softfloat.h |   1 +
>  2 files changed, 91 insertions(+), 111 deletions(-)

Did I not give you an r-b for this before?  Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
