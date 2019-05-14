Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE947C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72826208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72826208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQSRZ-0005aK-Kr
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 04:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQSQe-0005CJ-DV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hQSQU-0003x0-Ij
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:04:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hQSQO-0003YI-LA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:04:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so214148wrt.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 01:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=175bFGqXidd+JupTDw6wW1LePXaJhZUTvdARL4yJcEs=;
	b=KqmUE3Wb5Fxc4nTJYTrP8qg0o20CDKvusdfKToSQORSt7B+cnm0jbV8nA7KFOr7zDb
	lgAqfRQs3o2iOuwLBDl/pTGDEfx5xxYye5A82kb9D4WriitKDIwGlqakWf46DMjzdIKm
	KH3ta4StIUIW8K6qJ3NAf9EH1wlxtPGXe4tZXoLC/XWt/i3ovT78QbHnVgkJv83gUQMH
	aKFDPJGSw2bNX9VowBg6cgorBMCVaTi+U76BT0COUw3mBBLu2r8luEwyXMJnnPinUd1B
	VMDrsIwvv0BjkYaY30FL6e22PR2bkCndfW8g/UwVH5jPvCODXarStqhcFM6NzCqG1bwQ
	WQ1w==
X-Gm-Message-State: APjAAAVSJZFZvCwyiL5I06lw4CX9UhkYeYjbqr1zyF9RDC0639WuSVbO
	3d/KLaS/tF9aZNfG8HHdyQifDA==
X-Google-Smtp-Source: APXvYqxK71aFqlPdhRT3zwi6FuphE0QX4B4W2r01Fq9InchnIMEgC55XAAgmdyrf2wLihSDMl8QPAg==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr13204378wra.278.1557821057573; 
	Tue, 14 May 2019 01:04:17 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	b10sm29442313wrh.59.2019.05.14.01.04.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 14 May 2019 01:04:17 -0700 (PDT)
Date: Tue, 14 May 2019 10:04:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bug 1826393 <1826393@bugs.launchpad.net>
Message-ID: <20190514080414.ecsz7u5o2dozs27w@steredhat>
References: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
	<155678383044.13902.634296520708639219.malone@wampee.canonical.com>
	<CAL9cFfOxjfmhx+E6Z8ha4ySk+o+dg6nHdY8KdHzbm6ttehBL0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL9cFfOxjfmhx+E6Z8ha4ySk+o+dg6nHdY8KdHzbm6ttehBL0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [Bug 1826393] Re: QEMU 3.1.0 stuck waiting for
 800ms (5 times slower) in pre-bios phase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 05:40:05PM -0000, Waldemar Kozaczuk wrote:
> The last bios indeed helped. It knows runs under 200ms.
> 
> Do you anticipate doing minor release of 3.1.0 with updated bios to address
> this issue? Or users are expected to upgrade to QEMU 4.0.0?

CCing Gerd

I'm not sure we will release SeaBIOS 1.12.1 with a minor release of QEMU
3.1.0, so upgrading to QEMU 4.0 should be the way to address this issue.

Regards,
Stefano

> 
> Regards,
> Waldek
> 
> On Thu, May 2, 2019 at 4:05 AM Stefano Garzarella <
> 1826393@bugs.launchpad.net> wrote:
> 
> > Oh sorry, you're using the 'pc' machine, so please try this bios:
> > https://github.com/qemu/qemu/blob/v4.0.0/pc-bios/bios.bin
> >
> > --
> > You received this bug notification because you are subscribed to the bug
> > report.
> > https://bugs.launchpad.net/bugs/1826393
> >
> > Title:
> >   QEMU 3.1.0 stuck waiting for 800ms (5 times slower) in pre-bios phase
> >
> > Status in QEMU:
> >   New
> >
> > Bug description:
> >   Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and
> >   that way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have
> >   noticed that everytime I start QEMU to run OSv, QEMU seems to hand
> >   noticably longer (~1 second) before showing SeaBIOS output. I have
> >   tried all kind of combinations to get rid of that pause and nothing
> >   helped.
> >
> >   Here is my start command:
> >   time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
> >    -device virtio-blk-pci,id=blk0,bootindex=0,drive=hd0,scsi=off \
> >    -drive file=usr.img,if=none,id=hd0,cache=none,aio=thre\
> >    -enable-kvm \
> >    -cpu host,+x2apic -chardev stdio,mux=on,id=stdio,signal=off \
> >    -mon chardev=stdio,mode=readline -device isa-serial,chardev=stdio
> >
> >   It looks like qemu process starts, waits almost a second for something
> >   and then print SeaBIOS splashscreen and continues boot:
> >
> >   --> waits here
> >   SeaBIOS (version 1.12.0-1)
> >   Booting from Hard Disk..OSv v0.53.0-6-gc8395118
> >         disk read (real mode): 27.25ms, (+27.25ms)
> >         uncompress lzloader.elf: 46.22ms, (+18.97ms)
> >         TLS initialization: 46.79ms, (+0.57ms)
> >         .init functions: 47.82ms, (+1.03ms)
> >         SMP launched: 48.08ms, (+0.26ms)
> >         VFS initialized: 49.25ms, (+1.17ms)
> >         Network initialized: 49.48ms, (+0.24ms)
> >         pvpanic done: 49.57ms, (+0.08ms)
> >         pci enumerated: 52.42ms, (+2.85ms)
> >         drivers probe: 52.42ms, (+0.00ms)
> >         drivers loaded: 55.33ms, (+2.90ms)
> >         ROFS mounted: 56.37ms, (+1.04ms)
> >         Total time: 56.37ms, (+0.00ms)
> >   Found optarg
> >   dev  etc  hello  libenviron.so        libvdso.so  proc  tmp  tools  usr
> >
> >   real  0m0.935s
> >   user  0m0.426s
> >   sys   0m0.490s
> >
> >   With version 2.12.0 I used to see real below 200ms. So it seems qemu
> >   slowed down 5 times.
> >
> >   I ran strace -tt against it and I have noticed a pause here:
> >   ...
> >   07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
> >   07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) = 0
> >   07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) = 0
> >   07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) = 1
> >   07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) = 0
> >   07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) = 1
> >   07:31:41.848747 getpid()                = 5162
> >   07:31:41.848769 tgkill(5162, 5166, SIGUSR1) = 0
> >   07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
> >   07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) = 1
> >   07:31:41.848837 getpid()                = 5162
> >   07:31:41.848858 tgkill(5162, 5166, SIGUSR1) = 0
> >   07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) = 8
> >   07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
> >   07:31:41.848943 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN},
> > {fd=5, events=POLLIN}, {fd=7, events=POLLIN},
> >   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=0}, NULL, 8) = 1 ([{fd=8,
> > revents=POLLIN}], left {tv_sec=0, tv_nsec=0
> >   })
> >   07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = -1
> > EAGAIN (Resource temporarily unavailable)
> >   07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) = 8
> >   07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
> >   07:31:41.849086 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN},
> > {fd=5, events=POLLIN}, {fd=7, events=POLLIN},
> >   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=984624000}, NULL, 8) = 1
> > ([{fd=7, revents=POLLIN}], left {tv_sec=0, t
> >   v_nsec=190532609})
> >
> >   --> waits for almost 800ms
> >
> >   07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = 0
> >   07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) = 8
> >   07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
> >   07:31:42.643646 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN},
> > {fd=5, events=POLLIN}, {fd=7, events=POLLIN},
> >   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=190066000}, NULL, 8) = 2
> > ([{fd=4, revents=POLLIN}, {fd=8, revents=POL
> >   LIN}], left {tv_sec=0, tv_nsec=189909632})
> >   07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = -1
> > EAGAIN (Resource temporarily unavailable)
> >   07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) = 8
> >   07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
> >
> >   ...
> >
> >   when I run same command using qemu 3.0.5 that I still happen to have
> >   on the same machine that I built directly from source I see total boot
> >   time at around 200ms. It seems like a regression.
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1826393/+subscriptions
> >
> 
> -- 
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1826393
> 
> Title:
>   QEMU 3.1.0 stuck waiting for 800ms (5 times slower) in pre-bios phase
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and
>   that way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have
>   noticed that everytime I start QEMU to run OSv, QEMU seems to hand
>   noticably longer (~1 second) before showing SeaBIOS output. I have
>   tried all kind of combinations to get rid of that pause and nothing
>   helped.
> 
>   Here is my start command:
>   time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
>    -device virtio-blk-pci,id=blk0,bootindex=0,drive=hd0,scsi=off \
>    -drive file=usr.img,if=none,id=hd0,cache=none,aio=thre\
>    -enable-kvm \
>    -cpu host,+x2apic -chardev stdio,mux=on,id=stdio,signal=off \
>    -mon chardev=stdio,mode=readline -device isa-serial,chardev=stdio
> 
>   It looks like qemu process starts, waits almost a second for something
>   and then print SeaBIOS splashscreen and continues boot:
> 
>   --> waits here
>   SeaBIOS (version 1.12.0-1)
>   Booting from Hard Disk..OSv v0.53.0-6-gc8395118
>   	disk read (real mode): 27.25ms, (+27.25ms)
>   	uncompress lzloader.elf: 46.22ms, (+18.97ms)
>   	TLS initialization: 46.79ms, (+0.57ms)
>   	.init functions: 47.82ms, (+1.03ms)
>   	SMP launched: 48.08ms, (+0.26ms)
>   	VFS initialized: 49.25ms, (+1.17ms)
>   	Network initialized: 49.48ms, (+0.24ms)
>   	pvpanic done: 49.57ms, (+0.08ms)
>   	pci enumerated: 52.42ms, (+2.85ms)
>   	drivers probe: 52.42ms, (+0.00ms)
>   	drivers loaded: 55.33ms, (+2.90ms)
>   	ROFS mounted: 56.37ms, (+1.04ms)
>   	Total time: 56.37ms, (+0.00ms)
>   Found optarg
>   dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr
> 
>   real	0m0.935s
>   user	0m0.426s
>   sys	0m0.490s
> 
>   With version 2.12.0 I used to see real below 200ms. So it seems qemu
>   slowed down 5 times.
> 
>   I ran strace -tt against it and I have noticed a pause here:
>   ...
>   07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
>   07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) = 0
>   07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) = 0
>   07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) = 1
>   07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) = 0
>   07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) = 1
>   07:31:41.848747 getpid()                = 5162
>   07:31:41.848769 tgkill(5162, 5166, SIGUSR1) = 0
>   07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
>   07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) = 1
>   07:31:41.848837 getpid()                = 5162
>   07:31:41.848858 tgkill(5162, 5166, SIGUSR1) = 0
>   07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) = 8
>   07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
>   07:31:41.848943 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}, 
>   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=0}, NULL, 8) = 1 ([{fd=8, revents=POLLIN}], left {tv_sec=0, tv_nsec=0
>   })
>   07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = -1 EAGAIN (Resource temporarily unavailable)
>   07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) = 8
>   07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 0
>   07:31:41.849086 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}, 
>   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=984624000}, NULL, 8) = 1 ([{fd=7, revents=POLLIN}], left {tv_sec=0, t
>   v_nsec=190532609})
> 
>   --> waits for almost 800ms
> 
>   07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = 0
>   07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) = 8
>   07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
>   07:31:42.643646 ppoll([{fd=0, events=POLLIN}, {fd=4, events=POLLIN}, {fd=5, events=POLLIN}, {fd=7, events=POLLIN}, 
>   {fd=8, events=POLLIN}], 5, {tv_sec=0, tv_nsec=190066000}, NULL, 8) = 2 ([{fd=4, revents=POLLIN}, {fd=8, revents=POL
>   LIN}], left {tv_sec=0, tv_nsec=189909632})
>   07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) = -1 EAGAIN (Resource temporarily unavailable)
>   07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) = 8
>   07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) = 1
> 
>   ...
> 
>   when I run same command using qemu 3.0.5 that I still happen to have
>   on the same machine that I built directly from source I see total boot
>   time at around 200ms. It seems like a regression.
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1826393/+subscriptions

-- 

Stefano Garzarella
Software Engineer @ Red Hat

