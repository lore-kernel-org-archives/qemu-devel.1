Received: from eggs.gnu.org ([2001:4830:134:3::10]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNxV-0001kH-EE
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeNxR-0000P2-I2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:31:33 -0500
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:41419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeNxR-0000N4-DH
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:31:29 -0500
Received: by mail-pg0-x229.google.com with SMTP id 136so3052570pgd.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:31:29 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f8f996e-ea41-0fba-d0a6-d2ee26797ba1@linaro.org>
Date: Wed, 24 Jan 2018 08:31:25 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/22] fpu/softfloat-types: new header
 to prevent excessive re-builds
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
> The main culprit here is bswap.h which pulled in softfloat.h so it
> could use the types in its CPU_Float* and ldfl/stfql functions. As
> bswap.h is very widely included this added a compile dependency every
> time we touch softfloat.h. Move the typedefs for each float type into
> their own file so we don't re-build the world every time we tweak the
> main softfloat.h header.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - new in v3
> ---
>  include/fpu/softfloat-types.h | 115 ++++++++++++++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h       |  31 +-----------
>  include/qemu/bswap.h          |   2 +-
>  3 files changed, 117 insertions(+), 31 deletions(-)
>  create mode 100644 include/fpu/softfloat-types.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
