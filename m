Received: from eggs.gnu.org ([209.51.188.92]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPfo-0003Wx-NG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtPfn-0000wR-7E
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:27:56 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtPfk-0000Zt-KG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:27:54 -0500
Received: by mail-pf1-x441.google.com with SMTP id j18so670083pfe.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:27:35 -0800 (PST)
References: <20190211181907.2219-2-svens@stackframe.org>
	<20190211181907.2219-5-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d209109-b242-45f2-2132-4d8e196898fc@linaro.org>
Date: Mon, 11 Feb 2019 20:27:32 -0800
MIME-Version: 1.0
In-Reply-To: <20190211181907.2219-5-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/hppa: fix sed conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <rth@twiddle.net>

On 2/11/19 10:19 AM, Sven Schnelle wrote:
> -    f = (orig & 4) / 4;
> -
> -    return do_log_cond(c * 2 + f, res);

Given that this used to reference do_log_cond, and you've fixed do_log_cond,
why is there any reason for a change here?


r~
