Received: from eggs.gnu.org ([2001:4830:134:3::10]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxRg-00053i-C8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxRc-0005Vr-Jr
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:12:16 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYxRc-0005VO-Cp
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:12:12 -0500
Received: by mail-pf0-x242.google.com with SMTP id i66so2040370pfd.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:12:12 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b9024480-280b-bb1f-3845-5c626fcc31d4@linaro.org>
Date: Tue, 9 Jan 2018 09:12:08 -0800
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/20] fpu/softfloat: re-factor float to
 int/uint
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
> We share the common int64/uint64_pack_decomposed function across all
> the helpers and simply limit the final result depending on the final
> size.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> --
> v2
>   - apply float_flg_invalid fixes next patch
> ---
>  fpu/softfloat.c         | 1011 +++++++++++------------------------------------
>  include/fpu/softfloat.h |   13 +
>  2 files changed, 235 insertions(+), 789 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
