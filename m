Received: from eggs.gnu.org ([2001:4830:134:3::10]:50883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIOp-0001hK-Vl
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIOm-0001NQ-5F
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:48 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:35235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIOl-0001ND-WB
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:44 -0400
Received: by mail-pf0-x230.google.com with SMTP id c73so39570581pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:01:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-5-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a5880e3b-7245-87c0-a8a5-3b711ba5a0bd@twiddle.net>
Date: Sun, 9 Jul 2017 10:01:34 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-5-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/22] tcg: fix corruption of code_time
 profiling counter upon tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> Whenever there is an overflow in code_gen_buffer (e.g. we run out
> of space in it and have to flush it), the code_time profiling counter
> ends up with an invalid value (that is, code_time -= profile_getclock(),
> without later on getting += profile_getclock() due to the goto).
> 
> Fix it by using the ti variable, so that we only update code_time
> when there is no overflow. Note that in case there is an overflow
> we fail to account for the elapsed coding time, but this is quite rare
> so we can probably live with it.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
