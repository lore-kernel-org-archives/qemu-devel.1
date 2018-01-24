Received: from eggs.gnu.org ([2001:4830:134:3::10]:39967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOIq-0003S4-4I
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeOIn-0000xL-3A
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:53:36 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:41400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeOIm-0000wy-Sq
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 11:53:32 -0500
Received: by mail-pf0-x236.google.com with SMTP id c6so3520098pfi.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 08:53:32 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff134c6b-31ac-955c-91fa-24fd5ab62498@linaro.org>
Date: Wed, 24 Jan 2018 08:53:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/22] fpu/softfloat: re-factor mul
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
> +    /* handle all the NaN cases */
> +    if (a.cls >= float_class_qnan || b.cls >= float_class_qnan) {
> +        return pick_nan_parts(a, b, s);
> +    }

is_nan.


r~
