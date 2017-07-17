Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFOn-0005ph-07
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFOi-0000x6-Cu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:25:57 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:34206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFOi-0000wo-7X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:25:52 -0400
Received: by mail-qk0-x230.google.com with SMTP id t2so846282qkc.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:25:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-13-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fdcb44bf-02cb-f801-02e1-616c36c3e331@twiddle.net>
Date: Mon, 17 Jul 2017 13:25:45 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-13-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/45] tcg: remove addr argument from
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:03 AM, Emilio G. Cota wrote:
> It is unlikely that we will ever want to call this helper passing
> an argument other than the current PC. So just remove the argument,
> and use the pc we already get from cpu_get_tb_cpu_state.
> 
> This change paves the way to having a common "tb_lookup" function.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
