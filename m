Received: from eggs.gnu.org ([2001:4830:134:3::10]:36125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dt2xO-0002XZ-NO
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dt2xK-0008JP-HY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:35:46 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:51309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dt2xK-0008J8-Bd
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 22:35:42 -0400
Received: by mail-pg0-x234.google.com with SMTP id k193so2451933pgc.8
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 19:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20170916023417.14599-1-richard.henderson@linaro.org>
Message-ID: <b9d0cfa7-f5a4-3c96-8592-52ee380c381c@linaro.org>
Date: Fri, 15 Sep 2017 19:35:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170916023417.14599-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] TCG vectorization and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, f4bug@amsat.org

On 09/15/2017 07:34 PM, Richard Henderson wrote:
> Now addressing the complex vector op issue.  I now expose TCGv_vec
> to target front-ends, but opaque wrt the vector size.  One can thus
> compose vector operations, as demonstrated in target/arm/.
> 
> The actual host vector length now becomes an argument to the *_vec
> opcodes.  It's a little awkward, but does prevent an explosion of
> opcode values.
> 
> All R-b dropped because all patches rewritten or heavily modified.

Bah.  Forgot to mention that this depends on tcg-next.  Full tree at

  git://github.com/rth7680/qemu.git native-vector-registers-3


r~
