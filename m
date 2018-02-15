Received: from eggs.gnu.org ([2001:4830:134:3::10]:48134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJmn-0001BA-47
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJmh-0000mH-8m
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:41:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:51279)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJmg-0000ld-Uf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:41:11 -0500
References: <20180124211301.10095-1-laurent@vivier.eu>
	<20180124211301.10095-3-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e8926d7e-2f28-9707-456a-eb1cfcdfabef@vivier.eu>
Date: Thu, 15 Feb 2018 14:40:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180124211301.10095-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] linux-user: introduce functions to
 detect CPU type
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

Le 24/01/2018 à 22:12, Laurent Vivier a écrit :
> From: YunQiang Su <syq@debian.org>
> 
> Add a function to return ELF e_flags and use it
> to select the CPU model.
> 
> Signed-off-by: YunQiang Su <syq@debian.org>
> [lv: split the patch and some cleanup in get_elf_eflags()]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 35 +++++++++++++++++++++++++++++++++++
>  linux-user/main.c    | 20 ++++++++++----------
>  linux-user/qemu.h    |  1 +
>  3 files changed, 46 insertions(+), 10 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
