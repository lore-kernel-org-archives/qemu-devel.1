Received: from eggs.gnu.org ([2001:4830:134:3::10]:49642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dumCa-0003fl-0D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dumCW-0004Yt-Rb
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:06:35 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:55848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dumCW-0004YZ-MM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:06:32 -0400
Received: by mail-io0-x22b.google.com with SMTP id z187so6546246ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:06:32 -0700 (PDT)
References: <20170919150313.10833-1-richard.henderson@linaro.org>
	<20170919150313.10833-5-richard.henderson@linaro.org>
	<87y3p9d3fq.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <929c47da-b3e6-b8e8-36aa-e02bfc6a31fd@linaro.org>
Date: Wed, 20 Sep 2017 16:06:28 -0500
MIME-Version: 1.0
In-Reply-To: <87y3p9d3fq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/8] disas: Support the Capstone
 disassembler library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 09/20/2017 06:17 AM, Alex Bennée wrote:
> Hmm I get a link failure:
> 
>   LINK    tilegx-linux-user/qemu-tilegx
> disas.o: In function `cap_disas_start':
> /home/alex/lsrc/qemu/qemu.git/disas.c:196: undefined reference to `cs_open'

As discussed on IRC, this turned out to be wrong link ordering due to me
placing -lcapstone in LDFLAGS instead of LIBS.  Fixed locally.

Any other comments on the patch set?


r~
