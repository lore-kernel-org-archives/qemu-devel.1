Received: from eggs.gnu.org ([2001:4830:134:3::10]:44277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5pkd-0007jT-MN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1f5pkc-00082e-QR
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:39:43 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:39613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1f5pkc-00082N-LT
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:39:42 -0400
Received: by mail-io0-x22c.google.com with SMTP id v13so12950903iob.6
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 02:39:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180409091320.12504.35329.stgit@pasha-VirtualBox>
	<3c1eeffa-6fbb-1edf-296a-6bc7fabab26d@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c1a3f28f-9df7-6e50-123e-966a2a485922@twiddle.net>
Date: Tue, 10 Apr 2018 19:39:31 +1000
MIME-Version: 1.0
In-Reply-To: <3c1eeffa-6fbb-1edf-296a-6bc7fabab26d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] icount: fix cpu_restore_state_from_tb for
 non-tb-exit cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, crosthwaite.peter@gmail.com, kbastian@mail.uni-paderborn.de, green@moxielogic.com, laurent@vivier.eu, jcmvbkbc@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, edgar.iglesias@gmail.com, shorne@gmail.com, yongbok.kim@mips.com, aurelien@aurel32.net

On 04/10/2018 05:35 PM, Paolo Bonzini wrote:
> This is incorrect, "cpu->can_do_io" is 1 when not in tcg_qemu_tb_exec.
> In fact, in cpu_exec we have "cpu->can_do_io = 1;" immediately after
> siglongjmp, so I propose adding the same "cpu->can_do_io = 1;"
> assignment to cpu_exec_step_atomic.

Ooo, good catch.  I agree.

> In any case, please change the two siglongjmp of
> cpu_loop_exit_{noexc,restore} to cpu_loop_exit, instead of duplicating
> that cpu->can_do_io assignment.

I've made that change too.  I'll post a v2 shortly.


r~
