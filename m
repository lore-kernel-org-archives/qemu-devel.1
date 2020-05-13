Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35622CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED07A204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED07A204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsHO-0006Lg-9M
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYsGg-0005RG-Ps
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:21:54 -0400
Received: from relay64.bu.edu ([128.197.228.104]:36595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYsGf-00080X-MN
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:21:54 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04DEKhrQ007516
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 13 May 2020 10:20:45 -0400
Date: Wed, 13 May 2020 10:20:43 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 0/2] use unsigned type for MegasasState fields
Message-ID: <20200513142043.lfcamp5j43ke5md4@mozz.bu.edu>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <26201c24-c483-85a7-2f4b-b3cc56d4b8b7@redhat.com>
 <nycvar.YSQ.7.76.2005122357030.1451610@xnncv>
 <20200512190803.o6vr2shjmhsplsjx@mozz.bu.edu>
 <20200512194759.nb42yurlnynr5yrw@mozz.bu.edu>
 <nycvar.YSQ.7.76.2005131905010.1451610@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2005131905010.1451610@xnncv>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 10:21:51
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ren Ding <rding@gatech.edu>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200513 1919, P J P wrote:
>   Hello Alex,
> 
> +-- On Tue, 12 May 2020, Alexander Bulekov wrote --+
> | I noticed this since I found a similar issue recently, using a fuzzer. I 
> | applied your patches, but I can still reproduce the heap-overflow, unless 
> | I'm missing something:
> 
> Strange, because with uint16_t type, 'reply_queue_head' should not turn 
> negative.
> 
> | cat << EOF | qemu-system-i386 -qtest stdio -nographic -monitor none \
> | -serial none -M q35 -device megasas -device scsi-cd,drive=null0 \
> | -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
> | outl 0xcf8 0x80001814
> | outl 0xcfc 0xc021
> | outl 0xcf8 0x80001818
> | outl 0xcf8 0x80001804
> | outw 0xcfc 0x7
> | outl 0xcf8 0x80001810
> | outl 0xcfc 0xe10c0000
> | outl 0xcf8 0x8000f810
> | write 0x0 0x18 0x060017e1ff00f8ffffffff60efffffffffffffffffffffff
> | write 0xff00 0x1 0x06
> | write 0xc021e10c0040 0x81 0x755e08ff0000845e08ff0000935e08ff0000a25e08ff0000b15e08ff0000c05e08ff0000cf5e08ff0000de5e08ff0000ed5e08ff0000fc5e08ff00000b5e08ff00001a5e08ff0000295e08ff0000385e08ff0000475e08ff0000565e08ff0000655e08ff0000745e08ff0000835e08ff0000925e08ff0000a15e08ff0000b05e08
> | -M pc-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic
> | EOF
> 
> Are qemu options just above EOF right?
They are not necessary, but for me QEMU crashes before qtest ever tries
to parse them. Is your QEMU built with ASAN?
-Alex

> 
> This leads to an assert failure below
> 
>   qemu/qtest.c:546:qtest_process_command: assertion failed: (words[1] && words[2] && words[3])
>   ...
>   Aborted                 (core dumped) /tmp/im/bin/qemu-system-x86_64 -qtest 
>   stdio -nographic -monitor none -serial none -M q35 -device megasas -device 
>   scsi-cd,drive=null0 -blockdev driver=null-co,read-zeroes=on,node-name=null0 -nographic < ins
> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

