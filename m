Received: from eggs.gnu.org ([209.51.188.92]:41660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go7nE-0003du-86
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go7nD-0001bT-Hy
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:21:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1go7nC-0001Z1-FT
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:21:42 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-43-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <993cfb1a-7651-0afc-3b48-5c47c429e422@redhat.com>
Date: Mon, 28 Jan 2019 15:21:36 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-43-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 42/52] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 2019-01-25 11:07, Paolo Bonzini wrote:
> This way, the default-configs file only need to specify the boards
> and any optional devices.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-37-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index ff41be3..8814b7c 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -5,20 +5,73 @@ config SEV
>  config PC
>      bool
>  
> +config PC
> +    bool
> +    select ISA_DEBUG
> +    select I8259
> +    select I8254
> +    select PCSPK
> +    select I82374
> +    select I8257
> +    select MC146818RTC

You've duplicated the "config PC" line here. The "select"s should be
added to the previous "config PC" section instead.

 Thomas
