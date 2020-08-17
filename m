Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E582067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="bWtMFX29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E582067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cvh-0004TU-GC
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7cus-0003mD-3w
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:03:02 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37656 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7cuq-0004ab-8o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:03:01 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B9BB9527DC;
 Mon, 17 Aug 2020 11:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1597662175;
 x=1599476576; bh=9GhqVW//jqLHrzdpYtyxfxgY17FkckeNtzu7iJ8DaiU=; b=
 bWtMFX29CLIwAAD50LUdWIn8XhqiaHWHmgsxy0Vh9jh0jigBgQ50zJ75Ro5qkIpT
 yjCnkGcLTFcIiOD7aNAzw9ut0sKVP1rERvYiSeD6uhyGSO4DzkisRTavldhqbtcF
 V7CGBrjjMvH9eVT2tkqHcW5iNPQsPCAfTuUYusz+vtI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RfPeG6Xt2eZY; Mon, 17 Aug 2020 14:02:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 35AD1527D2;
 Mon, 17 Aug 2020 14:02:54 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 Aug 2020 14:02:54 +0300
Date: Mon, 17 Aug 2020 14:02:54 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
Message-ID: <20200817110254.GA98227@SPB-NB-133.local>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 07:02:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 05:10:56AM -0400, Paolo Bonzini wrote:
> News since v1:
> * automatically generate dependencies for sphinx manuals [Peter]
> * fixes for ARM KVM build [Peter]
> * work around old libiscsi in vhost-user-scsi.c [Peter]
> * hack to support default c:/Program Files/QEMU prefix on mingw cross compilation [Peter]
> * added --enable-gettext/--disable-gettext [Peter]
> * test for setuptools presence [Peter]
> * fixes for Darwin [Peter, Roman]
> * do not invoke system Meson through Python, always use embedded Meson with --python [Roman]
> * improvements and fixes to clean and distclean targets [Stefano]
> * avoid (incorrect?) ubsan failure from CONFIG_BDRV_*_WHITELIST [Alexander]
> * move --s390-pgste to Meson, removed QEMU_CFLAGS/QEMU_LDFLAGS for config-target.mak
> * remove some dead configure assignments
> * update build system docs on how to add configure options, convert to rST
> * moved installation of edk2 blobs and descriptors to Meson
> * build and install elf2dmp on Windows too
> * included headers renamed to .c.inc instead of .inc
> 
> Available from https://gitlab.com/bonzini/qemu branch meson-poc-next.
> 
> Paolo
> 

Hi Paolo,

for macOS/darwin,

Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

On the next step, it might be good to drop configure in favor of meson
configuration, so configure, build and test commands would be similar to
libvirt:

meson build
ninja -C build
meson test -C build

Thanks,
Roman

