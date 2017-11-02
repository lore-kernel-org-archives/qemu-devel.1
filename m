Received: from eggs.gnu.org ([2001:4830:134:3::10]:48138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eADu9-0000r9-6X
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eADu5-0003QL-8n
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:25 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:51942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eADu5-0003Oq-2I
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:43:21 -0400
Received: by mail-wm0-x236.google.com with SMTP id b9so10763759wmh.0
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 04:43:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201711021923504024201@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1e17a8cf-e81e-91ba-5656-e8e2dfa3baea@twiddle.net>
Date: Thu, 2 Nov 2017 12:43:16 +0100
MIME-Version: 1.0
In-Reply-To: <201711021923504024201@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/mips: make some functions inline.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: aurelien@aurel32.net, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On 11/02/2017 12:23 PM, jiang.biao2@zte.com.cn wrote:
> No, :) Just found some of these functions are inline and others are not when reading 
> the code, the style looks inconsistent. 

My preference would be to remove them all.

> Besides, The compiler may make default inline choices for some functions, but may 
> not for some cases(some longer ones). Adding inline manually can guarantee and 
> not hurt. :)

The longer ones in particular should *not* be inline, so that we don't expand
the size of the code unnecessarily.  Which *can* hurt.


r~
