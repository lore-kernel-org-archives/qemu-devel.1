Received: from eggs.gnu.org ([2001:4830:134:3::10]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAXYJ-000347-Pw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAXYE-0003G8-TZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:42:11 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eAXYE-0003EY-Ms
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:42:06 -0400
Received: by mail-wm0-x241.google.com with SMTP id b9so3537377wmh.0
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:42:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <201711030837145949795@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <811e6387-83c3-0d30-89a0-22c6cc847178@twiddle.net>
Date: Fri, 3 Nov 2017 09:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <201711030837145949795@zte.com.cn>
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

On 11/03/2017 01:37 AM, jiang.biao2@zte.com.cn wrote:
>> On 11/02/2017 12:23 PM, jiang.biao2@zte.com.cn wrote:
>>> No, :) Just found some of these functions are inline and others are not when reading
>>> the code, the style looks inconsistent.
>>>
>> My preference would be to remove them all.
> Should I commit another patch to do that? :) 

If you find the inconsistency distracting, yes.


r~
