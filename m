Received: from eggs.gnu.org ([2001:4830:134:3::10]:45177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8gH-00040M-Pb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS8gC-0001Zx-00
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:14:52 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:36016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS8gB-0001YZ-RN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 17:14:47 -0400
Received: by mail-qk0-x22c.google.com with SMTP id p21so155311405qke.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 14:14:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170630143614.31059-1-bobby.prani@gmail.com>
	<20170630143614.31059-3-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a1aecc41-88ea-71c7-0243-b200aebbb6f7@twiddle.net>
Date: Mon, 3 Jul 2017 14:14:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170630143614.31059-3-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] tcg/aarch64: Enable indirect jump
 path using LDR (literal)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 06/30/2017 07:36 AM, Pranith Kumar wrote:
> This patch enables the indirect jump path using an LDR (literal)
> instruction. It will be interesting to test and see which performs
> better among the two paths.
> 
> CC: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Applied all to tcg-next.

Bonus points for converting USE_DIRECT_JUMP to a run-time flag, perhaps 
controllable by a -d bit.  That would further enable easy benchmarking of the 
two paths.


r~
