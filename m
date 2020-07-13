Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A49C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C236A2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCKcdNpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C236A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu1c-0001zl-1D
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juu14-0001bD-3y
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:40:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55352
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juu12-0000Sn-IK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWJE2AN8Qbpf1xYaVqVh16yA3WSSKK/j7dqaAhLYti8=;
 b=bCKcdNpK0c6aOdGdf+A09DznUM/IDkoR7sUX6QCdlm4rVQz1J5k/ET37OlJiyFAYrtd3XE
 HwbZ3vsByoiuLO9wK83sXd+lwfKYhEC+qBhDpvmByW3HiU3xSZu7J3TVsomwbIQMYk2zED
 Nub/UjLvbPLWpvYyV+XGmX3zhlUCMP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-YsIBKNgkO9Sp1dRkqu0DPQ-1; Mon, 13 Jul 2020 04:40:43 -0400
X-MC-Unique: YsIBKNgkO9Sp1dRkqu0DPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DEAC8BDF95;
 Mon, 13 Jul 2020 08:40:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4452A2E161;
 Mon, 13 Jul 2020 08:40:26 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:40:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 0/2] hyperv: vmbus: ACPI various corrections
Message-ID: <20200713104024.638f4dc9@redhat.com>
In-Reply-To: <20200625045011.1075314-1-arilou@gmail.com>
References: <20200625045011.1075314-1-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
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

Michael,

could you queue it for 5.1, pls?


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


