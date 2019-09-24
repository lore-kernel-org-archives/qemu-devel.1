Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20CC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CA8214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CA8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmQB-0002mB-9j
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iClI9-0001lY-K4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iClI8-00067A-L5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iClI4-00064v-I9; Tue, 24 Sep 2019 09:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A111EC059B7C;
 Tue, 24 Sep 2019 13:55:39 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 554525B6A5;
 Tue, 24 Sep 2019 13:55:26 +0000 (UTC)
Date: Tue, 24 Sep 2019 15:55:23 +0200
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
Message-ID: <20190924135523.bq75pl24xesb6vgj@kamzik.brq.redhat.com>
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924113105.19076-5-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 24 Sep 2019 13:55:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 abologna@redhat.com, eric.auger@redhat.com, imammedo@redhat.com,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 01:31:00PM +0200, Andrew Jones wrote:
> +SVE CPU Property Parsing Semantics
> +----------------------------------
> +
> +  1) If SVE is disabled (`sve=off`), then which SVE vector lengths
> +     are enabled or disabled is irrelevant to the guest, as the entire
> +     SVE feature is disabled and that disables all vector lengths for
> +     the guest.  However QEMU will still track any `sve<N>` CPU
> +     properties provided by the user.  If later an `sve=on` is provided,
> +     then the guest will get only the enabled lengths.

I just spoke with Andrea, who is doing the libvirt side of this, about
this behavior. He suggests that we change it such that an error is
generated if sve=off and there are explicitly enabled vector lengths,
e.g. '-cpu max,sve=off,sve256=on' should generate an error. It would
still be possible to have sve<N>=on and sve=off on the same command
line, as long as the sve<N>=on is followed by sve<N>=off, like this
-cpu max,sve=off,sve256=on,sve256=off,sve128=off, but I don't think
we need to worry about that sort of thing. I'll add an error for
the non-empty vector length map with SVE off case for v5.

Thanks,
drew

