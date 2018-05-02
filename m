Received: from eggs.gnu.org ([2001:4830:134:3::10]:58158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDuar-0000I8-IG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDuan-0005hm-Fv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:27:01 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:44420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDuan-0005hQ-8u
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:26:57 -0400
Received: by mail-pf0-x22f.google.com with SMTP id q22so12215920pff.11
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 09:26:57 -0700 (PDT)
References: <20180502154344.10585-1-alex.bennee@linaro.org>
	<20180502154344.10585-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab75561d-3484-d02d-2733-d0cafd12ecd3@linaro.org>
Date: Wed, 2 May 2018 09:26:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180502154344.10585-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] fpu/softfloat: re-factor float to
 float conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 05/02/2018 08:43 AM, Alex Bennée wrote:
> +    if (is_nan(a.cls)) {
> +
> +        if (is_snan(a.cls)) {

Watch your whitespace.


r~
