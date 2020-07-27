Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF70020729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70020729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0547-0001Tz-Nu
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1k04v9-0002Sv-Lt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:20:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:58497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1k04v7-0001QC-Hb
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:20:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4042140002;
 Mon, 27 Jul 2020 18:20:02 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3BFADE8;
 Mon, 27 Jul 2020 18:20:03 +0300 (MSK)
Subject: Re: [PATCH] xen: xenguest is not used so is not needed
To: Anthony PERARD <anthony.perard@citrix.com>
References: <20200727140048.19779-1-mjt@msgid.tls.msk.ru>
 <20200727150949.GC2866@perard.uk.xensource.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <c90a625b-51d3-3718-1e83-1019f1cbd227@msgid.tls.msk.ru>
Date: Mon, 27 Jul 2020 18:20:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727150949.GC2866@perard.uk.xensource.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 10:00:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.07.2020 18:09, Anthony PERARD wrote:
> On Mon, Jul 27, 2020 at 05:00:48PM +0300, Michael Tokarev wrote:
>> There's no references in only file which includes xenguest.h
>> to any xen definitions. And there's no references to -lxenguest
>> in qemu, either. Drop it.
> 
> I'm not sure what you mean by "no references to -lxenguest", do you mean
> in the binary?

Yes, in the qemu-system-i386 binary, it can be linked without -lxenguest.

Just a caveat, -- I know almost nothing about xen, especially xen
internals and its (stable, unversioned and unstable, versioned) libs.
Qemu links fine without libxenguest in the mix with xen 4.11.4, - I
can't say for other versions.  I just thought if it does not include
<xenguest.h>, why it should link with -lxenguest? :)

/mjt

