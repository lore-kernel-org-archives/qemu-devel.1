Received: from eggs.gnu.org ([209.51.188.92]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhT-0001gv-SE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhS-0000lp-Sr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:51 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLhS-0000lD-Ib
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id j24so39968pgk.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:28:49 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-20-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd34aad9-fe14-5262-0244-1ff2332d20f9@linaro.org>
Date: Wed, 24 Apr 2019 10:28:45 -0700
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-20-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 20/20] gdbstub: Refactor parse handle
 packet to work with a static array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arilou@gmail.com, qemu-devel@nongnu.org

On 4/24/19 7:27 AM, arilou@gmail.com wrote:
> +static GdbCmdParseEntry gdb_packet_table[0x100] = {

21 out of 256 entries used?  That's a pretty poor occupancy rate.
What was wrong with the switch statement?

Or a modified version in which you sink the call to process_string_cmd
and only load the pointer to the structure within the switch.


r~
