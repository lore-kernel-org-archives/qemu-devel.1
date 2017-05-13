Received: from eggs.gnu.org ([2001:4830:134:3::10]:55688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KYW-0002EZ-72
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KYV-0003mI-GS
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:05:08 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-6-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <91950fdd-2041-c6b3-c0a3-3e66ea90eb20@twiddle.net>
Date: Fri, 12 May 2017 17:05:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170512233843.27713-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/6] target/ppc: optimize various
 functions using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 05/12/2017 04:38 PM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
> 
>      $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>          --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
> 
> Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> ---
>   target/ppc/translate.c              | 21 +++++++--------------
>   target/ppc/translate/vsx-impl.inc.c | 24 ++++++++----------------
>   2 files changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
