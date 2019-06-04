Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F4C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4BC20859
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 17:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4BC20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCwu-0006pt-Iv
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 13:10:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCw8-0006S6-Js
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCw7-0001Nx-QO
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:09:24 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:35956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYCw7-0001MZ-Mk
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 13:09:23 -0400
Received: by mail-qk1-f182.google.com with SMTP id g18so3332477qkl.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=CgHV4HAQDmrS0Vr7HXW9J87neah4nBCQjYkHjF3J55s=;
	b=pZKFPZBHoYTfPe8vQvwdYNDHiMad0b0vlQK4LBtOcG7/JnhdTIEeQkmkYZlEm8j4Fc
	uQ5DJzXUsOjMo07YSYjK+V7vpgE88JOnD+MAY7TDT+zFu+NAAVdjRQ+FAwBnQ5ynu42U
	IPCvGBjO4NSYT2Re9cdwo4kiikohUAoznltcdetNoLSZQa/tf9RRTycS9u8d5MLgb6hG
	jNb32X35bX0DOh+j6OR/Q1QHK6QRahUWmlfLG6UU+UTHM1RSMZGav6uDf/w53K4nCMZ2
	9ZJRMEuEVQzIwnErGcN00BqcwBq1wWaWj1zsVNTuSpOVZm/1NQXA3NBCS/UeL2LtB8EB
	1cxw==
X-Gm-Message-State: APjAAAXkdAzdmq6Rs2/0CQsbMO6ln3tUHdRL+7OkrrRPz6G834QFmd23
	daF7EQC5m8gH7IWNETMPxeS+WcQsrsc=
X-Google-Smtp-Source: APXvYqxz3i8oLwfqhm01+v1y0H3QdCr3MZbdnpmvjO85BEFABqM70ij5+5Zn7H1+JQrQBuvvu3XO7Q==
X-Received: by 2002:a37:aa8e:: with SMTP id
	t136mr28745429qke.222.1559668163123; 
	Tue, 04 Jun 2019 10:09:23 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	l40sm3825986qtc.51.2019.06.04.10.09.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 10:09:22 -0700 (PDT)
Date: Tue, 4 Jun 2019 13:09:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190604130738-mutt-send-email-mst@kernel.org>
References: <20190603180807.16140-1-mst@redhat.com>
	<CAFEAcA8zMLAs6-ssLhsKBfhRECzADUzpKWw+_jgJhQz0BnxciQ@mail.gmail.com>
	<20190604122506-mutt-send-email-mst@kernel.org>
	<CAFEAcA-d9cK_SOmFV6b6koA8j=xzdknkP=g3NHgBEG2Wr4Mx6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-d9cK_SOmFV6b6koA8j=xzdknkP=g3NHgBEG2Wr4Mx6A@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.182
Subject: Re: [Qemu-devel] [PULL v2 00/14] virtio, pci, pc: cleanups, features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 05:55:36PM +0100, Peter Maydell wrote:
> On Tue, 4 Jun 2019 at 17:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> > I see. I can drop this patch for now, but I suspect this
> > means this host always produced warning and possibly
> > that the tables are all wrong.
> > Could you send me the actual and expected files please?
> > Preferably both dsl and binary.
> 
> Sure, if you can give me commands to run to do that.
> 
> thanks
> -- PMM

They are produced as part of the test.

So we have:
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-NKUU2Z.dsl,
aml:/tmp/aml-UERV2Z], Expected [asl:/tmp/asl-3ITW2Z.dsl,
aml:tests/data/acpi/q35/DSDT].

You would do something like:

tar cvzf tests.tgz /tmp/asl-NKUU2Z.dsl /tmp/aml-UERV2Z /tmp/asl-3ITW2Z.dsl tests/data/acpi/q35/DSDT

And then send the tarball.

-- 
MST

