Received: from eggs.gnu.org ([209.51.188.92]:48046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBHW-0002JS-42
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBHU-0003r3-6a
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:53:05 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBHT-0003jr-MX
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:53:03 -0500
Received: by mail-pf1-x443.google.com with SMTP id q1so5445430pfi.5
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:52:57 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0edb1c50-cb9e-5f0b-2f85-2a3e610a052b@linaro.org>
Date: Fri, 25 Jan 2019 15:52:54 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/23] hw/arm/iotkit: Rename 'iotkit' local
 variables and functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 1/21/19 10:51 AM, Peter Maydell wrote:
> Rename various internal uses of 'iotkit' in hw/arm/iotkit.c to
> 'armsse', for consistency. The remaining occurences are:
>  * related to the devices TYPE_IOTKIT_SYSCTL, TYPE_IOTKIT_SYSINFO,
>    etc, which this refactor is not touching
>  * references that apply specifically to the IoTKit (like
>    the lack of a private CPU region)
>  * the vmstate, which keeps its old "iotkit" name for
>    migration compatibility reasons
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/iotkit.c | 68 ++++++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
