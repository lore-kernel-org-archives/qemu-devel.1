Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FAEC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588A5218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588A5218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7PED-0005cI-Gd
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 15:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1i7PDZ-0005D0-IN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1i7PDY-0005c5-9w
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:20:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1i7PDY-0005bC-3c
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:20:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 371AE20EB;
 Mon,  9 Sep 2019 19:20:51 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
 [10.36.116.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32C9D10018F8;
 Mon,  9 Sep 2019 19:20:46 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <add488d0-df13-830f-28c5-c7232ccb741f@redhat.com>
 <20190905154925.30478-1-imammedo@redhat.com>
 <dbe8cc44-ef30-3104-2bd3-6a6fe4438ada@redhat.com>
Message-ID: <aaeac0bd-5e99-8480-5191-d402bde9a96c@redhat.com>
Date: Mon, 9 Sep 2019 21:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dbe8cc44-ef30-3104-2bd3-6a6fe4438ada@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 09 Sep 2019 19:20:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] q35: lpc: allow to lock down 128K RAM at
 default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 alex.williamson@redhat.com, jiewen.yao@intel.com, jun.nakajima@intel.com,
 michael.d.kinney@intel.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 rfc@edk2.groups.io, joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 21:15, Laszlo Ersek wrote:

> ... I've done some testing too. Applying the QEMU patch on top of
> 89ea03a7dc83, my plan was:
> 
> - do not change OVMF, just see if it continues booting with the QEMU
> patch
> 
> - then negotiate bit#1 too, in step (1a) -- this is when I'd expect (3a)
> to break.
> 
> Unfortunately, the result is worse than that; even without negotiating
> bit#1 (i.e. in the baseline test), the firmware crashes (reboots) in
> step (3a). I've checked "info mtree", and all occurences of
> "smbase-blackhole" and "smbase-blackhole" are marked [disabled]. I'm not
> sure what's wrong with the baseline test (i.e. without negotiating
> bit#1). If I drop the patch (build QEMU at 89ea03a7dc83), then things
> work fine.

Sorry, there's a typo above: I pasted "smbase-blackhole" twice. The
second instance was meant to be "smbase-window". I checked all instances
of both regions in the info mtree output, I just fumbled the pasting.

Thanks
Laszlo

