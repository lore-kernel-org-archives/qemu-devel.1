Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F8C83003
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 03:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50572082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 03:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jGD8Qcpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50572082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTzi9-0007d8-Oo
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 23:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1jTzhR-0006pS-B3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1jTzhQ-00035e-52
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:17:21 -0400
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147]:37358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liewkj@yahoo.com>) id 1jTzhP-00035R-CN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 23:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1588216636; bh=JGSaFXaCR3B5D7FwKCvsU3qPbrxRkv14+338cFuztBE=;
 h=Date:From:To:Subject:Reply-To:References:From:Subject;
 b=jGD8QcpddIMQFgThlxqEs3g/FYDSwNmL97hR28k054S+VRyIPH9MHauo2HFuDjKfjR6kEkAq09OhXNRjyxPOPH2qCnWxiDzxbPsbhIFA/AtNRBkC+CNcxDoGwO2x9WhuhEs9P/2Icd8L5cEe/nW2XAM0CDSb5k3Os4Q7Nd7C0hZ7PG7NQRXbEfPfOi4+0sTCwT1n2mSTMeQI5o0Gd+ZpzpPkyZ7jFe+vrWUwNM2QVJalqGsPxu86+YpWeeVI+oXamgOmhvR1MJ2QVVdUVY+7EJYc8LIyW51IYltlP60AEqSCQBmHlTNN7nVKsvcz+uX4kJ/bX6Pf0tYJM+fDZuoHew==
X-YMail-OSG: ve9J6b0VM1kJosYE_R4uw5PHoKqHYwF2i3BSsoM.iZuLAVtnG1Ng9nVdgCP7VkP
 Xs1IMVKSp0ngg9_o.8mGb13scNwDKvdkDZR3tAEmbj7smL1XGU6hgh6jXTnrmqlzpczOiGpBcBF6
 Zab1Tcrgrj9fQQ4miYx5C0OPPQpdxP.pqBXtstpPYcNDKVfU_JjbbL7850shuJNzYTI1DnmkVLqC
 72MOLFayT8Z_MVNTmaeHuxvJPn6.iE2OazQC2YUIU.zhiSfGjcMILNus3EPJyQ9r0mhCogreAJ.j
 HOswkBTBbibWVoBG.892_CP78IwHfR4Ku50Q9tPRa5enTXPNJhpVVXejx.kj5.KJmApxTjt.5wj7
 lxJGJWFI9h7IRdRgxssqXA5S5tI1mCWBjd8SUKqggfHQmEv00au8k3TYmJoe5GYysqHCC6W0sSix
 sofFWLx4ayLfLW7BKyD8XDFXXtV3b9Hd7LOmnGCg6UDCgcFam9w01SkgvxlHj7XhW3D3lxtoB2q9
 8WadhlIVznHLk7_fLujG_3Bapb7_sg5aEo24QOMKCjz41C2RTQIV764nltMaAk8ktNO6vcP1Awy3
 puciKLYAIX8NMRcKn13uPVvDOdsqg93PA6qnToKBSp9cIoEh33de1iNZ2aGPg.gksYyaJ3ESfXHr
 .NlAvetrIYDvAuIGoUztpTRUAOyjfU_wCU8uovfs9ZqD9rVC.kxgzkmDFF7xBGQFknscdvyqmGkg
 XRwcNP5f5cRkBNQY3HUYKXRND15QlhtGEaV.fPfbRpx9.JXop08OPJ8gM0KzAhvXFkR6ksQ1IAPX
 2FV2ITnDWQ5xlHzUF1FhKWbQX7FtHayWM.Ex4Zy94tJh1s7yO7.J.jfZTu8HvDznVZ0aFHVQSgoX
 6_zGTxgFJzJyuNGuqrTY7PJF1ikR2BX_gjQskLieWhowVl18ZJMvLU8ydgLvouoBYanzmbYbH8mh
 I1a5orP1i4YK4i_1Ksu7H9BIK18LhZP9yw62ySvGL01NVxU.CUeXOqt3.lBbVGCinjgn_xCTDlHq
 0XU2pTf2xMFAslqHx8GksYsDo0wLnNdGBy_Cj87Y804jDHRvJlyUtq8JZQqbfofvXoFACD1_iSLc
 aoYOxhEI4tnnvgjitD4XXeHmBP47rwLdA6Qljb85ak_L8hw7F7s5Pcv__yydIEvP3i.5OPfzMXCY
 HNxt3pjtdq5tJwWS8Yaiqgp6qa6R3jFdZ.YBVo2iz3mXfZYwU2IU9BtZ2Q1GpJ6pJUP3rof06fKV
 jy5Ualss2TW57ZmFHTu_7LHehdn8mEPvpo7arjY.lAdV6qdIc.2tek5jtnzNVS59t96Tpanfy8yp
 pfJVThtTTYsAH5VgyMdcROrI.5.JMD0t_8PhcxCvR6xeHwwrocmYCUv47n5vlYqqLFrwy3zlF
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Apr 2020 03:17:16 +0000
Received: by smtp418.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 46b49d182b6cda0f5233422b233bb276; 
 Thu, 30 Apr 2020 03:17:14 +0000 (UTC)
Date: Wed, 29 Apr 2020 20:17:06 -0700
From: KJ Liew <liewkj@yahoo.com>
To: qemu-devel@nongnu.org
Subject: [BUG] x86/PAT handling severely crippled AMD-V SVM KVM performance
Message-ID: <20200430031706.GA3627@chuwi-lt0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20200430031706.GA3627.ref@chuwi-lt0.localdomain>
X-Mailer: WebService/1.1.15820 hermes Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
Received-SPF: pass client-ip=66.163.187.147; envelope-from=liewkj@yahoo.com;
 helo=sonic316-21.consmr.mail.ne1.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 21:37:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Received-From: 66.163.187.147
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
Reply-To: liewkj@yahoo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I maintain an out-of-tree 3D APIs pass-through QEMU device models at
https://github.com/kjliew/qemu-3dfx that provide 3D acceleration for legacy
32-bit Windows guests (Win98SE, WinME, Win2k and WinXP) with the focus on
playing old legacy games from 1996-2003. It currently supports the now-defunct
3Dfx propriety API called Glide and an alternative OpenGL pass-through based on
MESA implementation.

The basic concept of both implementations create memory-mapped virtual
interfaces consist of host/guest shared memory with guest-push model instead of
a more common host-pull model for typical QEMU device model implementation.
Guest uses shared memory as FIFOs for drawing commands and data to bulk up the
operations until serialization event that flushes the FIFOs into host. This
achieves extremely good performance since virtual CPUs are fast with hardware
acceleration (Intel VT/AMD-V) and reduces the overhead of frequent VMEXITs to
service the device emulation. Both implementations work on Windows 10 with WHPX
and HAXM accelerators as well as KVM in Linux.

On Windows 10, QEMU WHPX implementation does not sync MSR_IA32_PAT during
host/guest states sync. There is no visibility into the closed-source WHPX on
how things are managed behind the scene, but from measuring performance figures
I can conclude that it didn't handle the MSR_IA32_PAT correctly for both Intel
and AMD. Call this fair enough, if you will, it didn't flag any concerns, in
fact games such as Quake2 and Quake3 were still within playable frame rate of
40~60FPS on Win2k/XP guest. Until the same games were run on Win98/ME guest and
the frame rate blew off the roof (300~500FPS) on the same CPU and GPU. In fact,
the later seemed to be more inlined with runnng the games bare-metal with vsync
off.

On Linux (at the time of writing kernel 5.6.7/Mesa 20.0), the difference
prevailed. Intel CPUs (and it so happened that I was on laptop with Intel GPU),
the VMX-based kvm_intel got it right while SVM-based kvm_amd did not.
To put this in simple exaggeration, an aging Core i3-4010U/HD Graphics 4400
(Haswell GT2) exhibited an insane performance in Quake2/Quake3 timedemos that
totally crushed more recent AMD Ryzen 2500U APU/Vega 8 Graphics and AMD
FX8300/NVIDIA GT730 on desktop. Simply unbelievable!

It turned out that there was something to do with AMD-V NPT. By loading kvm_amd
with npt=0, AMD Ryzen APU and FX8300 regained a huge performance leap. However,
AMD NPT issue with KVM was supposedly fixed in 2017 kernel commits. NPT=0 would
actually incur performance loss for VM due to intervention required by
hypervisors to maintain the shadow page tables.  Finally, I was able to find the
pointer that pointed to MSR_IA32_PAT register. By updating the MSR_IA32_PAT to
0x0606xxxx0606xxxxULL, AMD CPUs now regain their rightful performance without
taking the hit of NPT=0 for Linux KVM. Taking the same solution into Windows,
both Intel and AMD CPUs no longer require Win98/ME guest to unleash the full
performance potentials and performance figures based on games measured on WHPX
were not very far behind Linux KVM.

So I guess the problem lies in host/guest shared memory regions mapped as
uncacheable from virtual CPU perspective. As virtual CPUs now completely execute
in hardware context with x86 hardware virtualiztion extensions, the cacheability
of memory types would severely impact the performance on guests. WHPX didn't
handle it for both Intel EPT and AMD NPT, but KVM seems to do it right for Intel
EPT. I don't have the correct fix for QEMU. But what I can do for my 3D APIs
pass-through device models is to implement host-side hooks to reprogram and
restore MSR_IA32_PAT upon activation/deactivation of the 3D APIs. Perhaps there
is also a better solution of having the proper kernel drivers for virtual
interfaces to manage the memory types of host/guest shared memory in kernel
space, but to do that and the needs of Microsoft tools/DDKs, I will just forget
it. The guest stubs uses the same kernel drivers included in 3Dfx drivers for
memory mapping and the virtual interfaces remain driver-less from Windows OS
perspective. Considering the current state of halting progress for QEMU native
virgil3D to support Windows OS, I am just being pragmatic. I understand that
QEMU virgil3D will eventually bring 3D acceleration for Windows guests, but I do
not expect anything to support legacy 32-bit Windows OSes which have out-grown
their commercial usefulness.

Regards,
KJ Liew


