Received: from eggs.gnu.org ([2001:4830:134:3::10]:57261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCheP-0002pz-Lk
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCheN-0000mv-3R
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:53:25 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:45343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCheM-0000mZ-Sn
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 02:53:23 -0500
Received: by mail-wm0-x244.google.com with SMTP id y80so15020652wmd.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 23:53:22 -0800 (PST)
References: <e457d4e906dceea4de6c3431813a06b137c1ab9c.1510103351.git.alistair.francis@xilinx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <578b7749-0b37-0606-4ed0-810deb44f61d@linaro.org>
Date: Thu, 9 Nov 2017 08:53:19 +0100
MIME-Version: 1.0
In-Reply-To: <e457d4e906dceea4de6c3431813a06b137c1ab9c.1510103351.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] Makefile: Capstone: Add support for
 cross compile ranlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair23@gmail.com, kraxel@redhat.com, dgilbert@redhat.com

On 11/08/2017 02:10 AM, Alistair Francis wrote:
> When cross compiling QEMU for Windows we need to specify the cross
> version of ranlib to avoid build errors when buildling capstone. This
> patch ensures we use the same cross prefix on ranlib as other toolchain
> components.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Thanks.  Queued for pull with another outstanding capstone patch.


r~
