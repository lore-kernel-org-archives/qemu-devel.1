Received: from eggs.gnu.org ([2001:4830:134:3::10]:53022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Uo-0003xR-B8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Uk-00067G-Hf
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:58:58 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7Uk-000679-CO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:58:54 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so25240196qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:58:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-7-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fd8fa49d-bc63-51f5-916c-dbc1c6f0171a@twiddle.net>
Date: Mon, 3 Jul 2017 12:58:48 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-7-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/22] tcg: move page_size_init() function
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
> From: Yang Zhong<yang.zhong@intel.com>
> 
> translate-all.c will be disabled if tcg is disabled in the build,
> so page_size_init() function and related variables will be moved
> to exec.c file.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/translate-all.c | 18 ------------------
>   exec.c                    | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
