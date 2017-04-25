Received: from eggs.gnu.org ([2001:4830:134:3::10]:40482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d322S-0004ac-5C
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d322M-0000lB-4U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:06:00 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:34723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d322L-0000ka-Qw
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:05:53 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r190so15118277wme.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:05:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <726c98c5-7e63-417a-ea48-ae2737d50cdc@redhat.com>
References: <20170425104116.31435-1-dgilbert@redhat.com>
	<CAFEAcA8yQXV3414cv72Nq7HVoXTgjR40HQWGFzK_+T_=h_Bykw@mail.gmail.com>
	<726c98c5-7e63-417a-ea48-ae2737d50cdc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 16:05:31 +0100
Message-ID: <CAFEAcA_y+HBkFxs5bFavptvB96AfL3F+A33fyuaWc+-Cd3QuOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 25 April 2017 at 15:07, Thomas Huth <thuth@redhat.com> wrote:
> So another idea: Could you start the test in verbose mode like this:
>
> V=2 QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 tests/test-hmp

manooth$ V=2 QTEST_QEMU_BINARY='aarch64-softmmu/qemu-system-aarch64'
tests/test-hmp
/aarch64/hmp/n810:      info balloon
        info block
        info block-jobs
        info blockstats
        info capture
        info chardev
        info cpus
        info cpustats
        info dump
        info history
        info hotpluggable-cpus
        info iothreads
        info irq
        info jit
qemu: qemu_mutex_lock: Invalid argument
Broken pipe

thanks
-- PMM
