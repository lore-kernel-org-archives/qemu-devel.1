Received: from eggs.gnu.org ([2001:4830:134:3::10]:34216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkAnS-0008Nj-VF
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkAnQ-0003xa-72
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:22 -0400
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:44429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkAnQ-0003xC-0v
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:20 -0400
Received: by mail-ua0-x230.google.com with SMTP id k25-v6so8199693uao.11
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 09:13:19 -0700 (PDT)
References: <CABoDooMqFQz_ssUKxMgxRCArF0dLCAa+=cjY5bqR399ZoHcxvw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b0a0b13-eb30-64cb-5919-c44750e04ca0@linaro.org>
Date: Mon, 30 Jul 2018 12:13:15 -0400
MIME-Version: 1.0
In-Reply-To: <CABoDooMqFQz_ssUKxMgxRCArF0dLCAa+=cjY5bqR399ZoHcxvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ARM: SVE issue in cmpeq/cmpne
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 07/30/2018 10:20 AM, Laurent Desnogues wrote:
> Hello Richard,
> 
> According to SVE definition, the operands of cmpeq/cmpne SVE
> instructions are signed, so I guess the definitions of
> sve_cmpeq_ppzw_[bhs] and sve_cmpne_ppzw_[bhs] should use signed types.
> The other cmpcc instructions look good.

Good catch, thanks.


r~
