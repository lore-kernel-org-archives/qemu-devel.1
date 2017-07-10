Received: from eggs.gnu.org ([2001:4830:134:3::10]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUc6q-0000cT-Vr
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUc6m-0005Dg-PO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:04:32 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:34109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUc6m-0005DJ-LA
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:04:28 -0400
Received: by mail-qt0-x230.google.com with SMTP id 32so78198114qtv.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 10:04:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<87wp7gaadu.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <598548f9-24e4-ff3d-4e7e-ce90d1f5dae6@twiddle.net>
Date: Mon, 10 Jul 2017 07:04:23 -1000
MIME-Version: 1.0
In-Reply-To: <87wp7gaadu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: per-thread TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/09/2017 11:50 PM, Alex Bennée wrote:
> Side issue. Have we considered the impact on codegen buffer utilisation
> by doing an "off-code_gen_buffer" no cache translation the first time we
> ever see a TB?

No we haven't.  Possibly because we'd need additional infrastructure to do even 
that -- we'd want to record somehow that we've seen a given TB before, so that 
we *could* generate permanent code for it in future.


r~
