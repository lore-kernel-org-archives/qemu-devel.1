Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhrh-0001vb-P1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhre-0005PV-LM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:06:21 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:40041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhre-0005Oc-GK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 21:06:18 -0400
Received: by mail-qk0-x241.google.com with SMTP id b129-v6so4097898qke.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 18:06:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd70d707-c0a1-744f-d559-143ec44d2831@amsat.org>
Date: Thu, 28 Jun 2018 22:06:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] target/arm SVE updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/28/2018 09:15 PM, Richard Henderson wrote:
> Patch 1 fixes the SIGFPE that Alex found with --test-sve=3.
> Patch 2 fixes a problem pointed out by Laurent, presumably
> via inspection.
>   
> The rest begin enabling cpu features for -cpu max.
> I'm still working on SVE itself, but these are standalone
> and perhaps worth merging before softfreeze.

I realized once reviewed the last patch, that this series is
Based-on: 20180627043328.11531-1-richard.henderson@linaro.org
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg07698.html

Also probably meaning no-reply@patchew.org is laggy/dead.

> Richard Henderson (6):
>   target/arm: Fix SVE signed division vs x86 overflow exception
>   target/arm: Fix SVE system register access checks
>   target/arm: Prune a57 features from max
>   target/arm: Prune a15 features from max
>   target/arm: Add ID_ISAR6
>   target/arm: Set ISAR bits for -cpu max
> 
>  target/arm/cpu.h           |  1 +
>  target/arm/cpu.c           | 31 +++++++++++++++++--------
>  target/arm/cpu64.c         | 47 ++++++++++++++++++++++++--------------
>  target/arm/helper.c        | 13 +++++------
>  target/arm/sve_helper.c    | 16 +++++++++----
>  target/arm/translate-a64.c |  5 ++--
>  6 files changed, 71 insertions(+), 42 deletions(-)
> 
