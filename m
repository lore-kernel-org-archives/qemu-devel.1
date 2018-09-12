Received: from eggs.gnu.org ([2001:4830:134:3::10]:40219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fztK7-0000cd-Oj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 20:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fztIt-00089Y-NQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 20:46:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fztIt-000892-G7
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 20:46:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id u24-v6so83708pfn.13
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 17:46:45 -0700 (PDT)
References: <20180910185859.27917-1-cota@braap.org>
	<20180910185859.27917-13-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8fc81928-961d-7c5b-b34e-38f55d4257af@linaro.org>
Date: Tue, 11 Sep 2018 17:46:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180910185859.27917-13-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] qht-bench: add -p flag to
 precompute hash values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/10/2018 11:58 AM, Emilio G. Cota wrote:
> @@ -289,7 +297,9 @@ static void htable_init(void)
>      /* avoid allocating memory later by allocating all the keys now */
>      keys = g_malloc(sizeof(*keys) * n);
>      for (i = 0; i < n; i++) {
> -        keys[i] = populate_offset + i;
> +        long val = populate_offset + i;
> +
> +        keys[i] = precompute_hash ? h(val) : hval(val);

hfunc?


r~
