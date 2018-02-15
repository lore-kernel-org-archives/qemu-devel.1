Received: from eggs.gnu.org ([2001:4830:134:3::10]:42903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJZJ-0006NS-1g
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJZI-0008Ox-31
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:27:21 -0500
References: <671eaa99f4e0bf3a58f76f9151f7cfa24662227f.1517565566.git.agx@sigxcpu.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <548deb35-8970-8dae-2baa-7e60c610ae4b@vivier.eu>
Date: Thu, 15 Feb 2018 14:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <671eaa99f4e0bf3a58f76f9151f7cfa24662227f.1517565566.git.agx@sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Fix register used for 6th
 and 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Le 02/02/2018 à 11:02, Guido Günther a écrit :
> This unbreaks the testcase from
> 
>     http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html
> 
> Thanks to Laurent Vivier for spotting the 7th one.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3 collects *-by: replies. Anything else I can do to get this applied?
> 
>  linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
