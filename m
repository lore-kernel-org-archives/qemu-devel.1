Received: from eggs.gnu.org ([2001:4830:134:3::10]:33477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZDJ-0006Ar-Ov
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZDJ-0002vf-5O
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:10:53 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZDH-0002h3-3k
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:10:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id p2-v6so20139304wmc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:10:35 -0800 (PST)
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
	<20181116011338.GB17566@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97154616-dbef-a407-2e52-e09b21f3a0eb@linaro.org>
Date: Fri, 16 Nov 2018 09:10:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181116011338.GB17566@flamenco>
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

On 11/16/18 2:13 AM, Emilio G. Cota wrote:
> This allows us to discard most TBs; in the example above,
> we end up *not* discarding only ~70 TBs, that is we end up keeping
> only 70/2500 = 2.8% of the TBs that we'd discard without OOL.

Thanks.

When I apply this I think I'll rename "n_ool_thunks" to "ool_generation".  We
don't care about the absolute count, but any change.


r~
