Received: from eggs.gnu.org ([2001:4830:134:3::10]:60401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUStE-0006Du-Ou
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUStB-0006oa-FX
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:13:52 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:34742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUStB-0006oM-9C
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:13:49 -0400
Received: by mail-it0-x242.google.com with SMTP id o202so11933739itc.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 00:13:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499669979-25904-1-git-send-email-jiang.biao2@zte.com.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0eddd3b6-c05b-8b8f-f0d8-5745bde073e9@twiddle.net>
Date: Sun, 9 Jul 2017 21:13:25 -1000
MIME-Version: 1.0
In-Reply-To: <1499669979-25904-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] tcg/mips: Bugfix for crash when running
 program with qemu-i386.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>, qemu-devel@nongnu.org
Cc: jinguojie@loongson.cn, james.hogan@imgtec.com, jiang.yong5@zte.com.cn, wang.liang82@zte.com.cn, shi.zhongbing@zte.com.cn, zhong.weidong@zte.com.cn

On 07/09/2017 08:59 PM, Jiang Biao wrote:
> When running a helloworld program with qemu-i386 in linux-user
> mode on Loongson 3A3000, it will crash. This patch fix the bug.
> 
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>

Thanks, applied to tcg-next.


r~
