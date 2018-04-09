Received: from eggs.gnu.org ([2001:4830:134:3::10]:56424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XMu-0006av-8e
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f5XMp-00084c-0G
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 10:02:00 -0400
References: <1523038800-2494-1-git-send-email-cota@braap.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <cbad2760-7a64-7602-5734-eea0747c620f@mail.uni-paderborn.de>
Date: Mon, 9 Apr 2018 16:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/17] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc/riscv targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Michael Clark <mjc@sifive.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Emilio,

On 04/06/2018 08:19 PM, Emilio G. Cota wrote:
> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00445.html
> 
> Changes since v1:
> 
> - Rebase onto master
> 
> - Add R-b's
> 
> - Add riscv conversion

Thanks for doing this grunt work. Me and a colleague were planning to do
this as well after converting the RISC-V frontend to decodetree. Do you
have any plans to do this for the TriCore frontend as well? I have the
same plan for Tricore: Convert it to decodetree, then to translation loop.

Cheers,
Bastian
