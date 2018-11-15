Received: from eggs.gnu.org ([2001:4830:134:3::10]:48946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNMn2-0003Im-0w
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:54:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNMmy-00014L-LS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:54:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNMmy-0000wz-FF
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:54:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so22352997wre.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 10:54:33 -0800 (PST)
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d047c0f-11df-735e-8325-83e1ac7d8371@linaro.org>
Date: Thu, 15 Nov 2018 19:54:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181115184827.GA12024@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 11/15/18 7:48 PM, Emilio G. Cota wrote:
> - All TCG contexts end up using the same hash table, since
>   we only allocate one table in tcg_context_init. This leads
>   to memory corruption.

Bah.  I forgot we only call tcg_context_init once.
Thanks for the fix.

In the meantime I've fixed the i386 problem.  A bit of silliness wrt 64-bit stores.


r~
