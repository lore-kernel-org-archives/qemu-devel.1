Received: from eggs.gnu.org ([2001:4830:134:3::10]:41376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmQuu-0006Cv-TC
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 16:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dmQuu-0000oI-66
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 16:45:52 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170824155849.30799-1-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <14b3bf90-2c45-4c6b-3c26-9422eaeff88d@twiddle.net>
Date: Mon, 28 Aug 2017 13:45:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170824155849.30799-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 PATCH] tcg/softmmu: Increase size of TLB
 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

On 08/24/2017 08:58 AM, Pranith Kumar wrote:
> +#define CPU_TLB_BITS_MAX 12

Following up on our IRC conversation, host maximums are:

aarch64:	unlimited (32)
arm:		8 (patch exists to increase to 32 for armv7)
i386:		32 - CPU_TLB_ENTRY_BITS
ia64:		unlimited (32)
mips:		16 - CPU_TLB_ENTRY_BITS
ppc:		unlimited (32)
s390:		unlimited (32)
sparc:		12
tci:		unlimited (32)



r~
