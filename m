Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6D120729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6D120729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k06xp-0005lW-Bc
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k06x8-0005FV-1q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:30:18 -0400
Received: from relay68.bu.edu ([128.197.228.73]:41132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k06x1-0004Bs-FY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:30:17 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06RHTTJU001039
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2020 13:29:32 -0400
Date: Mon, 27 Jul 2020 13:29:29 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH 0/2] assertion failure in net_tx_pkt_add_raw_fragment()
 in hw/net/net_tx_pkt.c
Message-ID: <20200727172929.5nnasrbvp2gg3yyv@mozz.bu.edu>
References: <20200727170838.1101775-1-mcascell@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727170838.1101775-1-mcascell@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 13:30:09
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org,
 ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I sent a reproducer for the to the list some time ago, but never created
a Launchpad bug...
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701930.html

Anyways.. I can confirm that I can't reproduce the issue with these
patches.

Minimized Reproducer:
cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc-q35-5.0 -nographic \
-display none -serial none -monitor none -qtest stdio
outl 0xcf8 0x80001010
outl 0xcfc 0xe1020000
outl 0xcf8 0x80001004
outw 0xcfc 0x7
write 0xe10207e8 0x4 0x25ff13ff
write 0xe10200b8 0x7 0xe3055e411b0202
write 0xe1020100 0x5 0x5e411b0202
write 0xe1020110 0x4 0x1b0202e1
write 0xe1020118 0x4 0x06fff105
write 0xe1020128 0x7 0xf3055e411b0202
write 0xe1020402 0x2 0x5e41
write 0xe1020420 0x4 0x1b0202e1
write 0xe1020428 0x4 0x06ff6105
write 0xe1020438 0x1 0x63
write 0xe1020439 0x1 0x05
EOF

-Alex

On 200727 1908, Mauro Matteo Cascella wrote:
> An assertion failure issue was reported by Mr. Ziming Zhang (CC'd).
> It occurs in the code that processes network packets while adding data
> fragments into packet context. This flaw could potentially be abused by
> a malicious guest to abort the QEMU process on the host. This two patch
> series does a couple of things:
> 
> - introduces a new function in net_tx_pkt.{c,h} to check the maximum number
>   of data fragments
> - adds a check in both e1000e and vmxnet3 devices to skip the packet if the
>   current data fragment exceeds max_raw_frags, preventing
>   net_tx_pkt_add_raw_fragment() to be called with an invalid raw_frags
> 
> Mauro Matteo Cascella (2):
>   hw/net/net_tx_pkt: add function to check pkt->max_raw_frags
>   hw/net: check max_raw_frags in e1000e and vmxnet3 devices
> 
>  hw/net/e1000e_core.c | 3 ++-
>  hw/net/net_tx_pkt.c  | 5 +++++
>  hw/net/net_tx_pkt.h  | 8 ++++++++
>  hw/net/vmxnet3.c     | 3 ++-
>  4 files changed, 17 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2
> 
> 

