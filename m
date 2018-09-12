Received: from eggs.gnu.org ([2001:4830:134:3::10]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08qX-0002Ti-JL
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08qU-0002Xq-UT
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:22:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g08qU-0002Wu-6y
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:22:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id f1-v6so1300682plt.4
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 10:22:29 -0700 (PDT)
References: <mvmd0tkckcn.fsf@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b86b3b1-113b-fcf1-5907-7b55747d1b78@linaro.org>
Date: Wed, 12 Sep 2018 10:22:25 -0700
MIME-Version: 1.0
In-Reply-To: <mvmd0tkckcn.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: don't short-circuit read with
 zero length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org

On 09/11/2018 05:03 AM, Andreas Schwab wrote:
> +        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
> +            goto efault;

The goto should not compile on head, after 2852aafd9d05.


r~
