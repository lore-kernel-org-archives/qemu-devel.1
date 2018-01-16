Received: from eggs.gnu.org ([2001:4830:134:3::10]:33357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXaA-00021H-4F
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:11:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebXa6-0001Tn-Vj
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:11:42 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebXa6-0001TY-On
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:11:38 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so7003539pll.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:11:38 -0800 (PST)
References: <20180116172510.28878-1-laurent@vivier.eu>
	<20180116172510.28878-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61a713d7-3cc1-7a29-2997-d1b513a5ae79@linaro.org>
Date: Tue, 16 Jan 2018 12:11:34 -0800
MIME-Version: 1.0
In-Reply-To: <20180116172510.28878-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] linux-user: introduce functions to
 detect CPU type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: YunQiang Su <syq@debian.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Aaron Sierra <asierra@xes-inc.com>

On 01/16/2018 09:25 AM, Laurent Vivier wrote:
> From: YunQiang Su <syq@debian.org>
> 
> Add a function to return ELF e_flags and use it
> to select the CPU model.
> 
> [lv: split the patch and some cleanup in get_elf_eflags()]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     YunQiang Su, please add your Signed-off-by that was
>     missing in your original patch.
>     
>     v2: call cpu_get_model() with the result of get_elf_eflags()
> 
>  linux-user/elfload.c | 35 +++++++++++++++++++++++++++++++++++
>  linux-user/main.c    | 20 ++++++++++----------
>  linux-user/qemu.h    |  1 +
>  3 files changed, 46 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
