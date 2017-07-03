Received: from eggs.gnu.org ([2001:4830:134:3::10]:57768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7fe-0006J1-Tr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7fe-0004iK-0W
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:10:10 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7fd-0004hX-Sj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:10:09 -0400
Received: by mail-qt0-x244.google.com with SMTP id v31so24772931qtb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:10:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-15-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <96ae487f-40a9-f5b3-888f-955395a0210a@twiddle.net>
Date: Mon, 3 Jul 2017 13:10:04 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-15-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/22] tcg: add CONFIG_TCG guards in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> --- a/include/exec/helper-proto.h
> +++ b/include/exec/helper-proto.h
> @@ -28,7 +28,9 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
>   
>   #include "helper.h"
>   #include "trace/generated-helpers.h"
> +#ifdef CONFIG_TCG
>   #include "tcg-runtime.h"
> +#endif

Do we really want to define any of the helpers if !CONFIG_TCG?
Perhaps it's the user of this header that needs adjustment.


r~
