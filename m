Received: from eggs.gnu.org ([2001:4830:134:3::10]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFVO-0000GG-S5
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFVO-0000vE-8A
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:42:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEFVO-0000uz-3F
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:42:14 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so1196717qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 06:42:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0e008f0f-1b33-c3d9-4cee-997c5701493f@twiddle.net>
Date: Fri, 26 May 2017 06:42:08 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/26] target/s390x: implement TEST AND SET
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

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> +    TCGv_i32 t1 = tcg_const_i32(0xff);
> +    tcg_gen_atomic_fetch_or_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);

Better as tcg_gen_atomic_xchg_i32.


r~
