Received: from eggs.gnu.org ([2001:4830:134:3::10]:55590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii71-00023c-M9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cii70-0004Xh-TO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:43 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cii70-0004XH-Mx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:46:42 -0500
Received: by mail-wm0-x234.google.com with SMTP id v186so85870820wmd.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:46:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228025157.3499-1-tim@hentenaar.com>
References: <20170228025157.3499-1-tim@hentenaar.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 13:46:21 +0000
Message-ID: <CAFEAcA_wfRpNBEY14v_Sq+4s1Pp5kgah9Zdq_HMYACLnWNdW0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix fork() and vfork()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim Hentenaar <tim@hentenaar.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 28 February 2017 at 02:51, Tim Hentenaar <tim@hentenaar.com> wrote:
> A check was introduced in 5ea2fc84da1bffce749c9d0848f5336def2818bb which
> causes fork() and vfork() to fail if TARGET_SIGCHLD != SIGCHLD.
>
> Signed-off-by: Tim Hentenaar <tim@hentenaar.com>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for this patch. In fact the equivalent bugfix has just
hit QEMU git master, as commit 7eddb5ddacb783ba.

thanks
-- PMM
