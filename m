Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cimF2-0005hQ-OV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cimEy-0005WR-PQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:11:16 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cimEy-0005W9-Hv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:11:12 -0500
Received: by mail-pf0-x242.google.com with SMTP id x66so1619890pfb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 10:11:12 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170228150709.27453-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <de20cf86-de8b-3f61-6e2a-7ce52ead8098@twiddle.net>
Date: Wed, 1 Mar 2017 05:11:04 +1100
MIME-Version: 1.0
In-Reply-To: <20170228150709.27453-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] MTTCG start-up tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

On 03/01/2017 02:07 AM, Alex Bennée wrote:
> Hi,
>
> These are a couple of quick tweaks to command line handling for MTTCG.
> The first patch moves the paring of --accel tcg to after icount and
> simplifies the logic to disable mttcg when icount is enabled. There is
> still a regression to icount to be fixed (caused by 8d04fb5).
>
> Finally there is a patch to declare the TCG_GUEST_DEFAULT_MO for x86
> guests to avoid the bogus warning about memory order when forcing
> mttcg on. A new warning has been added specifically for guests that
> haven't declared TARGET_SUPPORT_MTTCG which means the front-end has
> had atomics/barrier/helpers converted for a MTTCG world.
>
> Alex Bennée (3):
>   vl/cpus: be smarter with icount and MTTCG
>   target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
>   cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
>
>  cpus.c            | 11 +++++++----
>  target/i386/cpu.h |  3 +++
>  vl.c              |  7 ++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)
>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
