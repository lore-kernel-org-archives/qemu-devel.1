Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A46DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5D8206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5D8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDDN-0005J5-G4
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtDCG-0004g3-KA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:45:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jtDCE-0000Dm-Pi
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4754DACC6;
 Wed,  8 Jul 2020 16:45:21 +0000 (UTC)
Subject: Re: [PULL 00/53] Misc patches for QEMU 5.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200706164155.24696-1-pbonzini@redhat.com>
 <CAFEAcA-F1FGde+=c3iS3wcRWG+i0RgYj5-jwafn0sX6EEYEsWA@mail.gmail.com>
 <1a9ad36f-f4ae-2ea5-3d69-03aa5580b60e@suse.de>
 <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <f17ca47d-f5e9-e710-5edb-9d92839ee7c1@suse.de>
Date: Wed, 8 Jul 2020 18:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <de27589f-6afb-b8cf-05a0-f5d34f9d2a58@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 6:16 PM, Paolo Bonzini wrote:
> On 08/07/20 18:13, Claudio Fontana wrote:
>> so I don't get any tcg_get_icount_limit() compiled in, and no
>> errors.
>>
>> I think that having comparable configure command line and compiler
>> version/flags would help me pin down any related issue.
> 
> Are you using link-time optimization by chance?
> 
> Paolo
> 

Yes unfortunately, nothing I have willingly enabled, but I found traces of LTO in C++.

C++ is used to link the final qemu-system binary and on my system c++ has LTO:

c++ -v
Using built-in specs.
COLLECT_GCC=c++
COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-suse-linux/7/lto-wrapper
OFFLOAD_TARGET_NAMES=hsa:nvptx-none
Target: x86_64-suse-linux
Configured with: ../configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64 --enable-languages=c,c++,objc,fortran,obj-c++,ada,go --enable-offload-targets=hsa,nvptx-none=/usr/nvptx-none, --without-cuda-driver --enable-checking=release --disable-werror --with-gxx-include-dir=/usr/include/c++/7 --enable-ssp --disable-libssp --disable-libvtv --disable-libcc1 --disable-plugin --with-bugurl=https://bugs.opensuse.org/ --with-pkgversion='SUSE Linux' --with-slibdir=/lib64 --with-system-zlib --enable-libstdcxx-allocator=new --disable-libstdcxx-pch --enable-version-specific-runtime-libs --with-gcc-major-version-only --enable-linker-build-id --enable-linux-futex --enable-gnu-indirect-function --program-suffix=-7 --without-system-libunwind --enable-multilib --with-arch-32=x86-64 --with-tune=generic --build=x86_64-suse-linux --host=x86_64-suse-linux
Thread model: posix
gcc version 7.5.0 (SUSE Linux) 


I checked cc but did not think to check c++ . I will find a way to disable this thing and will correct the patch accordingly.

Thanks a lot, and sorry for the inconvenience!

Claudio



