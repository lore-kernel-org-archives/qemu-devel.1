Received: from eggs.gnu.org ([2001:4830:134:3::10]:48865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJos-0002ob-2k
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJoo-00023y-W0
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:43:26 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJoo-00023T-MS
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:43:22 -0500
References: <20180124211301.10095-1-laurent@vivier.eu>
	<20180124211301.10095-5-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a16cbdb0-ecd2-3375-fb58-e6d63a117e8a@vivier.eu>
Date: Thu, 15 Feb 2018 14:43:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180124211301.10095-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/4] linux-user: MIPS set cpu to r6 CPU
 if binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Aaron Sierra <asierra@xes-inc.com>

Le 24/01/2018 à 22:13, Laurent Vivier a écrit :
> From: YunQiang Su <syq@debian.org>
> 
> So here we need to detect the version of binaries and set
> cpu_model for it.
> 
> Signed-off-by: YunQiang Su <syq@debian.org>
> [lv: original patch modified to move code into cpu_get_model()]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h                  | 4 ++++
>  linux-user/mips/target_elf.h   | 3 +++
>  linux-user/mips64/target_elf.h | 3 +++
>  3 files changed, 10 insertions(+)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
