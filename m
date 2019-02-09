Received: from eggs.gnu.org ([209.51.188.92]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsW8a-0005kz-4G
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 12:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsW8Y-0005Tb-5X
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 12:09:56 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsW8V-0005Qu-SJ
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 12:09:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id d72so2947366pga.9
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 09:09:50 -0800 (PST)
References: <20190209162745.12668-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <092ef5ac-15a7-8515-a220-0c9cb405b744@linaro.org>
Date: Sat, 9 Feb 2019 09:09:45 -0800
MIME-Version: 1.0
In-Reply-To: <20190209162745.12668-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/9/19 8:27 AM, Emilio G. Cota wrote:
> Fix a bug introduced with dynamic TLB sizing -- we forgot to account
> for possible TLB resizes during tlb_fill().
> 
> Max reported the bug and provided a reproducer here:
>   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02283.html

Thanks, queued.


r~
