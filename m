Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnMk-0000xW-MX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnMg-00055Z-OJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:42 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnMg-00055R-KP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:38 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so13692913qta.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:03:38 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-9-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c5a70e72-728f-bdf5-9b5f-c82919eddf0a@twiddle.net>
Date: Tue, 30 May 2017 13:03:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-9-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/29] target/s390x: implement STORE
 PAIR TO QUADWORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> +    TCGMemOpIdx oi = make_memop_idx(MO_TEQ, mem_idx);

Similarly, alignment.


r~
