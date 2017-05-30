Received: from eggs.gnu.org ([2001:4830:134:3::10]:40835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnMU-0000ol-Do
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnMQ-0004w5-8m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnMQ-0004vo-5W
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:03:22 -0400
Received: by mail-qk0-x243.google.com with SMTP id c206so3499958qkb.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:03:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-8-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc790780-1f67-856b-6105-c678809bc2f8@twiddle.net>
Date: Tue, 30 May 2017 13:03:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-8-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/29] target/s390x: implement LOAD PAIR
 FROM QUADWORD
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

MO_TEQ | MO_ALIGN_16

as it's a specification error for the address to be unaligned.

r~
