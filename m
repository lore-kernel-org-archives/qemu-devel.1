Received: from eggs.gnu.org ([2001:4830:134:3::10]:47627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7JO-00018Q-QW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7JK-0004Pe-7b
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:47:10 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7JK-0004PV-3a
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:47:06 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so25228126qke.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:47:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-6-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ab32a653-4206-f0b7-449b-f318f60ec498@twiddle.net>
Date: Mon, 3 Jul 2017 12:46:56 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-6-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/22] vl: add tcg_enabled() for tcg
 related code
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
> Need to disable the tcg related code in the vl.c if the
> disable-tcg option is added into ./configure command.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   vl.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
