Received: from eggs.gnu.org ([2001:4830:134:3::10]:59122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9LwC-0003ze-4L
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9LiZ-0001f1-4E
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:56:28 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:46979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9LiS-0001cc-Fu
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 22:56:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id v5-v6so9342160plz.13
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 19:56:14 -0700 (PDT)
References: <20181006214508.5331-1-cota@braap.org>
	<20181006214508.5331-5-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4165f0c-f7f8-98f8-5c56-7fc52616cca8@linaro.org>
Date: Sun, 7 Oct 2018 19:56:10 -0700
MIME-Version: 1.0
In-Reply-To: <20181006214508.5331-5-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/6] tcg: define TCG_TARGET_TLB_MAX_INDEX_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/6/18 2:45 PM, Emilio G. Cota wrote:
> From: Pranith Kumar <bobby.prani@gmail.com>
> 
> This paves the way for implementing a dynamically-sized softmmu.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

There's no point in this, since the original constraint was due to encoding
immediates in the and instruction.  Now we're using tlb_mask.


r~
