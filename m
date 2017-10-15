Received: from eggs.gnu.org ([2001:4830:134:3::10]:60139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lXR-0001DM-M8
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lXN-0002sW-Mo
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:13:17 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:53591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e3lXN-0002oo-G4
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:13:13 -0400
Received: by mail-pf0-x229.google.com with SMTP id t188so11501286pfd.10
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:13:12 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <035e1431-faa8-9c85-168a-6e7dfb377017@linaro.org>
Date: Sun, 15 Oct 2017 09:13:07 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 09/30] softfloat: propagate signalling
 NaNs in MINMAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> -            if (float ## s ## _is_quiet_nan(a, status) &&               \
> +            if (float ## s ## _is_signaling_nan(a, status) ||           \
> +                float ## s ## _is_signaling_nan(b, status)) {           \
> +                propagateFloat ## s ## NaN(a, b, status);               \

Missing a return here?


r~
