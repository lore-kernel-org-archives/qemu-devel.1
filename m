Received: from eggs.gnu.org ([2001:4830:134:3::10]:57593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAD8N-0003QI-Of
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAD8K-0000XI-OK
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:54:03 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:50345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eAD8K-0000Wo-HF
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:54:00 -0400
Received: by mail-wm0-x22d.google.com with SMTP id s66so10052044wmf.5
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 03:54:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1509618375-164238-1-git-send-email-jiang.biao2@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f4e7a6b9-7cdc-b986-2edb-c361622a23a7@twiddle.net>
Date: Thu, 2 Nov 2017 11:53:55 +0100
MIME-Version: 1.0
In-Reply-To: <1509618375-164238-1-git-send-email-jiang.biao2@zte.com.cn>
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
To: Jiang Biao <jiang.biao2@zte.com.cn>, aurelien@aurel32.net
Cc: qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

On 11/02/2017 11:26 AM, Jiang Biao wrote:
> Make some functions inline.

Why?

Do you have evidence that the compiler isn't making reasonable default choices
with respect to inlining?


r~
