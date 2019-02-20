Received: from eggs.gnu.org ([209.51.188.92]:36141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gwVA7-0003dB-Uc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gwVA5-0004mB-TF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:55:59 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gwV9r-0004ZE-Cw
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:55:46 -0500
Received: by mail-yw1-xc44.google.com with SMTP id u205so9481810ywe.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:55:39 -0800 (PST)
MIME-Version: 1.0
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-6-git-send-email-pbonzini@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 20 Feb 2019 08:55:27 -0800
Message-ID: <CAMo8BfJW6xg=K1Z+3K_Gckx=P5Vrbve2+rR52DygajoF5TJtnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/51] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Thu, Feb 7, 2019 at 10:05 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
> new file mode 100644
> index 0000000..97543a9
> --- /dev/null
> +++ b/hw/xtensa/Kconfig
> @@ -0,0 +1,5 @@
> +config XTENSA_SIM
> +    bool
> +
> +config XTENSA_FPGA

Can it please be called XTENSA_XTFPGA, as the corresponding
source file and as it's called in other places (e.g. in linux)?

-- 
Thanks.
-- Max
