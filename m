Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96909C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7542070E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7542070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtQXV-0005q1-Lu
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 03:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtQWw-0005Q6-SZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:59:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtQWu-0004Xb-Hn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 02:59:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C3B3BABCF;
 Thu,  9 Jul 2020 06:59:35 +0000 (UTC)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
 <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
 <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
 <56c7e153-e47b-aa5c-80c0-ab4f5c3d85e8@redhat.com>
 <57c79f36-4cf9-6188-ef40-b4f775add83d@suse.de>
 <0a3ab45d-468a-65f2-5b9d-440a0a950ded@suse.de>
 <CABgObfZA4+7q9+mg2NTXQC1f+usEsF0sXaNVt0+ursiJ4rAS=A@mail.gmail.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <717d9f61-56c1-875a-7de2-35a3376d515c@suse.de>
Date: Thu, 9 Jul 2020 08:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABgObfZA4+7q9+mg2NTXQC1f+usEsF0sXaNVt0+ursiJ4rAS=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:20:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 8:41 PM, Paolo Bonzini wrote:
> 
> 
> Il mer 8 lug 2020, 20:25 Claudio Fontana <cfontana@suse.de <mailto:cfontana@suse.de>> ha scritto:
> 
>     What I did notice is that all the code that directly or indirectly uses the functions is under an
> 
>     if (0) (
>     )
> 
>     since tcg_enabled is the constant 0.
> 
>     By "indirectly" I mean that the static void qemu_tcg_cpu_thread_fn() function that calls those is referenced only by static void qemu_tcg_init_vcpu(), which is called only under an if (0),
>     ie if (tcg_enabled()).
> 
> 
> Maybe my compiler is older.
> 
>     I admit I am not familiar with the rationale of why the stubs are all built regardless, could we have that icount.o from stubs/ is replacing softmmu/icount.o to cause this?
> 
> 
> No, stubs are in a static library and therefore are always overridden by symbols in the executable's .o files.
> 
> Paolo
> 
> 

Hi Paolo,

which compiler, linker, binutils etc are you using?

I am using

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-suse-linux/7/lto-wrapper
OFFLOAD_TARGET_NAMES=hsa:nvptx-none
Target: x86_64-suse-linux
Configured with: ../configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64 --enable-languages=c,c++,objc,fortran,obj-c++,ada,go --enable-offload-targets=hsa,nvptx-none=/usr/nvptx-none, --without-cuda-driver --enable-checking=release --disable-werror --with-gxx-include-dir=/usr/include/c++/7 --enable-ssp --disable-libssp --disable-libvtv --disable-libcc1 --disable-plugin --with-bugurl=https://bugs.opensuse.org/ --with-pkgversion='SUSE Linux' --with-slibdir=/lib64 --with-system-zlib --enable-libstdcxx-allocator=new --disable-libstdcxx-pch --enable-version-specific-runtime-libs --with-gcc-major-version-only --enable-linker-build-id --enable-linux-futex --enable-gnu-indirect-function --program-suffix=-7 --without-system-libunwind --enable-multilib --with-arch-32=x86-64 --with-tune=generic --build=x86_64-suse-linux --host=x86_64-suse-linux
Thread model: posix
gcc version 7.5.0 (SUSE Linux) 


$ ld -v
GNU ld (GNU Binutils; openSUSE Leap 15.1) 2.32.0.20190909-lp151.3.3

anything else that we could use to find the real problem?

Of course I can try a blind fix, where I suggest to explicitly provide the stubs,
or you can apply the workaround you already suggested if you want,
but currently I do not have any way to ensure that what I build is ok,
since apparently the local build or any of the CI (travis, cirrus) is not sufficient to capture this.

So getting to the bottom of the issue would be important going forward I think so I can ensure better input from my side.

In general, the way current code is relying on the compiler to (maybe) compile out code that calls undefined symbols,
using #define tcg_enabled 0 , and then having the undefined function calls in the code, seems less preferable than solving the problem explicitly
with proper refactoring or with explicit stubs until proper refactoring is complete..

Thanks,

Claudio

 

