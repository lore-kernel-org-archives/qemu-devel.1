Received: from eggs.gnu.org ([209.51.188.92]:56671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLhB-00018K-St
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLSz-0002Dc-TX
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:13:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:45431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLSz-0002CX-Lf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:13:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id e24so9615389pfi.12
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:13:53 -0700 (PDT)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-2-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef86e214-eb94-034a-16a4-30a7334c6e0e@linaro.org>
Date: Wed, 24 Apr 2019 10:13:48 -0700
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-2-arilou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/20] gdbstub: Implement deatch (D pkt)
 with new infra
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: arilou@gmail.com, qemu-devel@nongnu.org

On 4/24/19 7:26 AM, arilou@gmail.com wrote:
> +        {
> +            static GdbCmdParseEntry deatch_cmd_desc = {

static const.  s/deatch/detach/.

That'll require changes to patch 1, since process_string_cmd doesn't take a
const GdbCmdParseEntry pointer.

> +                .handler = handle_detach,
> +                .cmd = "D",
> +                .cmd_startswith = 1,
> +                .schema = "?.l0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);

process_string_cmd returns errors, which you make no attempt to handle here.
Should the errors returns in fact be asserts?


r~
