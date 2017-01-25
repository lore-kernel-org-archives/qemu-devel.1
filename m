Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWWNz-0004WP-Hr
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWWNy-0002i4-Hf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:49:51 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWWNy-0002hr-CN
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 17:49:50 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 96so170373640uaq.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 14:49:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170125215637.2992-4-laurent@vivier.eu>
References: <20170125215637.2992-1-laurent@vivier.eu>
	<20170125215637.2992-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 22:49:29 +0000
Message-ID: <CAFEAcA_1RArYmVCCbxeqYzETBFzuJXWss-JSbos=W2uexO5w2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 3/3] linux-user: define correct UTS
 machine name for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 25 January 2017 at 21:56, Laurent Vivier <laurent@vivier.eu> wrote:
> the correct UTS machine name (as expected by systemd) is "parisc",
> not "hppa".
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/uname.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/linux-user/uname.c b/linux-user/uname.c
> index 313b79d..daad002 100644
> --- a/linux-user/uname.c
> +++ b/linux-user/uname.c
> @@ -63,6 +63,8 @@ const char *cpu_to_uname_machine(void *cpu_env)
>          return "i586";
>      }
>      return "i686";
> +#elif defined(TARGET_HPPA)
> +    return "parisc";
>  #else
>      /* default is #define-d in each arch/ subdir */
>      return UNAME_MACHINE;

This function is for when the uname string has to be
determined at runtime. If this target has a fixed
string, then you should just set UNAME_MACHINE correctly
in linux-user/$ARCH/target_syscall.h.

thanks
-- PMM
