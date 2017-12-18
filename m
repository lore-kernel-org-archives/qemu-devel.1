Received: from eggs.gnu.org ([2001:4830:134:3::10]:38188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Np-00061s-DA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Nk-0007Zn-GF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:37 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3Nk-0007ZM-6s
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:32 -0500
Received: by mail-pf0-x242.google.com with SMTP id y89so10261996pfk.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:55:32 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1524831e-0651-5c64-76b4-7d2ef7c8fb9f@linaro.org>
Date: Mon, 18 Dec 2017 13:53:20 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 06/19] fpu/softfloat: propagate
 signalling NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> While a comparison between a QNaN and a number will return the number
> it is not the same with a signaling NaN. In this case the SNaN will
> "win" and after potentially raising an exception it will be quietened.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - added return for propageFloat
> ---
>  fpu/softfloat.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I suppose this fixes minmax for float128 too,
and is thus not redundant with patch 18?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
