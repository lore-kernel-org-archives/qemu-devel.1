Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF63C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3B120675
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3B120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAQ6-00008R-7i
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYAPD-0007s7-JH
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:31:47 -0400
Received: from relay64.bu.edu ([128.197.228.104]:44634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYAPA-0005eC-NH
 for qemu-devel@nongnu.org; Mon, 11 May 2020 11:31:46 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 04BFVRXD023737
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 11 May 2020 11:31:31 -0400
Date: Mon, 11 May 2020 11:31:27 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Abort in mch_update_pciexbar
Message-ID: <20200511153127.sbnijh7ee4gcpmre@mozz.bu.edu>
References: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
 <c6b66f8a-40e4-8ad5-afb4-09bddbcac529@redhat.com>
 <2344dc20-5c7f-75eb-96d2-bef0153550d6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2344dc20-5c7f-75eb-96d2-bef0153550d6@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:31:43
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200511 0910, Philippe Mathieu-Daudé wrote:
> On 5/11/20 8:19 AM, Philippe Mathieu-Daudé wrote:
> > On 5/11/20 6:59 AM, Alexander Bulekov wrote:
> > > Hello,
> > > While fuzzing, I found an input that triggers an assertion failure in
> > > mch_update_pciexbar:
> > > 
> > > #6 0x7f38d387c55a in abort
> > > /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
> > > #7 0x55c27e94ffd0 in mch_update_pciexbar hw/pci-host/q35.c:331:9
> > > #8 0x55c27e94db38 in mch_write_config hw/pci-host/q35.c:487:9
> > > #9 0x55c27e9e3f4c in pci_host_config_write_common hw/pci/pci_host.c:81:5
> > > #10 0x55c27e9e5307 in pci_data_write hw/pci/pci_host.c:118:5
> > > #11 0x55c27e9e6601 in pci_host_data_write hw/pci/pci_host.c:165:9
> > > #12 0x55c27ca3b17b in memory_region_write_accessor memory.c:496:5
> > > #13 0x55c27ca3a5e4 in access_with_adjusted_size memory.c:557:18
> > > #14 0x55c27ca38177 in memory_region_dispatch_write memory.c:1488:16
> > > #15 0x55c27c721325 in flatview_write_continue exec.c:3174:23
> > > #16 0x55c27c70994d in flatview_write exec.c:3214:14
> > > #17 0x55c27c709462 in address_space_write exec.c:3305:18
> > 
> > These lines don't match QEMU v5.0.0.

Right... I'll make sure the stack-trace comes from the same version in
the future.

> > > 
> > > I can reproduce it in a qemu 5.0 build using:
> > > cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386
> > > -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> > > outl 0xcf8 0xf2000060
> > > outl 0xcfc 0x8400056e
> > 
> > The guest shouldn't ask for a reserved bar length (grep for
> > MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD). I suppose we should simply report
> > it as GUEST_ERROR and ignore it.
> 
> This patch prevent the crash:
> 
> -- >8 --
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 2bbc90b28f..2b744aca93 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -36,6 +36,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
> 
> 
> /****************************************************************************
>   * Q35 host
> @@ -320,6 +321,9 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>          addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>          break;
>      case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid use of reserved
> value\n",
> +                                       __func__);
> +        return;
>      default:
>          abort();
>      }
> ---
> 
> But the real question is what would the real hardware do in this case.
> 
> > 
> > > EOF
> > > 
> > > I also uploaded the above trace, in case the formatting is broken:
> > > 
> > > curl https://paste.debian.net/plain/1146095 | qemu-system-i386 -M
> > > pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
> > > 
> > > Please let me know if I can provide any further info.
> > 
> > It would help the community if you fill your bug reports with Launchpad,
> > so they don't get lost in the high email flow, and we can track/update
> > them. See for example:
> > https://bugs.launchpad.net/qemu/+bug/1835865 and
> > https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06082.html
> > which refers it.

OK, I'll use that from now on.
Thanks
-Alex

