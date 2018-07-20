Received: from eggs.gnu.org ([2001:4830:134:3::10]:48191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fgLGy-00067T-Rh
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fgLGy-0008NA-67
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:36:00 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:46408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fgLGy-0008Mz-0g
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 22:36:00 -0400
Received: by mail-yb0-x241.google.com with SMTP id c3-v6so4083231ybi.13
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 19:35:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532005320-17794-1-git-send-email-thuth@redhat.com>
References: <1532005320-17794-1-git-send-email-thuth@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 19 Jul 2018 19:35:58 -0700
Message-ID: <CAMo8BfLgt54gxqtDpzb_n2j8DGc8hFUOmZG-QMjW==9j=-3YTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa/cpu: Set owner of memory
 region in xtensa_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jul 19, 2018 at 6:02 AM, Thomas Huth <thuth@redhat.com> wrote:
> The instance_init function of the xtensa CPUs creates a memory region,
> but does not set an owner, so the memory region is not destroyed
> correctly when the CPU object is removed. This can happen when
> introspecting the CPU devices, so introspecting the CPU device will
> leave a dangling memory region object in the QOM tree. Make sure to
> set the right owner here to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/xtensa/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
