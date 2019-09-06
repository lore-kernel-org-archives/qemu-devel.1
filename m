Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBADC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C31220578
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="bfDP7C7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C31220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fnarfbargle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69xx-0003Ht-An
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i69x9-0002cS-Aj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lists2009@fnarfbargle.com>) id 1i69x7-0005bi-Aw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:50:47 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:38282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i69x6-0005WV-Oa; Fri, 06 Sep 2019 04:50:45 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh29303)
 by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <lists2009@fnarfbargle.com>)
 id 1i69vC-00052y-Kj; Fri, 06 Sep 2019 16:48:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fnarfbargle.com; s=mail; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject;
 bh=M8rSvzvv+XUy0tywBgKqVhrBaQSVsVtCpRo2Snsbe2o=; 
 b=bfDP7C7IRxWqYPmp5VtBo/x1zJveTGGPstTU2vjGJbCqj+L8YPfDZoHTO7fPL2ewGQJa3l74eOBybb/NmDSiny01WGCXGkGWfMqNqEqmFpD63fc/3jPDQpemi+ydZfYszjjx8guiGUX2X3a4y9Rjds7ILeuRVJsM92wPTTuGhNw=;
From: Brad Campbell <lists2009@fnarfbargle.com>
To: qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>
References: <ed421291-7178-d7bc-5ed3-9863d28ceba9@fnarfbargle.com>
 <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
Message-ID: <b1782119-abbc-9678-8217-ef576dbf8c93@fnarfbargle.com>
Date: Fri, 6 Sep 2019 16:49:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <dd33a398-3c1f-0c92-2318-00ad144e1e5d@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 103.4.19.87
Subject: [Qemu-devel] Cross-posted : Odd QXL/KVM performance issue with a
 Windows 7 Guest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/9/19 6:23 pm, Brad Campbell wrote:

> 
> Here is the holdup :
> 
> 11725@1567416625.003504:qxl_ring_command_check 0 native
> 11725@1567416625.102653:qxl_io_write 0 native addr=0 (QXL_IO_NOTIFY_CMD) 
> val=0 size=1 async=0
> 
> ~100ms delay prior to each logged QXL_IO_NOTIFY_CMD on the AMD box which 
> explains the performance difference. Now I just need to figure out if 
> that lies in the guest, the guest QXL driver, QEMU or SPICE and why it 
> exhibits on the AMD box and not the i7.
> 
> To get to this point, I recompiled the kernel on the i7 box with both 
> AMD and Intel KVM modules. Once that was running I cloned the drive and 
> put it in the AMD box, so the OS, software stack and all dependencies 
> are identical.

Reacp :

I have a machine with a Windows 7 VM which is running on an i7-3770. 
This works perfectly.

Clone the disk and put it in a new(ish) AMD Ryzen 1500x machine and the 
display output using qxl/spice is now limited to ~5-7fps.

I originally cloned the entire machine to keep the software versions 
identical.

To simplify debugging and reproduction I'm now using :
- An identical SPICE version to that on the i7.
- A fresh 64 bit Windows 7 VM.
- The D2D benchmark from Crystalmark 2004R7.

The machine is booted with :

qemu -enable-kvm \
  -m 8192\
  -rtc base=localtime\
  -vga qxl\
  -device qxl\
  -global qxl-vga.guestdebug=3\
  -global qxl-vga.cmdlog=1\
  -global qxl-vga.vram_size=65536\
  -global qxl.vram_size=65536\
  -global qxl-vga.ram_size=65536\
  -global qxl.ram_size=65536\
  -net nic,model=virtio\
  -net tap,ifname=tap0,script=/etc/qemu-ifup,vhost=on\
  -usbdevice tablet\
  -spice port=5930,disable-ticketing\
  -device virtio-serial\
  -chardev spicevmc,id=vdagent,name=vdagent\
  -device virtserialport,chardev=vdagent,name=com.redhat.spice.0\
  -smp 3,maxcpus=3,cores=3,threads=1,sockets=1\
  -cpu qemu64,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time \
  -drive 
file=/server/VM/Cadbox.raw,if=virtio,aio=threads,format=raw,cache=unsafe 
-boot c \
  -drive 
file=/server/VM/Cadbox_swap.raw,if=virtio,aio=threads,format=raw,cache=unsafe 
\


The D2D benchmark runs through a series of Sprites (stars) and it just 
shuffles them around the screen.

With KVM enabled I get :

Sprite    10 - 8.66fps
Sprite   100 - 8.47fps
Sprite   500 - 8.45fps
Sprite  1000 - 8.18fps
Sprite  5000 - 7.64fps
Sprite 10000 - 7.26fps

With the identical system, with KVM disabled I get :

Sprite    10 - 28.97fps
Sprite   100 - 27.24fps
Sprite   500 - 23.85fps
Sprite  1000 - 22.00fps
Sprite  5000 - 11.11fps
Sprite 10000 -  4.50fps

On the i7 with the same software version and kvm enabled  :

Sprite    10 - 88.58fps
Sprite   100 - 88.35fps
Sprite   500 - 85.64fps
Sprite  1000 - 83.33fps
Sprite  5000 - 58.08fps
Sprite 10000 - 45.29fps


cpuinfo from the host :
processor	: 7
vendor_id	: AuthenticAMD
cpu family	: 23
model		: 1
model name	: AMD Ryzen 5 1500X Quad-Core Processor
stepping	: 1
microcode	: 0x8001138
cpu MHz		: 2877.596
cache size	: 512 KB
physical id	: 0
siblings	: 8
core id		: 5
cpu cores	: 4
apicid		: 11
initial apicid	: 11
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 
sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm 
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt 
tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb 
hw_pstate sme ssbd sev ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed 
adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf 
xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean 
flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload 
vgif overflow_recov succor smca
bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
bogomips	: 6985.80
TLB size	: 2560 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 43 bits physical, 48 bits virtual
power management: ts ttp tm hwpstate eff_freq_ro [13] [14]

qemu configured with : 
PKG_CONFIG_PATH=/usr/local/libvirt/lib/pkgconfig:/usr/local/libvirt/share/pkgconfig/ 
./configure --target-list=x86_64-softmmu --disable-gtk && make -j6
test:~# uname -a

Linux test 5.2.9 #42 SMP Tue Aug 20 16:41:13 AWST 2019 x86_64 GNU/Linux

test:~# zgrep KVM /proc/config.gz
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_KVM=m
# CONFIG_KVM_INTEL is not set
CONFIG_KVM_AMD=m
# CONFIG_KVM_MMU_AUDIT is not set

test:~# qemu --version
QEMU emulator version 4.1.50 (v4.1.0-714-g90b1e3a)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

To be clear, I'm not chasing benchmarks. This is a real issue with 
trying to run CAD on a Windows 7 VM on a Ryzen machine.

I've tried it on two machines (a 1500x and an 1800x) with the same 
result. The same configuration on the i7 box works perfectly.

I've tried several versions of SPICE, multiple versions of KVM, kernels 
back as far as 4.0 with KVM enabled, different old and new windows VMs 
and driver versions. The only constant is it is limited on the AMD box 
if KVM is enabled.

I was leaning towards it being something in the qemu/spice software 
stack, but the fact that without kvm enabled it goes as fast as the CPU 
will allow it would indicate perhaps the fault likes in some 
relationship with kvm, so I'm cross-posting to qemu-devel to see if this 
jogs someones memory, or if there are any other things I can try to 
attempt to solve this one.

Regards,
Brad

