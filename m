Received: from eggs.gnu.org ([209.51.188.92]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3MMP-0004j8-GM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3MLQ-0001T1-Hj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:56:01 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3MLQ-0001SM-2s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:56:00 -0400
Received: by mail-oi1-x22c.google.com with SMTP id b4so3856588oif.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9=oUk_W+pqYLkd=oBC7eENU1yYKbGzoOzgxXoOmg7_+A@mail.gmail.com>
	<85304416-5bd3-c957-b2c3-dd8e7c1aa071@redhat.com>
In-Reply-To: <85304416-5bd3-c957-b2c3-dd8e7c1aa071@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 14:55:47 +0000
Message-ID: <CAFEAcA8vdJyNa7KEAv5sOJDQUu_9x0pyXvixw4nT0Yq1KVosmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Mar 2019 at 14:54, Auger Eric <eric.auger@redhat.com> wrote:
> yes I hit the bug with your reduced command line:
>
> aarch64-softmmu/qemu-system-aarch64 -M virt,gic-version=host -cpu host
> -smp 2 -m 4G -display none --enable-kvm  -serial stdio -bios
> ~/VM/UEFI/QEMU_EFI_cbuild_debug_feb21_2019.fd

OK, that's good to know. What hardware are you using, and what host
kernel version ?

thanks
-- PMM
