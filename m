Received: from eggs.gnu.org ([2001:4830:134:3::10]:48752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxHn-0006V4-5B
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxHk-0006Pq-1w
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:02:03 -0500
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYxHj-0006PB-S9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:01:59 -0500
Received: by mail-pf0-x22a.google.com with SMTP id m26so8962037pfj.11
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:01:59 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c278ee6b-6365-6287-19cb-66989818a0e7@linaro.org>
Date: Tue, 9 Jan 2018 09:01:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/20] fpu/softfloat: define decompose
 structures
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

On 01/09/2018 04:22 AM, Alex Bennée wrote:
> +    float_class_qnan,
> +    float_class_snan,
> +    float_class_dnan,

  /* default nan */

here wouldn't go amiss.

> +    float_class_msnan, /* maybe silenced */


r~
