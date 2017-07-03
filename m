Received: from eggs.gnu.org ([2001:4830:134:3::10]:56063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7ZP-0000Ng-Vy
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7ZM-0000fl-1N
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:43 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7ZL-0000fU-Sr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id 91so25254950qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:03:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-12-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5c6e3f01-c7ad-f83a-03f2-ad602880937c@twiddle.net>
Date: Mon, 3 Jul 2017 13:03:34 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-12-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/22] tcg: add the tcg-stub.c file into
 accel/stubs/
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
> If tcg is disabled, the functions in tcg-stub.c file will be called.
> This file is target-independent file, do not include any platform
> related stub functions into this file.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/stubs/Makefile.objs |  1 +
>   accel/stubs/tcg-stub.c    | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
>   create mode 100644 accel/stubs/tcg-stub.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
