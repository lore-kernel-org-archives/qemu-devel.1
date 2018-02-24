Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNnH-0004wW-6r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNnE-0002Pw-2s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:34:27 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNnD-0002OF-SX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:34:24 -0500
Received: by mail-pl0-x230.google.com with SMTP id v3so5841873plg.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:34:23 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <936e2bf8-e254-20fc-cfba-11fdff64a957@linaro.org>
Date: Fri, 23 Feb 2018 16:34:19 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 22/31] arm/helper.c: re-factor recpe and
 add recepe_f16
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
> It looks like the ARM ARM has simplified the pseudo code for the
> calculation which is done on a fixed point 9 bit integer maths. So
> while adding f16 we can also clean this up to be a little less heavy
> on the floating point and just return the fractional part and leave
> the calle's to do the final packing of the result.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - fix comment 2.0^-16
>   - f16_exp >= 29 (biased)
>   - remove confusing comment about fpst
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
