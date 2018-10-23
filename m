Received: from eggs.gnu.org ([2001:4830:134:3::10]:45000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwMu-0001pj-F2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEwMk-0003sj-BY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:05:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEwMk-0003rp-3B
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 09:04:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 193-v6so1711348wme.3
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 06:04:58 -0700 (PDT)
References: <20181023120454.28553-1-richard.henderson@linaro.org>
	<20181023120454.28553-6-richard.henderson@linaro.org>
	<0c6ccdcc-8456-5243-8211-64c81610fb67@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <171c9d49-015d-c3a4-216b-c7c682bc6cd7@linaro.org>
Date: Tue, 23 Oct 2018 14:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <0c6ccdcc-8456-5243-8211-64c81610fb67@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] target/riscv: Convert @cs_2 insns to
 share translation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

On 10/23/18 1:26 PM, Philippe Mathieu-Daudé wrote:
>>   +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wredundant-decls"
> 
> We might move that to a generic Makefile rule, this will be useful for other
> archs.
> 
> Something like:
> 
> translate*.o: CPPFLAGS += -Wno-redundant-decls

I did want to restrict that to the one region though.


r~
