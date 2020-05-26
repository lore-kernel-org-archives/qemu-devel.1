Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6816BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F6D20663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F6D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUiH-0008Up-Dt
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@intel.com>)
 id 1jdUbJ-0002hJ-Ck
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:06:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:48177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yang.zhong@intel.com>)
 id 1jdUbH-0004j1-N3
 for qemu-devel@nongnu.org; Tue, 26 May 2020 04:06:16 -0400
IronPort-SDR: 2GQwp0LrKjYpl04E1Lo/LL+TUhiMMDWdM5V6qOqZwf4mKiJm7yV7DN0aebNbUZ8bd4bl25gDke
 zHmW/FOnfNWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 01:06:12 -0700
IronPort-SDR: 3B3jA/F85j8oh8aF6XvKuRB/twdFUD8WT0WK1oDETgI//WaZbw4zNvd4bSpLBcJWXhArzXzQtq
 Tncu9xu/STMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; d="scan'208";a="441994311"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost)
 ([10.238.144.101])
 by orsmga005.jf.intel.com with ESMTP; 26 May 2020 01:06:10 -0700
Date: Tue, 26 May 2020 15:57:38 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: About the PVH in Seabios
Message-ID: <20200526075738.GB28145@yangzhon-Virtual>
References: <20200526071826.GA28145@yangzhon-Virtual>
 <20200526073651.mqnawlzjcqz2452t@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526073651.mqnawlzjcqz2452t@steredhat>
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yang.zhong@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 04:06:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 09:36:51AM +0200, Stefano Garzarella wrote:
> Hi Yang,
> 
> On Tue, May 26, 2020 at 03:18:26PM +0800, Yang Zhong wrote:
> > Hello all,
> > 
> > The current PVH has been implemented in Qemu and Qboot/uefi, i am not
> > familiar with the PVH implementation history, and found there is no
> > PVH support in Seabios, my question is do we have plan to support
> > PVH in Seabios? thanks.
> 
> We developed an optionrom in QEMU (pc-bios/optionrom/pvh*) that is used
> with SeaBIOS to boot a PVH image.
> 
> So we don't need to change SeaBIOS since it already supports optionroms.
> Currently when you use a PVH image in QEMU, SeaBIOS is used as default
> choice with the PVH optionrom.
>
  Stefano, thanks for your information, i only checked the pvh changes
  in Seabios code and ignored optionrom changes, thanks again.

  Regards,

  Yang

> Cheers,
> Stefano

