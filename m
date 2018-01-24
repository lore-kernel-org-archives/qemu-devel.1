Received: from eggs.gnu.org ([2001:4830:134:3::10]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNwu-0001Sa-1U
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNwq-00087p-6T
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:30:56 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeNwp-00086B-W1
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:30:52 -0500
Received: by mail-pf0-x243.google.com with SMTP id k19so3464958pfj.5
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:30:51 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9d7c2ae-c96d-71a7-36e6-b622803756a2@linaro.org>
Date: Wed, 24 Jan 2018 08:30:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/22] include/fpu/softfloat: remove
 USE_SOFTFLOAT_STRUCT_TYPES
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

On 01/24/2018 05:12 AM, Alex Bennée wrote:
> It's not actively built and when enabled things fail to compile. I'm
> not sure the type-checking is really helping here. Seeing as we "own"
> our softfloat now lets remove the cruft.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
