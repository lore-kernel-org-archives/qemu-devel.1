Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 05:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9CEB21783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 05:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1gtKSao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CEB21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUldp-00070a-OJ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 00:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iUlcV-00065w-B1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iUlcU-0003j3-5L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:11 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1iUlcS-0003hj-PN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:08 -0500
Received: by mail-ot1-x334.google.com with SMTP id d5so623737otp.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=YOrfQnhBHEKGLSxFSIoYsFCZDaVZzhhq6yEyMDOqMWA=;
 b=K1gtKSaoksjaivBsAVLb/ZkTUosgvctFHUSq+6ZQ8kzkLRZsDwZbycBCtlDTRRrXTw
 Xoknhd/sK4w+gIYnFYCPca2KOMUB3PaIukZ56lrNU0YO4QfKWCW4pKdxiFEzRAPZnGJR
 KQA8J4q8eJ9EH0yTGo1D78kvLzn0kPNicNLkW2O4jbA/ynvjGXKMmb5cKrnzAbktMHhB
 kzZHeGxvDQRFuWVAeAog+XEidnlSqAYF/kkqNkCzbcAEy5VI9ydnbKDKOiCTv7f1SpWH
 tnbnXDIIKLrEjo0GmyTYg0bq35wFvFPf/4QheQhbMrYFL5YvXHRoeM1Crk5do/j4QXzA
 XATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=YOrfQnhBHEKGLSxFSIoYsFCZDaVZzhhq6yEyMDOqMWA=;
 b=NbZ+Kazli0VxeuEneW3t1SzYCD1gVL1MXTlF+JKuJaLlOOTPuJVmm0k8bs75LsBcbj
 NXaLn4gvimzLQm29r1v73DNu9rJMMz6NIqawPNO3npv2+xGA3iCsjvzVfOdZuzaVHJKA
 3ef2tcvaUl0UUHNfaV8+fZpXgzVxybu4jkh0YBloYnvIN5tBgFi9jb0VFzvZXcMbODpm
 67+U53HM2HEiOrfveKyy5kghQbYzxQ/X0giFYgcjDiEOhvADFK5fGMG+11JUftGBv+wg
 hIVwSOdaPaj1wcxRp+cAdtk/3wr40STfhxfPAyVqDAvXDdzjfFDwzQiZ/vOXKFQw9tkL
 s+jw==
X-Gm-Message-State: APjAAAW4qVcrewo+3DruUJED80ND+GJPmDFTmVihrMllESaNsMM1DBoj
 MfjY8YOnIgi2L3MhHNAX96c=
X-Google-Smtp-Source: APXvYqz4gp5u8pT85h6802ssBaj4hXGpoxNzJZj7nnggKosXVsA62emJMCaYy8fDSswTCUl6aac5+g==
X-Received: by 2002:a05:6830:54a:: with SMTP id
 l10mr1136609otb.249.1573624506453; 
 Tue, 12 Nov 2019 21:55:06 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 103sm428637otn.63.2019.11.12.21.55.05
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Nov 2019 21:55:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
References: <17da2769-1999-a0a3-590d-9f9bc6a9adc3@ozlabs.ru>
Message-ID: <157362449788.24851.9129567746458175944@sif>
User-Agent: alot/0.7
Subject: Re: virtio,iommu_platform=on
Date: Tue, 12 Nov 2019 23:54:57 -0600
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Alexey Kardashevskiy (2019-11-11 21:53:49)
> Hi!
> =

> I am enabling IOMMU for virtio in the pseries firmware (SLOF) and seeing
> problems, one of them is SLOF does SCSI bus scan, then it stops the
> virtio-scsi by clearing MMIO|IO|BUSMASTER from PCI_COMMAND (as SLOF
> stopped using the devices) and when this happens, I see unassigned
> memory access (see below) which happens because disabling busmaster
> disables IOMMU and QEMU cannot access the rings to do some shutdown. And
> when this happens, the device does not come back even if SLOF re-enables =
it.
> =

> Hacking SLOF to not clear BUSMASTER makes virtio-scsi work but it is
> hardly a right fix.

I hit the same issue enabling IOMMU for virtio-blk using this branch:

  https://github.com/mdroth/SLOF/commits/virtio-iommu

I just sent a tentative fix for QEMU as:

  "virtio-pci: disable vring processing when bus-mastering is disabled"

It's an RFC since piggy-backing off dev->broken seems a bit hacky, but
it seems to fix the issue at least.

BTW, the SLOF branch above needs cleanup, but it's booting guests okay
and I was planning to post this week. Where are you at on yours? Maybe
we should sync up...

