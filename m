Received: from eggs.gnu.org ([2001:4830:134:3::10]:48480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJo4-0002Br-Ex
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emJny-0001U6-So
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:42:36 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emJny-0001Ru-Iw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:42:30 -0500
References: <20180124211301.10095-1-laurent@vivier.eu>
	<20180124211301.10095-4-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <78a47a0c-5b0f-b6fc-be6b-f6b8a8cab362@vivier.eu>
Date: Thu, 15 Feb 2018 14:42:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180124211301.10095-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-user,
 m68k: select CPU according to ELF header values
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
> M680x0 doesn't support the same set of instructions
> as ColdFire, so we can't use "any" CPU type to execute
> m68020 instructions.
> We select CPU type ("m68040" or "any" for ColdFire)
> according to the ELF header. If we can't, we
> use by default the value used until now: "any".
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h                | 28 ++++++++++++++++++++++++++++
>  linux-user/m68k/target_elf.h |  6 ++++++
>  2 files changed, 34 insertions(+)

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent
