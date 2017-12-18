Received: from eggs.gnu.org ([2001:4830:134:3::10]:52847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR421-0005Oc-6S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR41w-0000T3-72
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:37:09 -0500
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:37017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR41v-0000Rw-Vv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:37:04 -0500
Received: by mail-pl0-x233.google.com with SMTP id s3so5712738plp.4
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:37:03 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48f8d28f-91fd-051d-c24b-63d4c96c46d5@linaro.org>
Date: Mon, 18 Dec 2017 14:36:58 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 13/19] fpu/softfloat: re-factor muladd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> +    if (flags & float_muladd_halve_result) {
> +            p_exp -= 1;
> +    }

Indent.  Otherwise, I was involved in writing this, so

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
