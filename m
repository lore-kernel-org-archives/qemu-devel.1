Received: from eggs.gnu.org ([2001:4830:134:3::10]:35579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diR53-0002oH-KS
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diR4z-00089F-5R
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:07:49 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diR4y-00088q-Vo
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:07:45 -0400
Received: by mail-pg0-x22d.google.com with SMTP id t3so21548413pgt.0
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:07:44 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e2fa1a2-d5e7-e6fb-3b88-6b9f1f9f76d9@linaro.org>
Date: Thu, 17 Aug 2017 13:07:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/9] tcg: introduce the concepts of a
 TCGv_vec register type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:03 AM, Alex Bennée wrote:
> Currently it only makes sense for globals - i.e. registers directly
> mapped to CPUEnv.
> ---
>  tcg/README |  1 +
>  tcg/tcg.h  | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)

I'm not keen on this.  I know it makes for nicer intermediate dumps, but I'd
rather expose the pointer addition directly (or not, and fold it into a memory
offset).


r~
