Received: from eggs.gnu.org ([2001:4830:134:3::10]:50317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3100-0004Ac-RD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d30zx-000063-RA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:59:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d30zx-00005k-KG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:59:21 -0400
Date: Tue, 25 Apr 2017 14:59:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170425135915.GF2103@work-vm>
References: <20170425104116.31435-1-dgilbert@redhat.com>
	<CAFEAcA8yQXV3414cv72Nq7HVoXTgjR40HQWGFzK_+T_=h_Bykw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yQXV3414cv72Nq7HVoXTgjR40HQWGFzK_+T_=h_Bykw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 25 April 2017 at 11:41, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit f4b5b021c847669b1c78050aea26fe9abceef6dd:
> >
> >   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-04-25 09:21:54 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dagrh/qemu.git tags/pull-hmp-20170425
> >
> > for you to fetch changes up to 1eb8e78dd1cd4e0b4170fd42f6d8882c867f334b:
> >
> >   tests: Add a tester for HMP commands (2017-04-25 11:26:52 +0100)
> >
> > ----------------------------------------------------------------
> > HMP pull with fixed test/strcmp case
> >
> > ----------------------------------------------------------------
> 
> test-hmp fails for me on OSX hosts:
> 
> TEST: tests/test-hmp... (pid=6008)
>   /aarch64/hmp/n810:
> qemu: qemu_mutex_lock: Invalid argument
> Broken pipe
> FAIL
> GTester: last random seed: R02Sd714920da46f8a0e37afec762c6ee23b
> (pid=6013)
>   /aarch64/hmp/tosa:
> qemu: qemu_mutex_lock: Invalid argument
> Broken pipe
> FAIL
> GTester: last random seed: R02Sf3025925b9db75bdfdd9f09cf3119ad5
> etc etc.
> 
> Can't do a backtrace, I'm afraid -- Apple's debugger doesn't seem
> to work if you're not root and the lack of X11 forwarding on the
> box I'm using remotely interacts really badly with qtest's
> desire to run qemu as a background process that it's hard to
> attach a debugger to. Something's probably not initializing
> a mutex, though -- Linux by default treats zeroes as a valid
> initialized mutex so it won't notice. You may be able to repro
> on Linux by using the Linux PTHREAD_MUTEX_ERRORCHECK_NP
> mutex attr, possibly.

Hmm,  does running with QTEST_LOG=1  get you any more detail?

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
