Received: from eggs.gnu.org ([2001:4830:134:3::10]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RBn-0001uX-9V
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8R0U-0000At-95
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:23:07 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8R0T-00009q-Tx
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:23:06 -0400
Received: by mail-oi1-x242.google.com with SMTP id v69-v6so10549303oif.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:23:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538748792-19444-1-git-send-email-thuth@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 15:22:44 +0100
Message-ID: <CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
> When compiling with "--disable-tcg", we currently still use "tcg"
> as default accelerator. "kvm" should be used in this case instead.

This part is non-controversial and makes good sense.

> Also, some downstream distros provide QEMU binaries which have "kvm"
> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
> KVM by default - and some users might want to do something similar
> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
> default when we detect such a binary name.

This part is much riskier and less clearly a good plan --
do we really want our behaviour to vary based on the name
of the executable? Distros who want that sort of qemu-kvm
wrapper generally are providing it already (the Ubuntu one
is a 2-line shell script).

thanks
-- PMM
