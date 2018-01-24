Received: from eggs.gnu.org ([2001:4830:134:3::10]:40671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeONG-0004vz-JA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeONB-0004Ax-Nm
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:58:10 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:40679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeONB-00049z-HM
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:58:05 -0500
Received: by mail-pf0-x236.google.com with SMTP id i66so3528011pfd.7
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:58:05 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5053f60-9885-7aef-5f3e-b77a6cb924da@linaro.org>
Date: Wed, 24 Jan 2018 08:58:01 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/22] fpu/softfloat: re-factor div
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
> +    if (a.cls >= float_class_qnan || b.cls >= float_class_qnan) {
> +        return pick_nan_parts(a, b, s);
> +    }

is_nan.


r~
