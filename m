Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5h4f-0004iJ-O7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5h4e-0002ih-P5
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:23:49 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5h4e-0002iJ-Hf
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 20:23:48 -0400
Received: by mail-pf0-x22c.google.com with SMTP id q9so6775024pff.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 17:23:48 -0700 (PDT)
References: <20180406013628.25900-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e48b259d-09b6-cd51-65cb-ded45ecae6c3@linaro.org>
Date: Tue, 10 Apr 2018 10:23:40 +1000
MIME-Version: 1.0
In-Reply-To: <20180406013628.25900-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/06/2018 11:36 AM, Max Filippov wrote:
> +static void target_to_host_low_high(abi_ulong tlow,
> +                                    abi_ulong thigh,
> +                                    unsigned long *hlow,
> +                                    unsigned long *hhigh)
> +{
> +    unsigned long long off = tlow |
> +        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<
> +        TARGET_LONG_BITS / 2;

Use uint64_t instead of unsigned long long.

> +
> +    *hlow = (unsigned long)off;
> +    *hhigh = (unsigned long)((off >> HOST_LONG_BITS / 2) >>
> +                             HOST_LONG_BITS / 2);

The casts here are unnecessary and are implied by the assignment.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
