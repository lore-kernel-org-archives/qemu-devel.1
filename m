Received: from eggs.gnu.org ([2001:4830:134:3::10]:48545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOmU-0000ei-Ez
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOmQ-0007Qs-Cg
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:24:14 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:46282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeOmQ-0007QV-6R
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:24:10 -0500
Received: by mail-pf0-x236.google.com with SMTP id y5so3588044pff.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 09:24:10 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4099e682-25ae-7b31-71f5-bad1d92284f1@linaro.org>
Date: Wed, 24 Jan 2018 09:24:06 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/22] fpu/softfloat: re-factor muladd
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

On 01/24/2018 05:13 AM, Alex Bennée wrote:
> +    if (a.cls >= float_class_qnan ||
> +        b.cls >= float_class_qnan ||
> +        c.cls >= float_class_qnan) {
> +        return pick_nan_muladd_parts(a, b, c, inf_zero, s);
> +    }

is_nan.


r~
