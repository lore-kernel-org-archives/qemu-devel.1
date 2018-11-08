Received: from eggs.gnu.org ([2001:4830:134:3::10]:55419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKntE-0004y3-Qi
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKnt1-0002Uz-Tc
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:38 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKnsw-0002SR-Kx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:14:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10-v6so22076211wrv.6
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:14:25 -0800 (PST)
References: <20181108163329.19940-1-alex.bennee@linaro.org>
	<20181108163329.19940-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7f0bcd3-d9ef-7243-cea4-9e1496767757@linaro.org>
Date: Thu, 8 Nov 2018 18:14:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181108163329.19940-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/guest-debug: fix scoping of
 failcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/8/18 5:33 PM, Alex Bennée wrote:
> @@ -16,6 +16,7 @@ def report(cond, msg):
>          print ("PASS: %s" % (msg))
>      else:
>          print ("FAIL: %s" % (msg))
> +        global failcount
>          failcount += 1

Do we usually prefer such declarations at the start of the function?
Anyway,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
