Received: from eggs.gnu.org ([2001:4830:134:3::10]:48403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDQhE-0000Xn-SN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDQhA-0007wE-VC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:03:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDQh5-0007jG-5K
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:03:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id u197-v6so26243095oif.5
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 02:03:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539894735-14232-7-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-7-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 10:03:18 +0100
Message-ID: <CAFEAcA9HgX84HT68PxCc3b_HhrqiEowe2zh8NOHYW-M1g-dq8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 06/48] target-i386: kvm: do not initialize
 padding fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 October 2018 at 21:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The exception.pad field is going to be renamed to pending in an upcoming
> header file update.  Remove the unnecessary initialization; it was
> introduced to please valgrind (commit 7e680753cfa2) but they were later
> rendered unnecessary by commit 076796f8fd27f4d, which added the "= {}"
> initializer to the declaration of "events".  Therefore the patch does
> not change behavior in any way.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
