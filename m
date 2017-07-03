Received: from eggs.gnu.org ([2001:4830:134:3::10]:55697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7YE-0007VC-G0
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7YB-0000Bl-Hw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:02:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7YB-0000Bc-Db
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:02:27 -0400
Received: by mail-qk0-x243.google.com with SMTP id p21so25280216qke.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:02:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-10-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <053ee8fc-be9a-e37b-b31c-b0964140cb17@twiddle.net>
Date: Mon, 3 Jul 2017 13:02:22 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-10-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/22] monitor: disable "info jit" and
 "info opcount" if !TCG
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
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/translate-all.c | 5 +++++
>   hmp-commands-info.hx      | 4 ++++
>   monitor.c                 | 2 ++
>   3 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
