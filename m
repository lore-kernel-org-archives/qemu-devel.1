Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A7CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3C72065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0J13o3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3C72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu4y-0003qq-Jv
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juu4M-0003Qv-En
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:44:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57180
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juu4L-0000jw-3X
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zf3aWfXFggLqNaVfXaIeOaUGOjTHd4Clk4fN65p9YCE=;
 b=A0J13o3xawrfe+R18ySyOu83eQ/GJM5HAn1afFzPeeXHCQ/whlhVzWDpTINxz3NTsMQiEu
 1wlag6aEzdwdkJkWrxhXLa16QL60PmlsUqWBIguexPixxAJFDILpcZVyM9BmxlWmLwMxhN
 saf7LLAp0tFMRVI4QvvH1bKbtmMtNAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-S02bFSaMMFyCzAPOb_aXlg-1; Mon, 13 Jul 2020 04:44:07 -0400
X-MC-Unique: S02bFSaMMFyCzAPOb_aXlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6927D8015CE;
 Mon, 13 Jul 2020 08:44:06 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55C6B10001B9;
 Mon, 13 Jul 2020 08:44:04 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:44:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 0/2] hyperv: vmbus: ACPI various corrections
Message-ID: <20200713104402.38e8369e@redhat.com>
In-Reply-To: <20200625045011.1075314-1-arilou@gmail.com>
References: <20200625045011.1075314-1-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 07:50:09 +0300
Jon Doron <arilou@gmail.com> wrote:

> After doing further tests and looking at the latest HyperV ACPI DSDT.
> Do minor fix to our VMBus ACPI entry.

Jon,
vmbus feature needs a testcase, could you look into it please? 
(see tests/qtest/bios-tables-test.c for an example.
also look into comment blob at the top for the propper process
for acpi patches/tests)


> v4:
> * Removed the patch which adds _ADR definition to the VMBus
> * Correct the change which moves the VMBus under the SB
> 
> v3:
> Removed accidental change for the dct submodule head
> 
> v2:
> Renamed irq0 to irq now that there is a single IRQ required
> 
> Jon Doron (2):
>   hyperv: vmbus: Remove the 2nd IRQ
>   acpi: i386: Move VMBus DSDT entry to SB
> 
>  hw/hyperv/vmbus.c                |  3 +--
>  hw/i386/acpi-build.c             | 16 ++++++++--------
>  include/hw/hyperv/vmbus-bridge.h |  3 +--
>  3 files changed, 10 insertions(+), 12 deletions(-)
> 


