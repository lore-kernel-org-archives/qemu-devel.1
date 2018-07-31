Received: from eggs.gnu.org ([2001:4830:134:3::10]:52716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkXdX-00069x-3w
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkXdS-0005en-Hn
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:36:38 -0400
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:42219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkXdS-0005eT-9b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:36:34 -0400
Received: by mail-vk0-x232.google.com with SMTP id t4-v6so7827141vke.9
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:36:34 -0700 (PDT)
References: <CABoDooME+KJVWJQcodVC-Mo2qpZhmYA3LVBLQcTj88qW1i5h5g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b29881c1-ae9f-d6c1-9dbf-eec3051d65a7@linaro.org>
Date: Tue, 31 Jul 2018 12:36:29 -0400
MIME-Version: 1.0
In-Reply-To: <CABoDooME+KJVWJQcodVC-Mo2qpZhmYA3LVBLQcTj88qW1i5h5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ARM: SVE while issue
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

On 07/31/2018 09:52 AM, Laurent Desnogues wrote:
> Hello Richard,
> 
> according to SVE specification, whilels/whilele instructions have a
> special case where if the second operand is the maximum (un)signed
> integer then the result is an all-true predicate.  The current code in
> trans_WHILE doesn't seem to capture that requirement.  I'm afraid the
> fix won't be as trivial as for the other two bugs I reported :-)

Still not too bad.
Testing a fix for my branch now.

Annoying that risu didn't randomly generate this case,
and I totally mis-read the documentation for this.


r~
