Received: from eggs.gnu.org ([2001:4830:134:3::10]:48116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAJA-0003jU-PJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fOAJ5-0003x7-OI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:08 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fOAJ5-0003wz-HP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:15:03 -0400
Received: by mail-pl0-x241.google.com with SMTP id v24-v6so11995955plo.3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:15:03 -0700 (PDT)
Date: Thu, 31 May 2018 08:15:00 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180530231500.GV3652@lianli.shorne-pla.net>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180527141324.11937-5-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 04/20] target/openrisc: Link more
 translation blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Sun, May 27, 2018 at 09:13:08AM -0500, Richard Henderson wrote:
> Track direct jumps via dc->jmp_pc_imm.  Use that in
> preference to jmp_pc when possible.  Emit goto_tb in
> that case, and lookup_and_goto_tb otherwise.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>
